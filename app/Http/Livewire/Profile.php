<?php

namespace App\Http\Livewire;

use App\Models\Country;
use App\Models\Member;
use Livewire\Component;

class Profile extends Component
{
    public $name, $contract, $country, $referral, $phone_number, $email, $turnover, $back, $notification, $data;

    public $country_data = [];

    protected $rules = [
        'name' => 'required',
        'contract' => 'required',
        'email' => 'required|email',
        'phone_number' => 'required|min:9',
        'country' => 'required'
    ];

    protected $listeners = [
        'set:setcountry' => 'setCountry'
    ];

    public function setCountry($country)
    {
        $this->updated();
        $this->country = $country;
    }

    public function updated()
    {
        $this->emit('reinitialize');
        $this->notification = null;
    }

    public function mount()
    {
        $this->updated();
        $this->data = Member::findOrFail(auth()->id());
        $this->name = $this->data->member_name;
        $this->email = $this->data->member_email;
        $this->country = $this->data->country_id;
        $this->phone_number = $this->data->member_phone;
        $this->contract = $this->data->contract->contract_name." ".number_format($this->data->contract_price, 2);
        $this->referral = $this->data->parent? $this->data->parent->member_email: "";
        $this->country_data = Country::orderBy('country_name')->get();
    }

    public function submit()
    {
        $this->emit('reinitialize');
        $this->validate();

        $this->reset('notification');
        $error = null;

        if (Member::where('member_email', $this->email)->where('member_id', '!=', auth()->id())->count() > 0){
            $error .= "<li>The email address <strong>".$this->email."</strong> is already registered</li>";
        }

        if ($error) {
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $error
            ];
        }

        $this->data->member_name = $this->name;
        $this->data->member_email = $this->email;
        $this->data->country_id = $this->country;
        $this->data->member_phone = $this->phone_number;
        $this->data->save();

        $this->updated();
        return $this->notification = [
            'tipe' => 'success',
            'pesan' => 'Your profile has been changed '
        ];
        $this->reset(['name', 'email', 'country', 'phone_number']);
    }

    public function render()
    {
        return view('livewire.profile')
            ->extends('livewire.main', [
                'breadcrumb' => ['Profile'],
                'title' => 'Profile'
            ])
            ->section('subcontent');
    }
}
