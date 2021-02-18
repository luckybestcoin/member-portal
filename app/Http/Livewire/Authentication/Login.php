<?php

namespace App\Http\Livewire\Authentication;

use App\Models\Referal;
use Livewire\Component;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;

class Login extends Component
{
    public $email, $password, $referral_code, $remember = false;
    public $notification;

    protected $rules = [
        'email' => 'required',
        'password' => 'required',
    ];

    public function submit()
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
