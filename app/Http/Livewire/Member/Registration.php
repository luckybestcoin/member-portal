<?php

namespace App\Http\Livewire\Member;

use Carbon\Carbon;
use App\Models\Rate;
use App\Models\Member;
use App\Models\Reward;
use App\Models\Country;
use App\Models\Referal;
use Livewire\Component;
use App\Models\Contract;
use App\Models\Referral;
use App\Models\Peringkat;
use App\Models\Achievement;
use App\Models\Transaction;
use Illuminate\Support\Str;
use App\Mail\RegistrasiEmail;
use App\Models\TransactionPin;
use App\Models\TransactionReward;
use App\Models\TransactionBalance;
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
        $this->updated();
        $this->referral = $referral;
    }

    public function setCountry($country)
    {
        $this->updated();
        $this->country = $country;
        $country_filter = $this->country_data->where('country_id', $country)->first();
        $this->country_code = $country_filter['country_code'];
    }

    public function setContract($contract)
    {
        $this->updated();
        if ($contract) {
            $this->contract = $contract;
            $contract_filter = $this->contract_data->where('contract_id', $contract)->first();
            $this->contract_price = $contract_filter['contract_price'];
            $this->contract_pin = $contract_filter['contract_pin'];
            $this->contract_name = $contract_filter['contract_name'];
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
        $this->member_data = Member::whereNotNull('member_password')->where('member_network', 'like', auth()->user()->member_network.auth()->id().'%')->get();
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
            if($this->turnover < 0 || $this->turnover > 1){
                $error .= "<li>Turnover position not available</li>";
            }
            if ($this->lbc_amount > bitcoind()->getbalance(auth()->user()->member_email)[0]){
                $error .= "<li>Account has insufficient funds.</li>";
            }
            if ($pin->balance < $this->contract_pin) {
                $error .= "<li>Not enough <strong>PIN".($this->contract_pin == 1?:"s")."</strong></li>";
            }
            if (Member::where('member_email', $this->email)->count() > 0){
                $error .= "<li>The email address <strong>".$this->email."</strong> is already registered</li>";
            }
            if (Member::where('member_phone', $this->phone_number)->count() > 0){
                $error .= "<li>The phone nomber <strong>".$this->phone_number."</strong> is already registered</li>";
            }
            if ($error) {
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }

            DB::transaction(function () use ($pin) {
                $information = "Member registration on behalf of ".$this->name;
                $id = auth()->user()->wallet->wallet_address.date('Ymdhis').round(microtime(true) * 1000);

                $transaction = new Transaction();
                $transaction->transaction_id = $id;
                $transaction->transaction_information = $information." by ".auth()->user()->member_email;
                $transaction->save();

                $pin->transaction_pin_information = $information;
                $pin->transaction_pin_amount = -$this->contract_pin;
                $pin->transaction_id = $id;
                $pin->member_id = auth()->id();
                $pin->save();

                $member = new Member();
                $member->member_name = $this->name;
                $member->member_email = $this->email;
                $member->country_id = $this->country;
                $member->contract_id = $this->contract;
                $member->contract_price = $this->contract_price;
                $member->member_phone = $this->country_code.$this->phone_number;
                $member->member_position = $this->turnover;
                $member->member_parent = $this->referral;
                $member->member_network = auth()->user()->member_network.auth()->id().($this->turnover == 0? 'ki': 'ka');
                $member->save();

                $referal = new Referral();
                $referal->referral_token = Str::random(40).$member->member_id;
                $referal->member_id = $member->member_id;
                $referal->save();

                $bagi_hasil = new TransactionReward();
                $bagi_hasil->transaction_reward_information = $information;
                $bagi_hasil->transaction_reward_type = "Referral";
                $bagi_hasil->transaction_reward_amount = $this->contract_price * 10 /100;
                $bagi_hasil->transaction_id = $id;
                $bagi_hasil->member_id = auth()->id();
                $bagi_hasil->save();

                bitcoind()->move(auth()->user()->member_email, "administrator", number_format($this->lbc_amount, 8), 6, $information);

                Mail::send('email.registrasi', [
                    'token' => $referal->referal_token,
                    'name' => $this->name,
                    'contract' => $this->contract,
                    'email' => $this->email
                ], function($message) {
                    $message->to($this->email, $this->name)->subject
                        ('Lucky Best Coin Registration Referral Code');
                    $message->from('no-reply@luckybestcoin.com', 'Admin LBC');
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
