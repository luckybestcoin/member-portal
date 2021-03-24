<?php

namespace App\Http\Livewire\Authentication;

use Livewire\Component;
use App\Models\Referral;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Lukeraymonddowning\Honey\Traits\WithHoney;
use Lukeraymonddowning\Honey\Traits\WithRecaptcha;

class Login extends Component
{
    use WithHoney,WithRecaptcha;
    public $username, $password, $referral_token, $remember = false;
    public $notification;

    protected $rules = [
        'username' => 'required',
        'password' => 'required',
    ];

    public function login()
    {
        $this->validate();
        if($this->honeyPasses() === false){
            $this->notification = [
                'tipe' => 'danger',
                'pesan' => '<li>Honey Failed</li>'
            ];
            return;
        }
        if($this->recaptchaPasses() === false){
            $this->notification = [
                'tipe' => 'danger',
                'pesan' => '<li>Recaptcha Failed</li>'
            ];
            return;
        }
        $remember = $this->remember == 'on';
        if (Auth::attempt(['member_user' => $this->username, 'password' => $this->password], $remember)) {
            Auth::logoutOtherDevices($this->password, 'member_password');
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
