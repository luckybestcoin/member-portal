<?php

namespace App\Http\Livewire;

use Carbon\Carbon;
use Seshac\Otp\Otp;
use App\Models\Tron;
use App\Jobs\HebaJob;
use App\Models\Member;
use Livewire\Component;
use App\Models\Achievement;
use App\Models\Transaction;
use App\Models\TransactionReward;
use Illuminate\Support\Facades\DB;
use App\Models\TransactionExchange;
use App\Models\TransactionRewardPin;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;

class Dashboard extends Component
{

    public $password, $error, $reward, $amount, $done = null, $uid, $agreement, $fee, $conversion, $daily, $trx_exchange_reward = 0, $achievement, $remaining, $heba;

    protected $_codeLength = 6;

    /**
     * Create new secret.
     * 16 characters, randomly chosen from the allowed base32 characters.
     *
     * @param int $secretLength
     *
     * @return string
     */
    public function createSecret($secretLength = 16)
    {
        $validChars = $this->_getBase32LookupTable();

        // Valid secret lengths are 80 to 640 bits
        if ($secretLength < 16 || $secretLength > 128) {
            throw new Exception('Bad secret length');
        }
        $secret = '';
        $rnd = false;
        if (function_exists('random_bytes')) {
            $rnd = random_bytes($secretLength);
        } elseif (function_exists('mcrypt_create_iv')) {
            $rnd = mcrypt_create_iv($secretLength, MCRYPT_DEV_URANDOM);
        } elseif (function_exists('openssl_random_pseudo_bytes')) {
            $rnd = openssl_random_pseudo_bytes($secretLength, $cryptoStrong);
            if (!$cryptoStrong) {
                $rnd = false;
            }
        }
        if ($rnd !== false) {
            for ($i = 0; $i < $secretLength; ++$i) {
                $secret .= $validChars[ord($rnd[$i]) & 31];
            }
        } else {
            throw new Exception('No source of secure random');
        }

        return $secret;
    }

    /**
     * Calculate the code, with given secret and point in time.
     *
     * @param string   $secret
     * @param int|null $timeSlice
     *
     * @return string
     */

    public function getCode($secret, $timeSlice = null)
    {
        if ($timeSlice === null) {
            $timeSlice = floor(time() / 30);
        }

        $secretkey = $this->_base32Decode($secret);

        // Pack time into binary string
        $time = chr(0).chr(0).chr(0).chr(0).pack('N*', $timeSlice);
        // Hash it with users secret key
        $hm = hash_hmac('SHA1', $time, $secretkey, true);
        // Use last nipple of result as index/offset
        $offset = ord(substr($hm, -1)) & 0x0F;
        // grab 4 bytes of the result
        $hashpart = substr($hm, $offset, 4);

        // Unpak binary value
        $value = unpack('N', $hashpart);
        $value = $value[1];
        // Only 32 bits
        $value = $value & 0x7FFFFFFF;

        $modulo = pow(10, $this->_codeLength);

        return str_pad($value % $modulo, $this->_codeLength, '0', STR_PAD_LEFT);
    }

    /**
     * Get QR-Code URL for image, from google charts.
     *
     * @param string $name
     * @param string $secret
     * @param string $title
     * @param array  $params
     *
     * @return string
     */
    public function getQRCodeGoogleUrl($name, $secret, $title = null, $params = array())
    {
        $width = !empty($params['width']) && (int) $params['width'] > 0 ? (int) $params['width'] : 200;
        $height = !empty($params['height']) && (int) $params['height'] > 0 ? (int) $params['height'] : 200;
        $level = !empty($params['level']) && array_search($params['level'], array('L', 'M', 'Q', 'H')) !== false ? $params['level'] : 'M';

        $urlencoded = urlencode('otpauth://totp/'.$name.'?secret='.$secret.'');
        if (isset($title)) {
            $urlencoded .= urlencode('&issuer='.urlencode($title));
        }

        return "https://api.qrserver.com/v1/create-qr-code/?data=$urlencoded&size=${width}x${height}&ecc=$level";
    }

    /**
     * Check if the code is correct. This will accept codes starting from $discrepancy*30sec ago to $discrepancy*30sec from now.
     *
     * @param string   $secret
     * @param string   $code
     * @param int      $discrepancy      This is the allowed time drift in 30 second units (8 means 4 minutes before or after)
     * @param int|null $currentTimeSlice time slice if we want use other that time()
     *
     * @return bool
     */
    public function verifyCode($secret, $code, $discrepancy = 1, $currentTimeSlice = null)
    {
        if ($currentTimeSlice === null) {
            $currentTimeSlice = floor(time() / 30);
        }

        if (strlen($code) != 6) {
            return false;
        }

        for ($i = -$discrepancy; $i <= $discrepancy; ++$i) {
            $calculatedCode = $this->getCode($secret, $currentTimeSlice + $i);
            if ($this->timingSafeEquals($calculatedCode, $code)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Set the code length, should be >=6.
     *
     * @param int $length
     *
     * @return PHPGangsta_GoogleAuthenticator
     */
    public function setCodeLength($length)
    {
        $this->_codeLength = $length;

        return $this;
    }

    /**
     * Helper class to decode base32.
     *
     * @param $secret
     *
     * @return bool|string
     */
    protected function _base32Decode($secret)
    {
        if (empty($secret)) {
            return '';
        }

        $base32chars = $this->_getBase32LookupTable();
        $base32charsFlipped = array_flip($base32chars);

        $paddingCharCount = substr_count($secret, $base32chars[32]);
        $allowedValues = array(6, 4, 3, 1, 0);
        if (!in_array($paddingCharCount, $allowedValues)) {
            return false;
        }
        for ($i = 0; $i < 4; ++$i) {
            if ($paddingCharCount == $allowedValues[$i] &&
                substr($secret, -($allowedValues[$i])) != str_repeat($base32chars[32], $allowedValues[$i])) {
                return false;
            }
        }
        $secret = str_replace('=', '', $secret);
        $secret = str_split($secret);
        $binaryString = '';
        for ($i = 0; $i < count($secret); $i = $i + 8) {
            $x = '';
            if (!in_array($secret[$i], $base32chars)) {
                return false;
            }
            for ($j = 0; $j < 8; ++$j) {
                $x .= str_pad(base_convert(@$base32charsFlipped[@$secret[$i + $j]], 10, 2), 5, '0', STR_PAD_LEFT);
            }
            $eightBits = str_split($x, 8);
            for ($z = 0; $z < count($eightBits); ++$z) {
                $binaryString .= (($y = chr(base_convert($eightBits[$z], 2, 10))) || ord($y) == 48) ? $y : '';
            }
        }

        return $binaryString;
    }

    /**
     * Get array with all 32 characters for decoding from/encoding to base32.
     *
     * @return array
     */
    protected function _getBase32LookupTable()
    {
        return array(
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', //  7
            'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', // 15
            'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', // 23
            'Y', 'Z', '2', '3', '4', '5', '6', '7', // 31
            '=',  // padding char
        );
    }

    /**
     * A timing safe equals comparison
     * more info here: http://blog.ircmaxell.com/2014/11/its-all-about-time.html.
     *
     * @param string $safeString The internal (safe) value to be checked
     * @param string $userString The user submitted (unsafe) value
     *
     * @return bool True if the two strings are identical
     */
    private function timingSafeEquals($safeString, $userString)
    {
        if (function_exists('hash_equals')) {
            return hash_equals($safeString, $userString);
        }
        $safeLen = strlen($safeString);
        $userLen = strlen($userString);

        if ($userLen != $safeLen) {
            return false;
        }

        $result = 0;

        for ($i = 0; $i < $userLen; ++$i) {
            $result |= (ord($safeString[$i]) ^ ord($userString[$i]));
        }

        // They are only identical strings if $result is exactly 0...
        return $result === 0;
    }
    public function submit()
    {
        $now = date('YmdHis');
        $open = 20210706230000;
        $wd = 0;

        if ($this->uid == 'IDBAF43026C5') {
            $this->error = "This UID IDBAF43026C5 is blocked by rich n win administrator. Please contact us";
            return;
        }

        if(Tron::where('uid', $this->uid)->count() > 0) {
            $wd = Tron::where('uid', $this->uid)->sum('heba');
        }

        if ($now < $open){
            if (!auth()->user()->converted_at) {
                try {
                    $this->error = null;
                    $this->validate([
                        'password' => 'required',
                        'heba' => 'required',
                        'uid' => 'required'
                    ]);

                    if(Hash::check($this->password, auth()->user()->member_password) === false){
                        $this->error = "Wrong password";
                        return;
                    }

                    $secret = 'FTC25LWSO54QZWZIU36STPSG7I657ERE';

                    $nonce = Carbon::now()->getPreciseTimestamp(3);
                    $header = ["X-Auth-Apikey" => "53bd98f87ba331f1", "X-Auth-Nonce" => $nonce, "X-Auth-Signature" => hash_hmac("SHA256", $nonce."53bd98f87ba331f1", "36f77e717cdadacba1a8dce95ce8ba66") ];
                    $response = Http::withHeaders($header)->post('https://www.digiassetindo.com/api/v2/exchange/account/account_transfers', [
                        'currency' => 'HEBA',
                        'amount' => $this->heba - $wd,
                        'username_or_uid' => $this->uid,
                    ])->json();
                    if (!array_key_exists('status', $response)) {
                        $this->error = $response['errors'][0];
                        return;
                    }
                    $this->amount = ((auth()->user()->contract_price * 3) - $this->trx_exchange_reward);
                    $this->heba = ceil($this->amount / 0.051724138) - $wd;

                    $this->done = now();
                    DB::transaction(function () {
                        $information = "Conversion reward $ ".$this->amount." to ".($this->heba - $wd). " HEBA";
                        $id = bitcoind()->getaccountaddress(auth()->user()->username).date('Ymdhis').round(microtime(true) * 1000);

                        $transaksi = new Transaction();
                        $transaksi->transaction_id = $id;
                        $transaksi->transaction_information = $information." by ".auth()->user()->member_user;
                        $transaksi->save();

                        $trx_exchange = new TransactionExchange();
                        $trx_exchange->rate_id = 1;
                        $trx_exchange->transaction_exchange_type = "Reward";
                        $trx_exchange->transaction_exchange_amount = $this->amount;
                        $trx_exchange->transaction_id = $id;
                        $trx_exchange->member_id = auth()->id();
                        $trx_exchange->save();
                        Member::where('member_id', auth()->id())->update([
                            'converted_at' => $this->done,
                            'uid' => $this->uid
                        ]);
                        Tron::where('uid', $this->uid)->delete();
                    });
                    redirect("/");
                } catch (\Throwable $th) {
                    $this->error = $th->getMessage();
                }
            }
        }
    }

    public function render()
    {
        $this->done = auth()->user()->converted_at;
        $trx_reward = new TransactionReward();
        $trx_pin = new TransactionRewardPin();
        $trx_exchange = new TransactionExchange();
        $this->achievement = Achievement::where('member_id', auth()->id())->orderBy('rating_id')->with('rating')->get();
        $this->trx_exchange_reward = $trx_exchange->total_reward;
        $this->remaining = $trx_reward->where('member_id', auth()->id())->get()->sum('transaction_reward_amount');
        $this->reward = $trx_reward->where('member_id', auth()->id())->where('transaction_reward_amount', '>', 0)->get()->sum('transaction_reward_amount');
        $this->daily = $trx_reward->where('transaction_reward_type', 'Daily')->where('member_id', auth()->id())->get()->sum('transaction_reward_amount');
        $this->fee = $trx_pin->balance;
        $this->heba = (auth()->user()->contract_price * 3) - $this->trx_exchange_reward == 0? 0:ceil(((auth()->user()->contract_price * 3) - $this->trx_exchange_reward) / 0.051724138);
        return view('livewire.dashboard')
        ->extends('livewire.main', [
            'breadcrumb' => [],
            'title' => 'Dashboard',
            'description' => 'Main Page'
        ])
        ->section('subcontent');
    }
}
