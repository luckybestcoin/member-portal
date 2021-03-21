<?php

namespace App\Http\Livewire\Wallet;

use App\Models\Rate;
use App\Models\Member;
use Livewire\Component;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;

class Main extends Component
{
    public $lbc_amount, $to_address, $notification, $password, $app_key;

    public function updated()
    {
        // $this->validate();
    }

    public function mount()
    {
        $this->reset('notification');
    }

    public function show()
    {
        $this->reset(['to_address', 'password', 'lbc_amount', 'notification']);
        $this->emit('show');
    }

    public function key()
    {
        $this->validate([
            'app_key' => 'required'
        ]);

        try {
            $response = Http::get("https://lbcwallet.com/api/verify?key=".$this->app_key)->body();
            if(strpos($response, "SUKSES") !== false){
                $data = explode(",", $response);

                $member = Member::findOrFail(auth()->id());
                $member->app_key = $this->app_key;
                $member->username = $data[1];
                $member->address = $data[2];
                $member->save();

                $this->reset('app_key');
                return redirect()->to('/wallet');
            }else{
                $this->reset('app_key');
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $response
                ];
            }
		}catch(\Exception $e){
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $e->getMessage()
            ];
        }
    }

    public function submit()
    {
        $this->validate([
            'to_address' => 'required',
            'lbc_amount' => 'required',
            'password' => 'required'
        ]);

        $error = null;
        $this->reset('notification');

        try {

            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if ($this->lbc_amount <= 0) {
                $error .= "<li>LBC amount to be purchased cannot be less than 1</li>";
            }

            if ($this->lbc_amount > bitcoind()->getbalance(auth()->user()->username)[0]){
                $error .= "<li>Account has insufficient funds.</li>";
            }

            if (bitcoind()->getbalance(auth()->user()->username)[0] - $this->lbc_amount < 1){
                $error .= "<li>You must leave a minimum of 1 LBC for this transaction</li>";
            }

            if ($error) {
                $this->reset(['to_address', 'lbc_amount', 'password']);
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }

            bitcoind()->sendfrom(auth()->user()->username, $this->to_address, round($this->lbc_amount, 8), 1);

            $this->reset(['to_address', 'password', 'lbc_amount']);
            $this->emit('done');
            return $this->notification = [
                'tipe' => 'success',
                'pesan' => 'Send LBC was successful!!!'
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
        $rate = new Rate();

        return view('livewire.wallet.main')
            ->extends('livewire.main', [
                'breadcrumb' => ['Wallet'],
                'title' => 'Wallet'
            ])
            ->section('subcontent');
    }
}
