<?php

namespace App\Http\Livewire;

use App\Models\Rate;
use Livewire\Component;
use App\Models\TransactionReward;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Extension extends Component
{
    public $name, $contract, $country, $referral, $phone_number, $email, $turnover, $back, $notification, $contract_pin, $contract_name, $country_code, $rate, $contract_price = 0, $lbc_amount = 0;

    protected $rules = [
        'password' => 'required'
    ];

    public function mount()
    {
        $this->rate = new Rate();
        $this->lbc_amount = aut()->user()->contract_price/$this->rate->last_dollar;
    }

    public function submit()
    {
        $this->validate();
        $this->lbc_amount = aut()->user()->contract_price/$this->rate->last_dollar;
        try {
            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if ($this->lbc_amount > bitcoind()->getbalance(auth()->user()->member_user)[0]){
                $error .= "<li>Account has insufficient funds.</li>";
            }

            $trx_reward = new TransactionReward();
            if ((auth()->user()->contract_price * 3) - ($trx_reward->converted * -1) > auth()->user()->contract->contract_reward_exchange_min){
                $error .= "<li>You have the remaining conversion</li>";
            }

            if ($error) {
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }
            DB::transaction(function () {
                TransactionReward::where('member_id', auth()->id())->delete();
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
        return view('livewire.extension')
            ->extends('livewire.main', [
                'breadcrumb' => ['Extension'],
                'title' => 'Extension'
            ])
            ->section('subcontent');
    }
}
