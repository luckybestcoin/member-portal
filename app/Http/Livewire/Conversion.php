<?php

namespace App\Http\Livewire;

use Carbon\Carbon;
use App\Models\Rate;
use App\Models\Member;
use Livewire\Component;
use App\Models\Transaction;
use Illuminate\Support\Str;
use App\Models\TransactionIncome;
use App\Models\TransactionReward;
use Illuminate\Support\Facades\DB;
use App\Models\TransactionExchange;
use App\Models\TransactionRewardPin;
use Illuminate\Support\Facades\Hash;

class Conversion extends Component
{
    public $rate, $history, $type, $amount, $percent, $lbc_amount, $lbc_price, $tx_fee, $password, $notification, $trx_reward, $trx_pinfee, $trx_exchange, $conversion = false;
    public $reward, $fee;

    protected $rules = [
        'amount' => 'required',
        'password' => 'required'
    ];

    protected $queryString = ['type'];

    public function mount()
    {
        $this->trx_reward = new TransactionReward();
        $this->trx_pinfee = new TransactionRewardPin();
        $this->trx_exchange = new TransactionExchange();
        $this->rate = new Rate();
        $this->check();
    }

    public function updated()
    {
        if ($this->type == 'pinfee') {
            $this->tx_fee = auth()->user()->contract->contract_pin_reward_exchange_fee;
        } else {
            $this->tx_fee = auth()->user()->contract->contract_reward_exchange_fee;
        }
        $this->lbc_amount = ($this->amount? $this->amount - $this->tx_fee:0) / $this->lbc_price;
    }

    public function form_reward()
    {
        $this->type = 'reward';
        $this->reset(['amount', 'percent', 'password', 'lbc_amount']);
        $this->check();
    }

    public function form_pinfee()
    {
        $this->type = 'pinfee';
        $this->reset(['amount', 'percent', 'password', 'lbc_amount']);
        $this->check();
    }

    private function check()
    {
        $this->conversion = null;
        if ($this->type == 'pinfee') {

            $last_exchange = new TransactionExchange();
            if ($last_exchange->last_pin_fee && Carbon::parse($last_exchange->last_pin_fee)->diffInDays(Carbon::now()) < 5) {
                $this->conversion = "<h3>You can only do conversion pin fee reward once every 5 days. Please try again on ".Carbon::parse($last_exchange->last_reward)->addDays(5)->format('d M Y')."</h3>";
            }
        } else {
                $last_exchange = new TransactionExchange();
                if ($last_exchange->last_reward && Carbon::parse($last_exchange->last_reward)->diffInDays(Carbon::now()) < 5) {
                    $this->conversion = "<h3>You can only do conversion reward once every 5 days. Please try again on ".Carbon::parse($last_exchange->last_reward)->addDays(5)->format('d M Y')."</h3>";
                }else {
                    if (TransactionReward::where('transaction_reward_amount', '<', 0)->where('created_at', 'like', date('Y-m-d').'%')->where('member_id', auth()->id())->get()->count() > 0) {
                        $this->conversion = "<h3>You cannot do this action more than once on the same day!!!</h3>";
                    }
                }
        }
    }

    public function set_percent($percent)
    {
        if ($this->type == 'pinfee') {
            $this->amount = $this->trx_pinfee->balance * $percent/100;
        } else {
            $this->amount = $this->trx_reward->balance * $percent/100;
        }
        $this->updated();
    }

    public function reward()
    {
        $this->validate();
        $error = null;
        $this->reset('notification');

        try {

            $this->tx_fee = auth()->user()->contract->contract_reward_exchange_fee;
            $this->lbc_amount = ((($this->amount? $this->amount - $this->tx_fee:0)) / $this->lbc_price);

            if (Str::length(auth()->user()->app_key) == 0) {
                $error .= "<li>The app key is not yet available</li>";
            }

            $trx_exchange = new TransactionExchange();
            $wd_total = $trx_exchange->total_reward;
            if ((auth()->user()->contract_price * 3) <= $wd_total) {
                $error .= "<li>Your conversion has reached the limit, please extend it</strong></li>";
            }

            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if (TransactionReward::where('transaction_reward_type', 'Conversion')->where('created_at', 'like', date('Y-m-d').'%')->where('member_id', auth()->id())->get()->count() > 0) {
                $error .= "<li>You have made a reward conversion today</li>";
            }

                $last_exchange = new TransactionExchange();
                if ($last_exchange->last_reward && Carbon::parse($last_exchange->last_reward)->diffInDays(Carbon::now()) < 5) {
                    $error .= "<li>You can only do conversion reward once every 5 days. Please try again on ".Carbon::parse($last_exchange->last_reward)->addDays(5)->format('d M Y')."</li>";
                }

            if (auth()->user()->due_date) {
                $error .= "<li>You must renew your contract</li>";
            }

            if ($this->amount > $this->trx_reward->balance) {
                $error .= "<li>Your reward is not enough to do this action</li>";
            }

            if ($this->amount > auth()->user()->contract->contract_reward_exchange_max) {
                $error .= "<li>Max. Reward to Conversion $ ". number_format(auth()->user()->contract->contract_reward_exchange_max, 2)."</li>";
            }

            if ($this->amount < auth()->user()->contract->contract_reward_exchange_min) {
                $error .= "<li>Min. Reward to Conversion $ ". number_format(auth()->user()->contract->contract_reward_exchange_min, 2)."</li>";
            }

            if ($this->lbc_amount > bitcoind()->getbalance("administrator")[0]){
                $error .= "<li>For some reason, this transaction cannot be made. Please contact the administrator</li>";
            }

            if ($error) {
                $this->reset(['amount', 'lbc_amount', 'password']);
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }
            DB::transaction(function () use($wd_total) {
                $information = "Conversion reward $ ".$this->amount." to ".$this->lbc_amount. " LBC";

                $id = bitcoind()->getaccountaddress(auth()->user()->username).date('Ymdhis').round(microtime(true) * 1000);

                $transaksi = new Transaction();
                $transaksi->transaction_id = $id;
                $transaksi->transaction_information = $information." by ".auth()->user()->member_user;
                $transaksi->save();

                $trx_reward = new TransactionReward();
                $trx_reward->transaction_reward_information = $information;
                $trx_reward->transaction_reward_type = "Conversion";
                $trx_reward->transaction_reward_amount = -$this->amount;
                $trx_reward->transaction_id = $id;
                $trx_reward->member_id = auth()->id();
                $trx_reward->save();

                $trx_exchange = new TransactionExchange();
                $trx_exchange->rate_id = $this->rate->where('rate_currency', 'USD')->orderBy('created_at', 'desc')->get()->first()->rate_id;
                $trx_exchange->transaction_exchange_type = "Reward";
                $trx_exchange->transaction_exchange_amount = $this->amount;
                $trx_exchange->transaction_id = $id;
                $trx_exchange->member_id = auth()->id();
                $trx_exchange->save();

                $income = new TransactionIncome();
                $income->transaction_income_information = "Conversion reward fee ".auth()->user()->contract->contract_reward_exchange_fee." ".auth()->user()->member_user;
                $income->transaction_income_type = "Reward Fee";
                $income->transaction_income_amount = auth()->user()->contract->contract_reward_exchange_fee;
                $income->transaction_id = $id;
                $income->save();

                if((auth()->user()->contract_price * 3) - $wd_total - $this->amount < auth()->user()->contract->contract_reward_exchange_min){
                    $member = Member::findOrFail(auth()->id());
                    $member->due_date = Carbon::now()->addDays(5)->format('Y-m-d');
                    $member->save();
                }

                bitcoind()->move("administrator", auth()->user()->username, round($this->lbc_amount, 8), 1, $information);

                $this->reset(['amount', 'password', 'lbc_amount']);
                $this->emit('done');
                return $this->notification = [
                    'tipe' => 'success',
                    'pesan' => 'Dollar conversion to LBC has been successful!!!'
                ];
            });
		} catch(\Exception $e){
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $e->getMessage()
            ];
        }
    }

    public function pinfee()
    {
        $this->validate();
        $error = null;
        $this->amount = (float)$this->amount;
        $this->reset('notification');

        try {
            $this->tx_fee = auth()->user()->contract->contract_reward_exchange_fee;
            $this->lbc_amount = ((($this->amount? $this->amount - $this->tx_fee:0)) / $this->lbc_price);

            if (Str::length(auth()->user()->app_key) == 0) {
                $error .= "<li>The app key is not yet available</li>";
            }

            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if (auth()->user()->due_date) {
                $error .= "<li>You must renew your contract</li>";
            }

            if (TransactionRewardPin::where('transaction_reward_pin_type', 'Conversion')->where('created_at', 'like', date('Y-m-d').'%')->where('member_id', auth()->id())->get()->count() > 0) {
                $error .= "<li>You have made a pin fee conversion today</li>";
            }

                $last_exchange = new TransactionExchange();
                if ($last_exchange->last_pin_fee && Carbon::parse($last_exchange->last_pin_fee)->diffInDays(Carbon::now()) < 5) {
                    $error .= "<li>You can only do conversion pin fee once every 5 days. Please try again on ".Carbon::parse($last_exchange->last_reward)->addDays(5)->format('d M Y')."</li>";
                }

            if ($this->amount > $this->trx_pinfee->balance) {
                $error .= "<li>Your pin fee is not enough to do this action</li>";
            }

            if ($this->amount > auth()->user()->contract->contract_pin_reward_exchange_max) {
                $error .= "<li>Max. Pin Fee to Conversion $ ". number_format(auth()->user()->contract->contract_pin_reward_exchange_max, 2)."</li>";
            }

            if ($this->amount < auth()->user()->contract->contract_pin_reward_exchange_fee) {
                $error .= "<li>Min. Pin Fee to Conversion $ ". number_format(auth()->user()->contract->contract_pin_reward_exchange_fee, 2)."</li>";
            }

            if ($this->lbc_amount > bitcoind()->getbalance("administrator")[0]){
                $error .= "<li>For some reason, this transaction cannot be made. Please contact the administrator</li>";
            }

            if ($error) {
                $this->reset(['amount', 'lbc_amount', 'password']);
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }
            DB::transaction(function () {
                $information = "Conversion reward $ ".$this->amount." to ".$this->lbc_amount. " LBC";

                $id = bitcoind()->getaccountaddress(auth()->user()->username).date('Ymdhis').round(microtime(true) * 1000);

                $transaksi = new Transaction();
                $transaksi->transaction_id = $id;
                $transaksi->transaction_information = $information." by ".auth()->user()->member_user;
                $transaksi->save();

                $trx_reward = new TransactionRewardPin();
                $trx_reward->transaction_reward_pin_information = $information;
                $trx_reward->transaction_reward_pin_amount = -$this->amount;
                $trx_reward->transaction_reward_pin_type = "Conversion";
                $trx_reward->transaction_id = $id;
                $trx_reward->member_id = auth()->id();
                $trx_reward->save();

                $trx_exchange = new TransactionExchange();
                $trx_exchange->rate_id = $this->rate->where('rate_currency', 'USD')->orderBy('created_at', 'desc')->get()->first()->rate_id;
                $trx_exchange->transaction_exchange_type = "Pin Fee";
                $trx_exchange->transaction_exchange_amount = $this->amount;
                $trx_exchange->transaction_id = $id;
                $trx_exchange->member_id = auth()->id();
                $trx_exchange->save();

                $income = new TransactionIncome();
                $income->transaction_income_information = "Conversion pin reward fee ".auth()->user()->contract->contract_pin_reward_exchange_fee." ".auth()->user()->member_user;
                $income->transaction_income_type = "Pin Reward Fee";
                $income->transaction_income_amount = auth()->user()->contract->contract_pin_reward_exchange_fee;
                $income->transaction_id = $id;
                $income->save();

                bitcoind()->move("administrator", auth()->user()->username, number_format($this->lbc_amount, 8), 6, $information);

                $this->reset(['amount', 'password', 'lbc_amount']);
                $this->emit('done');
                return $this->notification = [
                    'tipe' => 'success',
                    'pesan' => 'Dollar conversion to LBC has been successful!!!'
                ];
            });
		} catch(\Exception $e){
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $e->getMessage()
            ];
        }
    }

    public function render()
    {
        $this->reward = $this->trx_reward->balance;
        $this->fee = $this->trx_pinfee->balance;
        $this->lbc_price = $this->rate->last_dollar;
        $this->history = TransactionExchange::where('member_id', auth()->id())->get();
        return view('livewire.conversion')
            ->extends('livewire.main', [
                'breadcrumb' => ['Conversion'],
                'title' => 'Conversion'
            ])
            ->section('subcontent');
    }
}
