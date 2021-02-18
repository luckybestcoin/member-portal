<?php

namespace App\Http\Livewire\Member;

use Carbon\Carbon;
use App\Models\TransactionPin;
use App\Models\Contract;
use App\Models\TransactionBalance;
use App\Models\Country;
use App\Models\Member;
use App\Models\Referal;
use Livewire\Component;
use App\Models\Reward;
use App\Models\Peringkat;
use App\Models\Transaction;
use App\Models\Achievement;
use Illuminate\Support\Str;
use App\Mail\RegistrasiEmail;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class Registration extends Component
{
    public $name, $contract, $country, $referral, $phone_number, $email, $turnover, $back, $notification, $contract_cost, $contract_ticket, $contract_name, $country_code;

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
            $this->contract_cost = $contract_filter['contract_cost'];
            $this->contract_ticket = $contract_filter['contract_pin'];
            $this->contract_name = $contract_filter['contract_name'];
        } else {
            $this->reset(['contract']);
        }
    }

    public function updated()
    {
        $this->emit('reinitialize');
        $this->notification = null;
    }

    public function mount()
    {
        $this->updated();
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

        $transaction_balance = new TransactionBalance();
        $pin = new TransactionPin();

        $this->reset('notification');
        $error = null;

        if($this->turnover < 0 || $this->turnover > 1){
            $error .= "<li>Turnover position not available</li>";
        }
        // if ($transaction_balance->terakhir < $this->contract_cost) {
        //     $error .= "<li>Insufficient <strong>LBC balance</strong></li>";
        // }
        // if ($pin->terakhir < $this->contract_ticket) {
        //     $error .= "<li>Not enough <strong>activation tickets</strong></li>";
        // }
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

        DB::transaction(function () use ($transaction_balance, $pin) {
            $information = "Member registration on behalf of ".$this->name;
            $id = Str::random(10)."-".date('Ymdhis').round(microtime(true) * 1000);

            $transaction = new Transaction();
            $transaction->transaction_id = $id;
            $transaction->transaction_information = $information." by ".auth()->user()->member_email;
            $transaction->save();

            $transaction_balance->transaction_balance_information = $information;
            $transaction_balance->transaction_balance_amount = -$this->contract_cost;
            $transaction_balance->transaction_id = $id;
            $transaction_balance->member_id = auth()->id();
            $transaction_balance->save();

            $pin->pin_information = $information;
            $pin->pin_debit = $this->contract_ticket;
            $pin->pin_kredit = 0;
            $pin->transaction_id = $id;
            $pin->member_id = auth()->id();
            $pin->save();

            $member = new Member();
            $member->member_name = $this->name;
            $member->member_email = $this->email;
            $member->country_id = $this->country;
            $member->contract_id = $this->contract;
            $member->contract_harga = $this->contract_cost;
            $member->member_phone = $this->$country_code.$this->phone_number;
            $member->member_posisi = $this->turnover;
            $member->member_parent = $this->referral;
            $member->member_network = auth()->user()->member_network.auth()->id().($this->turnover == 0? 'ki': 'ka');
            $member->save();

            $referal = new Referal();
            $referal->referal_token = Str::random(40).$member->member_id;
            $referal->member_id = $member->member_id;
            $referal->save();

            $bagi_hasil = new Reward();
            $bagi_hasil->bagi_hasil_information = $information;
            $bagi_hasil->bagi_hasil_jenis = "Referral";
            $bagi_hasil->bagi_hasil_debit = 0;
            $bagi_hasil->bagi_hasil_kredit = $this->contract_cost * 10 /100;
            $bagi_hasil->transaction_id = $id;
            $bagi_hasil->member_id = auth()->id();
            $bagi_hasil->save();

            Mail::send('email.registrasi', [
                'token' => $referal->referal_token,
                'name' => $this->name,
                'contract' => $this->contract,
                'email' => $this->email
            ], function($message) {
                $message->to($this->email, $this->name)->subject
                    ('Lucky BIT Registration Referral Code');
                $message->from('no-reply@luckybit.id', 'Admin LuckyBIT');
            });
        });

        $this->updated();
        $this->notification = [
            'tipe' => 'success',
            'pesan' => 'New member registration is successful. An email has been sent to '.$this->email
        ];
        return $this->reset(['name', 'email', 'country', 'contract', 'phone_number', 'turnover']);
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
