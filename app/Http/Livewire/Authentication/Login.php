<?php

namespace App\Http\Livewire\Authentication;

use App\Models\Referal;
use Livewire\Component;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;

class Login extends Component
{
    public $username, $password, $referral_code, $remember = false;
    public $notification;

    protected $rules = [
        'username' => 'required',
        'password' => 'required',
    ];

    public function submit()
    {
        $this->validate();

        $remember = $this->remember == 'on';
        if (Auth::attempt(['anggota_uid' => $this->username, 'password' => $this->password], $remember)) {
            Auth::logoutOtherDevices($this->password, 'anggota_kata_sandi');
            return redirect()->intended('dashboard');
        }
        $this->notification = [
            'tipe' => 'danger',
            'pesan' => '<li><strong>Sign In notification!!!</strong><br>Wrong username or password</li>'
        ];
        return;
    }

    public function updated()
    {
        $this->reset('notification');
    }

    public function referral()
    {
        $this->validate([
            'referral_code' => 'required'
        ]);

        $referral = Referal::where('referal_token', $this->referral_code)->first();

        if($referral){
            return redirect(route('referral', [ 'kode' => $this->referral_code]));
        }
        $this->notification = [
            'tipe' => 'danger',
            'pesan' => '<li>Referral code not found</li>'
        ];
        return;
    }

    public function render()
    {
        return view('livewire.authentication.login');
    }
}
