<?php

namespace App\Http\Livewire\Registrationticket;

use App\Models\Pin;
use App\Models\Saldo;
use Livewire\Component;
use App\Models\Transaksi;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Buy extends Component
{
    public $amount, $password, $back, $notification, $harga_tiket, $balance, $pin, $left_turnover = 0, $right_turnover = 0;

    protected $rules = [
        'amount' => 'numeric',
        'password' => 'required'
    ];

    public function mount()
    {
        $this->harga_tiket = config("constant.harga_tiket");
        $this->back = Str::contains(url()->previous(), ['tambah', 'edit'])? '/network/registration': url()->previous();
    }

    public function submit()
    {
        $this->validate();

        $saldo = new Saldo();
        $error = null;

        $this->reset('notification');

        if(Hash::check($this->password, auth()->user()->anggota_kata_sandi) === false){
            return $error .= "<li>Wrong <strong>password</strong></li>";
        }

        if ($saldo->terakhir < $this->harga_tiket * $this->amount) {
            $error .= "<li>Insufficient <strong>balance</strong></li>";
        }

        if ($error) {
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $error
            ];
        }

        DB::transaction(function () use($saldo) {
            $keterangan = "Buy ".$this->amount." registration ticket";

            $id = Str::random(10)."-".date('Ymdhis').round(microtime(true) * 1000);

            $transaksi = new Transaksi();
            $transaksi->transaksi_id = $id;
            $transaksi->transaksi_keterangan = $keterangan."  by ".auth()->user()->anggota_uid;
            $transaksi->save();

            $saldo->saldo_keterangan = $keterangan;
            $saldo->saldo_debit = $this->harga_tiket * $this->amount;
            $saldo->saldo_kredit = 0;
            $saldo->transaksi_id = $id;
            $saldo->anggota_id = auth()->id();
            $saldo->save();

            $pin = new Pin();
            $pin->pin_keterangan = $keterangan;
            $pin->pin_debit = 0;
            $pin->pin_kredit = $this->amount;
            $pin->transaksi_id = $id;
            $pin->anggota_id = auth()->id();
            $pin->save();
        });

        $this->reset(['amount', 'password']);

        $this->updated();
        return $this->notification = [
            'tipe' => 'success',
            'pesan' => 'Buy registration ticket is success!!!'
        ];
    }

    public function updated()
    {
        $saldo = new Saldo();
        $pin = new Pin();

        $this->balance = $saldo->terakhir;
        $this->pin = $pin->terakhir;
    }

    public function render()
    {
        return view('livewire.registrationticket.buy')
            ->extends('livewire.main', [
                'breadcrumb' => ['Registration Ticket', 'Buy'],
                'title' => 'Buy Registration Ticket',
                'description' => 'Buy registration ticket to register new member'
            ])
            ->section('subcontent');
    }
}
