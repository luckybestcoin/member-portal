<?php

namespace App\Http\Livewire\Forgot;

use App\Models\Member;
use Livewire\Component;
use App\Models\Recovery;
use Illuminate\Support\Str;
use App\Jobs\SendRecoveryJob;
use Illuminate\Support\Facades\Mail;
use Lukeraymonddowning\Honey\Traits\WithHoney;

class Main extends Component
{
    use WithHoney;
    public $notification, $username, $success = false;

    protected $rules = [
        'username' => 'required'
    ];

    public function submit()
    {
        $this->validate();
        $error = null;

        $member = Member::where('member_user', $this->username)->orWhere('member_email', $this->username)->get();
        if ($member->count() > 0) {
            $member = $member->first();
            if (Member::where('member_email', $member->member_email)->count() == 0){
                $error .= "<li>Email address not found</li>";
            }

            if (Member::where('member_user', $member->member_user)->count() == 0){
                $error .= "<li>Username address not found</li>";
            }

            if (Recovery::where('member_email', $member->member_email)->count() > 0){
                $error .= "<li>You've done this action before. Please check your email</li>";
            }
        }else{
            $error .= "<li>Username/Email not registered</li>";
        }

        if ($error) {
            $this->reset(['username']);
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $error
            ];
        }

        try {
            $recovery = new Recovery();
            $recovery->member_email = $member->member_email;
            $recovery->recovery_token = Str::random(40).date("Ymdhms");
            $recovery->save();
            $details =[
                'token' => $recovery->recovery_token,
                'name' => $member->member_user,
                'email' => $member->member_email
            ];
            dispatch(new SendRecoveryJob($details));

            $this->success = true;
            return $this->notification = [
                'tipe' => 'success',
                'pesan' => 'The recovery link has been sent to '.$member->member_email
            ];
        } catch(\Exception $e){
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $e->getMessage()
            ];
        }
    }

    public function render()
    {
        return view('livewire.forgot.main')->extends('layouts.auth')->section('content');
    }
}
