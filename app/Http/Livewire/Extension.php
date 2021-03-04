<?php

namespace App\Http\Livewire;

use App\Models\Rate;
use Livewire\Component;
use App\Models\Exchange;
use App\Models\Transaction;
use App\Models\TransactionPin;
use App\Models\TransactionReward;
use Illuminate\Support\Facades\DB;
use App\Models\TransactionExchange;
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
        $this->lbc_amount = auth()->user()->contract_price/$this->rate->last_dollar;
    }

    public function submit()
    {
        $this->validate();
        $this->lbc_amount = auth()->user()->contract_price/$this->rate->last_dollar;
        $pin = new TransactionPin();
        try {
            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if ($pin->balance < auth()->user()->contract->contract_pin) {
                $error .= "<li>Not enough <strong>PIN".($this->contract_pin == 1?:"s")."</strong></li>";
            }

            if ($this->lbc_amount > bitcoind()->getbalance(auth()->user()->member_user)[0]){
                $error .= "<li>Account has insufficient funds.</li>";
            }

            $trx_exchange = new TransactionExchange();
            if ((auth()->user()->contract_price * 3) - $trx_exchange->total > auth()->user()->contract->contract_reward_exchange_min){
                $error .= "<li>You have the remaining conversion</li>";
            }

            if ($error) {
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }
            DB::transaction(function () use ($pin) {
                $information = "Extension on behalf of ".$this->email;
                $id = auth()->user()->wallet->wallet_address.date('Ymdhis').round(microtime(true) * 1000);

                TransactionExchange::where('member_id', auth()->id())->delete();
                auth()->user()->update([
                    'extension' => auth()->user()->extension + 1,
                    'due_date' => null
                    ]);

                $exchange = new Exchange();
                $exchange->contract_id = auth()->user()->contract_id;
                $exchange->member_id = auth()->id();
                $exchange->save();

                $transaction = new Transaction();
                $transaction->transaction_id = $id;
                $transaction->transaction_information = $information;
                $transaction->save();

                $pin->transaction_pin_information = $information;
                $pin->transaction_pin_amount = -auth()->user()->contract->contract_pin;
                $pin->transaction_id = $id;
                $pin->member_id = auth()->id();
                $pin->save();

                $bagi_hasil = new TransactionReward();
                $bagi_hasil->transaction_reward_information = $information;
                $bagi_hasil->transaction_reward_type = "Referral";
                $bagi_hasil->transaction_reward_amount = auth()->user()->contract_price * 10 /100;
                $bagi_hasil->transaction_id = $id;
                $bagi_hasil->member_id = auth()->user()->member_parent;
                $bagi_hasil->save();

                bitcoind()->move(auth()->user()->member_user, "administrator", number_format($this->lbc_amount, 8), 6, $information);


                $this->setParent(Member::with('parent')->with('rating')->with('invalid_left_turnover')->with('invalid_right_turnover')->select("member_id", "member_email", "member_user", "member_parent", "member_position", "rating_id", "contract_price", "member_network", "due_date", "deleted_at",
                DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ki")))=concat(member.member_id, "ki") ) left_turnover'),
                DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ka")))=concat(member.member_id, "ka") ) right_turnover'))->where('member_id', $aut()->id())->first());
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
