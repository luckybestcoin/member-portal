<?php

namespace App\Http\Livewire\Member;

use Carbon\Carbon;
use App\Models\Rate;
use App\Models\Member;
use App\Models\Country;
use Livewire\Component;
use App\Models\Contract;
use App\Models\Referral;
use App\Models\Transaction;
use Illuminate\Support\Str;
use App\Models\TransactionPin;
use App\Models\TransactionReward;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class Registration extends Component
{
    public $name, $contract, $country, $referral, $phone_number, $email, $turnover, $back, $notification, $contract_pin, $contract_name, $country_code, $rate, $contract_price = 0, $lbc_amount = 0;

    public $country_data = [], $contract_data = [], $member_data = [];

    protected $rules = [
        'name' => 'required',
        'contract' => 'required',
        'turnover' => 'required',
        'referral' => 'required',
        'email' => 'required|email',
        'phone_number' => 'required|min:9',
        'country' => 'required'
    ];

    protected $listeners = [
        'set:setreferral' => 'setReferral',
        'set:setcontract' => 'setContract',
        'set:setcountry' => 'setCountry'
    ];

    public function setReferral($referral)
    {
        $this->referral = $referral;
        $this->updated();
    }

    public function setCountry($country)
    {
        $this->country_code = $country;
    }

    public function setContract($contract)
    {
        $this->updated();
        if ($contract) {
            $this->contract = $contract;
            $this->lbc_amount = $this->contract_price/$this->rate->last_dollar;
        } else {
            $this->reset(['contract']);
        }
    }

    public function updated()
    {
        $this->emit('reinitialize');
        $this->reset('notification');
    }

    public function mount()
    {
        $this->updated();
        $this->rate = new Rate();
        $this->referral = auth()->id();
        $this->back = Str::contains(url()->previous(), ['tambah', 'edit'])? '/Member/registration': url()->previous();
        $this->country_data = Country::orderBy('country_name')->get();
        $this->contract_data = Contract::all();
        $this->member_data = Member::whereNotNull('member_password')->get();
    }

    public function countryChanged()
    {
        $this->showTable = 1;
    }

    public function submit()
    {
        $this->emit('reinitialize');
        $this->validate();

        $pin = new TransactionPin();

        $this->reset('notification');
        $error = null;

        $this->lbc_amount = $this->contract_price/$this->rate->last_dollar;

        try{
            if (Str::length(auth()->user()->app_key) == 0) {
                $error .= "<li>The app key is not yet available</li>";
            }

            if($this->turnover < 0 || $this->turnover > 1){
                $error .= "<li>Turnover position not available</li>";
            }
            if ($this->lbc_amount > bitcoind()->getbalance(auth()->user()->username)[0]){
                $error .= "<li>Account has insufficient funds.</li>";
            }
            if ($pin->balance < $this->contract_pin) {
                $error .= "<li>Not enough <strong>PIN".($this->contract_pin == 1?:"s")."</strong></li>";
            }
            if ($error) {
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }

            DB::transaction(function () use ($pin) {
                $contract_filter = $this->contract_data->where('contract_id', $this->contract)->first();
                $this->contract_pin = $contract_filter['contract_pin'];

                $information = "Member registration on behalf of ".$this->email;
                $id = bitcoind()->getaccountaddress(auth()->user()->username).date('Ymdhis').round(microtime(true) * 1000);

                $transaction = new Transaction();
                $transaction->transaction_id = $id;
                $transaction->transaction_information = $information." by ".auth()->user()->member_user;
                $transaction->save();

                $pin->transaction_pin_information = $information;
                $pin->transaction_pin_amount = -$this->contract_pin;
                $pin->transaction_id = $id;
                $pin->member_id = auth()->id();
                $pin->save();

                $network = Member::findOrFail($this->referral);

                $member = new Member();
                $member->member_name = $this->name;
                $member->member_email = $this->email;
                $member->country_id = $this->country;
                $member->contract_id = $this->contract;
                $member->contract_price = $this->contract_price;
                $member->member_phone = $this->country_code.$this->phone_number;
                $member->member_position = $this->turnover;
                $member->member_parent = $network->member_id;
                $member->member_network = $network->member_network.$network->member_id.($this->turnover == 0? 'ki': 'ka');
                $member->save();

                $referral = new Referral();
                $referral->referral_token = Str::random(40).$member->member_id;
                $referral->member_id = $member->member_id;
                $referral->save();

                $bagi_hasil = new TransactionReward();
                $bagi_hasil->transaction_reward_information = $information;
                $bagi_hasil->transaction_reward_type = "Referral";
                $bagi_hasil->transaction_reward_amount = $this->contract_price * 10 /100;
                $bagi_hasil->transaction_id = $id;
                $bagi_hasil->member_id = $network->member_id;
                $bagi_hasil->save();

                bitcoind()->move(auth()->user()->username, "administrator", round($this->lbc_amount, 8), 1, $information);

                Mail::send('email.registration', [
                    'token' => $referral->referral_token,
                    'name' => $this->name,
                    'contract' => $this->contract,
                    'email' => $this->email
                ], function($message) {
                    $message->to($this->email, $this->name)->subject
                        ('Lucky Best Coin Registration Referral Code');
                    $message->from('no-reply@luckybestcoin.net', 'Admin LBC');
                });
            });

            $this->updated();
            $this->notification = [
                'tipe' => 'success',
                'pesan' => 'New member registration is successful. An email has been sent to '.$this->email
            ];
            return $this->reset(['name', 'email', 'country', 'contract', 'phone_number', 'turnover', 'lbc_amount']);
        } catch(\Exception $e){
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $e->getMessage()
            ];
        }
    }

    public function render()
    {
        return view('livewire.member.registration')
            ->extends('livewire.main', [
                'breadcrumb' => ['Member', 'Registration'],
                'title' => 'Registration',
                'description' => 'Registration new member'
            ])
            ->section('subcontent');
    }
}
