<?php

namespace App\Http\Livewire;

use App\Models\Rate;
use Livewire\Component;
use App\Models\Transaction;
use App\Models\TransactionReward;
use Illuminate\Support\Facades\DB;
use App\Models\TransactionRewardPin;
use Illuminate\Support\Facades\Hash;

class Conversion extends Component
{
    public $rate, $type, $amount, $percent, $lbc_amount, $lbc_price, $tx_fee, $password, $notification, $trx_reward, $trx_pinfee, $exchange = false;
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
        $this->exchange = false;
        if ($this->type == 'pinfee') {
            if (TransactionRewardPin::where('transaction_reward_pin_amount', '<', 0)->where('created_at', 'like', date('Y-m-d').'%')->where('member_id', auth()->id())->get()->count() > 0) {
                dd('tes');
                $this->exchange = true;
            }
        } else {
            if (TransactionReward::where('transaction_reward_amount', '<', 0)->where('created_at', 'like', date('Y-m-d').'%')->where('member_id', auth()->id())->get()->count() > 0) {
                $this->exchange = true;
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
        $this->amount = (float)$this->amount;
        $this->reset('notification');

        try {
            $this->tx_fee = auth()->user()->contract->contract_reward_exchange_fee;
            $this->lbc_amount = ((($this->amount? $this->amount - $this->tx_fee:0)) / $this->lbc_price);

            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if (TransactionReward::where('transaction_reward_type', 'Conversion')->where('created_at', 'like', date('Y-m-d').'%')->where('member_id', auth()->id())->get()->count() > 0) {
                $error .= "<li>You have made a reward exchange today</li>";
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

            if ($this->lbc_amount > bitcoind()->getbalance(config("constant.admin_email"))[0]){
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

                $id = auth()->user()->wallet->wallet_address.date('Ymdhis').round(microtime(true) * 1000);

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

                bitcoind()->move("administrator", auth()->user()->member_user, number_format($this->lbc_amount, 8), 6, $information);

                $this->reset(['amount', 'password', 'lbc_amount']);
                $this->emit('done');
                return $this->notification = [
                    'tipe' => 'success',
                    'pesan' => 'Dollar exchange to LBC has been successful!!!'
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

            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if (TransactionRewardPin::where('transaction_reward_pin_type', 'Conversion')->where('created_at', 'like', date('Y-m-d').'%')->where('member_id', auth()->id())->get()->count() > 0) {
                $error .= "<li>You have made a pin fee exchange today</li>";
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

            if ($this->lbc_amount > bitcoind()->getbalance(config("constant.admin_email"))[0]){
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

                $id = auth()->user()->wallet->wallet_address.date('Ymdhis').round(microtime(true) * 1000);

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

                bitcoind()->move("administrator", auth()->user()->member_user, number_format($this->lbc_amount, 8), 6, $information);

                $this->reset(['amount', 'password', 'lbc_amount']);
                $this->emit('done');
                return $this->notification = [
                    'tipe' => 'success',
                    'pesan' => 'Dollar exchange to LBC has been successful!!!'
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

        return view('livewire.conversion')
            ->extends('livewire.main', [
                'breadcrumb' => ['Conversion'],
                'title' => 'Conversion'
            ])
            ->section('subcontent');
    }
}
