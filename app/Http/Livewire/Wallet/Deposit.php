<?php

namespace App\Http\Livewire\Wallet;

use App\Models\Rate;
use Livewire\Component;
use Hexters\CoinPayment\CoinPayment;
use Illuminate\Support\Facades\Hash;
use App\Models\CoinpaymentTransactions;

class Deposit extends Component
{
    public $amount, $password, $notification, $total_payment = 0, $price, $note, $rate, $transaction = [];

    public $payment_method = [];

    protected $rules = [
        'amount' => 'required',
        'password' => 'required'
    ];

    public function mount()
    {
        $this->rate = new Rate();
        $this->transaction = CoinpaymentTransactions::with('items')->where('buyer_email', auth()->user()->member_email)->orderBy('created_at', 'desc')->limit(30)->get();
    }

    public function updated()
    {
        $this->emit('reinitialize');
        $this->reset('notification');
        $this->total_payment = $this->rate->last_dollar * ($this->amount?:0);
    }

    public function submit()
    {
        $this->validate();
        $error = null;

        if(Hash::check($this->password, auth()->user()->member_password) === false){
            $error .= "<li>Wrong <strong>password</strong></li>";
        }

        if ($this->amount <= 0) {
            $error .= "<li>LBC amount to be purchased cannot be less than 1</li>";
        }

        $transaction['order_id'] = uniqid(); // invoice number
        $transaction['amountTotal'] = $this->rate->last_dollar * ($this->amount?:0);
        $transaction['note'] = $this->note;
        $transaction['buyer_name'] = auth()->user()->member_user;
        $transaction['buyer_email'] = auth()->user()->member_email;
        $transaction['redirect_url'] = url('/wallet/deposit'); // When Transaction was comleted
        $transaction['cancel_url'] = url('/wallet/deposit'); // When user click cancel link


        $transaction['items'][] = [
            'itemDescription' => 'Lucky Best Coin',
            'itemPrice' => $this->rate->last_dollar, // USD
            'itemQty' => $this->amount?:0,
            'itemSubtotalAmount' => $this->rate->last_dollar * ($this->amount?:0) // USD
        ];

        $transaction['payload'] = [
            'foo' => [
                'bar' => 'baz'
            ]
        ];
        redirect(CoinPayment::generatelink($transaction));
    }

    public function render()
    {
        return view('livewire.wallet.deposit')
            ->extends('livewire.main', [
                'breadcrumb' => ['Wallet', 'Deposit'],
                'title' => 'Deposit LBC'
            ])
            ->section('subcontent');
    }
}
