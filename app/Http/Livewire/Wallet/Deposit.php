<?php

namespace App\Http\Livewire\Wallet;

use App\Models\Payment;
use Livewire\Component;
use App\Models\PaymentMethod;
use App\Library\CoinPaymentsAPI;

class Deposit extends Component
{
    public $amount, $password, $notification, $amount_transfer = 0, $nilai, $metode, $payment, $link_status;

    public $data_kurs_pembayaran = [];

    public function mount()
    {
        $this->data_kurs_pembayaran = PaymentMethod::all();
    }

    public function updated()
    {
        $this->emit('reinitialize');
        // $this->notification = null;
        $this->setAmountCoin();
    }

    protected $listeners = [
        'set:setpayment' => 'setPayment'
    ];

    private function setAmountCoin()
    {
        $this->amount_transfer = $this->nilai * ($this->amount?:0);
    }

    public function setPayment($payment)
    {
        $this->updated();
        $data_kurs = $this->data_kurs_pembayaran->where('kurs_pembayaran_metode', $payment)->first();
        $this->metode = $data_kurs['kurs_pembayaran_metode'];
        $this->payment = $payment;
        $this->nilai = $data_kurs['kurs_pembayaran_nilai'];
        $this->setAmountCoin();
    }

    public function submit()
    {
        $coin = new CoinPaymentsAPI();
        $coin->Setup("4B0fa8824d2Efda97A8e3681124d8098c39e5495357d221C79bA74Ba7fef5Ac8", "267606779407d4899087d2b098ea8c1b4c136ce260f362383640743b9a5040a6");

        $request = [
            'amount' => $this->amount_transfer,
            'currency1' => $this->metode,
            'currency2' => $this->metode,
            'buyer_email' => auth()->user()->anggota_email,
            'item' => 'Buy '.$this->amount.' LBIT',
            'address' => '',
            'ipn_url' => ''
        ];

        $this->emit('reinitialize');
        $result = $coin->CreateTransaction($request);
        if ($result['error'] == 'ok') {
            $deposit = new Payment();
            $deposit->email = auth()->user()->anggota_email;
            $deposit->entered_amount = $this->amount_transfer;
            $deposit->amount = $result['result']['amount'];
            $deposit->from_currency = $this->metode;
            $deposit->to_currency = $this->metode;
            $deposit->status = "initilaized";
            $deposit->gateway_id = $result['result']['txn_id'];
            $deposit->gateway_url = $result['result']['status_url'];
            $deposit->save();
            $this->reset(['amount', 'metode', 'amount_transfer']);

            return $this->notification = [
                'tipe' => 'success',
                'pesan' => '<a href="'.$result['result']['status_url'].'" target="_blank">Click this link to view the status</a>'
            ];
        } else {
            $this->reset(['amount', 'metode', 'amount_transfer']);
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => 'Error: '. $result['error']
            ];
        }

    }

    public function render()
    {
        return view('livewire.wallet.deposit')
        ->extends('livewire.main', [
            'breadcrumb' => ['Wallet', 'Deposit'],
            'title' => 'Deposit Wallet',
            'description' => 'Depost Your LBIT Wallet'
        ])
        ->section('subcontent');
    }
}
