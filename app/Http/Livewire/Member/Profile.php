<?php

namespace App\Http\Livewire\Member;

use App\Models\Negara;
use App\Models\Anggota;
use Livewire\Component;

class Profile extends Component
{
    public $name, $package, $country, $referral, $phone_number, $email, $turnover, $back, $notification, $data;

    public $data_negara = [];

    protected $rules = [
        'name' => 'required',
        'package' => 'required',
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
        $this->data = Anggota::findOrFail(auth()->id());
        $this->name = $this->data->anggota_nama;
        $this->email = $this->data->anggota_email;
        $this->country = $this->data->negara_id;
        $this->phone_number = $this->data->anggota_hp;
        $this->package = number_format($this->data->paket_harga, 2);
        $this->referral = $this->data->parent? $this->data->parent->anggota_uid." (".$this->data->parent->anggota_nama.")": "";
        $this->data_negara = Negara::orderBy('negara_nama')->get();
    }

    public function submit()
    {
        $this->emit('reinitialize');
        $this->validate();

        $this->reset('notification');
        $error = null;

        if (Anggota::where('anggota_email', $this->email)->where('anggota_id', '!=', auth()->id())->count() > 0){
            $error .= "<li>The email address <strong>".$this->email."</strong> is already registered</li>";
        }
        if (Anggota::where('anggota_hp', $this->phone_number)->where('anggota_id', '!=', auth()->id())->count() > 0){
            $error .= "<li>The phone nomber <strong>".$this->phone_number."</strong> is already registered</li>";
        }
        if ($error) {
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $error
            ];
        }

        $this->data->anggota_nama = $this->name;
        $this->data->anggota_email = $this->email;
        $this->data->negara_id = $this->country;
        $this->data->anggota_hp = $this->phone_number;
        $this->data->save();

        $this->updated();
        return $this->notification = [
            'tipe' => 'success',
            'pesan' => 'Your profile has been changed '.$this->email
        ];
        $this->reset(['name', 'email', 'country', 'phone_number']);
    }

    public function render()
    {
        return view('livewire.member.profile')
            ->extends('livewire.main', [
                'breadcrumb' => ['Profile'],
                'title' => 'Profile',
                'description' => 'The Detail of Your Profile'
            ])
            ->section('subcontent');
    }
}
