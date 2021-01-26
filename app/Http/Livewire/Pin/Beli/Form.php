<?php

namespace App\Http\Livewire\Pin\Beli;

use App\Models\Pin;
use App\Models\Saldo;
use Livewire\Component;
use App\Models\Transaksi;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Form extends Component
{
    public $amount, $password, $back, $failed, $harga_tiket;

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

        if(Hash::check($this->password, auth()->user()->anggota_kata_sandi) === false){
            return $this->failed = "<li>Wrong <strong>password</strong></li>";
        }

        $saldo = new Saldo();

        $this->reset('failed');

        if ($saldo->terakhir < $this->harga_tiket * $this->amount) {
            $this->failed = "<li>Insufficient <strong>balance</strong></li>";
        }
        if ($this->failed) {
            return $this->failed;
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
    }

    public function render()
    {
        return view('livewire.pin.beli.form')
            ->extends('livewire.main', [
                'breadcrumb' => ['Registration Ticket', 'Buy'],
                'title' => 'Buy Registration Ticket',
                'description' => 'Buy registration ticket to register new member'
            ])
            ->section('subcontent');
    }
}
