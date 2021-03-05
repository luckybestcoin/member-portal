<?php

namespace App\Http\Livewire\Wallet;

use App\Models\Rate;
use App\Models\Wallet;
use Livewire\Component;
use Illuminate\Support\Facades\Hash;

class Main extends Component
{
    public $address, $transaction, $balance, $dollar, $lbc_amount, $to_address, $notification, $password;

    protected $rules = [
        'to_address' => 'required',
        'lbc_amount' => 'required',
        'password' => 'required'
    ];

    public function updated()
    {
        // $this->validate();
    }

    public function mount()
    {
        // $this->address = Wallet::where('member_id', auth()->id())->get();
        // dd($this->transaction);
    }

    public function show()
    {
        $this->reset(['to_address', 'password', 'lbc_amount', 'notification']);
        $this->emit('show');
    }

    public function submit()
    {
        $this->validate();

        $error = null;
        $this->reset('notification');

        try {

            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if ($this->lbc_amount <= 0) {
                $error .= "<li>LBC amount to be purchased cannot be less than 1</li>";
            }

            if ($this->lbc_amount > bitcoind()->getbalance(auth()->user()->member_user)[0]){
                $error .= "<li>Account has insufficient funds.</li>";
            }

            if (bitcoind()->getbalance(auth()->user()->member_user)[0] - $this->lbc_amount < 1){
                $error .= "<li>You must leave a minimum of 1 LBC for this transaction</li>";
            }

            if ($error) {
                $this->reset(['to_address', 'lbc_amount', 'password']);
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }

            bitcoind()->sendfrom(auth()->user()->member_user, $this->to_address, $this->lbc_amount, 1);

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
        $this->balance = bitcoind()->getbalance(auth()->user()->member_user)[0];
        $this->address = bitcoind()->getaccountaddress(auth()->user()->member_user);
        $this->transaction = collect(bitcoind()->listtransactions(auth()->user()->member_user, 30)->result());
        $this->dollar = $this->balance * $rate->last_dollar;
        return view('livewire.wallet.main')
            ->extends('livewire.main', [
                'breadcrumb' => ['Wallet'],
                'title' => 'Wallet'
            ])
            ->section('subcontent');
    }
}
