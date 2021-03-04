<?php

namespace App\Http\Livewire\Forgot;

use App\Models\Member;
use Livewire\Component;
use App\Models\Recovery;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class Recover extends Component
{
    public $member, $name, $email, $phone_number, $contract_price, $data, $new_password, $token, $eye = "fa-eye-slash", $type = "password";
    public $notification;

    protected $rules = [
        'name' => 'required',
        'email' => 'required',
        'phone_number' => 'required',
        'new_password' => 'required'
    ];

    public function mount($token)
    {
        $this->token = $token;
        $this->data = Recovery::where('recovery_token', $token)->with('member')->first();
        if($this->data && $this->data->member){
            $this->member = $this->data->member->member_id;
            $this->name = $this->data->member->member_name;
            $this->email = $this->data->member->member_email;
            $this->phone_number = $this->data->member->member_phone;
            $this->contract_price = $this->data->member->contract_price;
        }
    }

    public function showhide()
    {
        if ($this->type == 'password') {
            $this->eye = "fa-eye";
            $this->type = "text";
        }else{
            $this->eye = "fa-eye-slash";
            $this->type = "password";
        }
    }

    public function submit()
    {
        $this->validate();
        $error = null;

        if (Recovery::where('recovery_token', $this->token)->count() === 0) {
            $error .= '<li>The link has expired</li>';
        }

        if ($error) {
            $this->reset(['new_password']);
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $error
            ];
        }

        try {
            $member = Member::findOrFail($this->member);
            $member->member_password = Hash::make($this->new_password);
            $member->save();
            if (Auth::attempt(['member_email' => $this->email, 'password' => $this->new_password], false)) {
                Auth::logoutOtherDevices($this->new_password, 'member_password');
                return redirect('dashboard');
            }
        } catch(\Exception $e){
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $e->getMessage()
            ];
        }
    }

    public function render()
    {
        return view('livewire.forgot.recover')->extends('layouts.auth')->section('content');
    }
}
