<?php

namespace App\Http\Livewire\Saldo\Topup;

use App\Models\Pin;
use App\Models\Saldo;
use Livewire\Component;
use App\Models\Transaksi;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Form extends Component
{
    public $amount, $password, $back, $failed;

    protected $rules = [
        'amount' => 'numeric',
        'password' => 'required'
    ];
    function btcid_query($method, array $req = array()) {
        // API settings
        $key = 'EHEDCRAE-GLWOV1PB-SPAGXZAX-8PCN2MZU-AKBPEXCG'; // your API-key
        $secret = '9b43c7afcc42b9591843cfab606708c41ae2cee4db7f7f766551d1d8a37d428464e5bb964dff5af1'; // your Secret-key
        $req['method'] = $method;
        $req['nonce'] = time();

        // generate the POST data string
        $post_data = http_build_query($req, '', '&');
        $sign = hash_hmac('sha512', $post_data, $secret);
        // generate the extra headers
        $headers = array(
       'Sign: '.$sign,
       'Key: '.$key,
        );
        // our curl handle (initialize if required)
        static $ch = null;
        if (is_null($ch)) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/4.0 (compatible;
       INDODAXCOM PHP client; '.php_uname('s').'; PHP/'.phpversion().')');
        }
        curl_setopt($ch, CURLOPT_URL, 'https://indodax.com/tapi?method=transHistory');
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        // for php version 7.2
        curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
        // run the query
        $res = curl_exec($ch);
        if ($res === false) throw new Exception('Could not get reply:
       '.curl_error($ch));
        $dec = json_decode($res, true);
        if (!$dec) throw new Exception('Invalid data received, please make sure
       connection is working and requested API exists: '.$res);

        curl_close($ch);
        $ch = null;
        return $dec;
    }
    public function mount()
    {
        $result = $this->btcid_query('transHistory');
        dd($result);

        $this->harga_tiket = config("constant.harga_tiket");
        $this->back = Str::contains(url()->previous(), ['tambah', 'edit'])? '/network/registration': url()->previous();
    }

    public function submit()
    {
        $this->validate();

        if(Hash::check($this->password, auth()->user()->anggota_kata_sandi) === false){
            return $this->failed = "<li>Wrong <strong>password</strong></li>";
        }

        $saldo = new Saldo();
        $pin = new Pin();

        $this->reset('failed');

        if ($saldo->terakhir < $this->harga_tiket * $this->amount) {
            $this->failed = "<li>Insufficient <strong>balance</strong></li>";
        }
        if ($this->failed) {
            return $this->failed;
        }

        DB::transaction(function () use($saldo, $pin) {
            $keterangan = "Buy ".$this->amount." registration ticket";

            $id = Str::random(10)."-".date('Ymdhis').round(microtime(true) * 1000);

            $transaksi = new Transaksi();
            $transaksi->transaksi_id = $id;
            $transaksi->transaksi_keterangan = $keterangan."  by ".auth()->user()->anggota_uid;
            $transaksi->save();

            $saldo->saldo_keterangan = $keterangan;
            $saldo->saldo_debit = $this->harga_tiket * $this->amount;
            $saldo->saldo_kredit = 0;
            $saldo->transaksi_id = $id;
            $saldo->anggota_id = auth()->id();
            $saldo->save();

            $pin->pin_keterangan = $keterangan;
            $pin->pin_debit = 0;
            $pin->pin_kredit = $this->amount;
            $pin->transaksi_id = $id;
            $pin->anggota_id = auth()->id();
            $pin->save();
        });

        $this->reset(['amount', 'password']);
    }

    public function render()
    {
        return view('livewire.saldo.topup.form')
            ->extends('livewire.main', [
                'breadcrumb' => ['Balance', 'Top Up'],
                'title' => 'Top Up Balance',
                'description' => 'Top Up Balance'
            ])
            ->section('subcontent');
    }
}
