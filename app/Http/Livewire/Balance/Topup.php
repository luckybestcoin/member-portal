<?php

namespace App\Http\Livewire\Balance;

use App\Models\Pin;
use App\Models\Saldo;
use Livewire\Component;
use App\Models\Transaksi;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Topup extends Component
{
    public $amount, $password, $back, $notification, $balance, $pin, $left_turnover = 0, $right_turnover = 0;

    protected $rules = [
        'amount' => 'numeric',
        'password' => 'required'
    ];

    public function mount()
    {
        $this->harga_tiket = config("constant.harga_tiket");
        $this->back = Str::contains(url()->previous(), ['tambah', 'edit'])? '/network/registration': url()->previous();
    }

    public function updated()
    {
        $saldo = new Saldo();
        $pin = new Pin();

        $this->balance = $saldo->terakhir;
        $this->pin = $pin->terakhir;

        $this->notification = [
            'tipe' => null,
            'pesan' => null
        ];
    }

    public function submit()
    {
        $this->validate();

        $saldo = new Saldo();
        $pin = new Pin();

        $this->reset('notification');

        if(Hash::check($this->password, auth()->user()->anggota_kata_sandi) === false){
            return $this->notification = "<li>Wrong <strong>password</strong></li>";
        }
        if ($saldo->terakhir < $this->harga_tiket * $this->amount) {
            $this->notification = "<li>Insufficient <strong>balance</strong></li>";
        }
        if ($this->notification) {
            return $this->notification;
        }

        DB::transaction(function () use($saldo, $pin) {
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
        return view('livewire.balance.topup')
            ->extends('livewire.main', [
                'breadcrumb' => ['Balance', 'Top Up'],
                'title' => 'Top Up Balance',
                'description' => 'Top Up Balance'
            ])
            ->section('subcontent');
    }
}
