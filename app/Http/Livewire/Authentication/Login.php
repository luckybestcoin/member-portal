<?php

namespace App\Http\Livewire\Authentication;

use App\Models\Referal;
use Livewire\Component;
use App\Models\Referral;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;

class Login extends Component
{
    public $email, $password, $referral_token, $remember = false;
    public $notification;

    protected $rules = [
        'email' => 'required',
        'password' => 'required',
    ];

    public function login()
    {
        $this->validate();

        $remember = $this->remember == 'on';
        if (Auth::attempt(['member_email' => $this->email, 'password' => $this->password], $remember)) {
            Auth::logoutOtherDevices($this->password, 'member_password');
            return redirect()->intended('dashboard');
        }
        $this->notification = [
            'tipe' => 'danger',
            'pesan' => '<li><strong>Sign In notification!!!</strong><br>Wrong email or password</li>'
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
            'referral_token' => 'required'
        ]);

        $referral = Referral::where('referral_token', $this->referral_token)->first();

        if($referral){
            return redirect(route('referral', [ 'token' => $this->referral_token]));
        }
        $this->notification = [
            'tipe' => 'danger',
            'pesan' => '<li>Referral token not found</li>'
        ];
        return;
    }

    public function render()
    {
        return view('livewire.authentication.login');
    }
}
