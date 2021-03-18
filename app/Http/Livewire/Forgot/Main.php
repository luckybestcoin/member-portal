<?php

namespace App\Http\Livewire\Forgot;

use App\Models\Member;
use Livewire\Component;
use App\Models\Recovery;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Mail;

class Main extends Component
{
    public $notification, $username, $success = false;

    protected $rules = [
        'username' => 'required'
    ];

    public function submit()
    {
        $this->validate();
        $error = null;

        $member = Member::where('member_user', $this->username)->get()->first();
        if (Member::where('member_email', $member->member_email)->count() == 0){
            $error .= "<li>Email address not found</li>";
        }

        if (Recovery::where('member_email', $member->member_email)->count() > 0){
            $error .= "<li>You've done this action before</li>";
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

            Mail::send('email.recovery', [
                'token' => $recovery->recovery_token,
                'name' => $member->member_user,
                'email' => $member->member_email
            ], function($message) use($member) {
                $message->to($member->member_email, $member->member_user)->subject
                    ('Lucky Best Coin Password Recovery');
                $message->from('no-reply@luckybestcoin.net', 'Admin LBC');
            });
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
