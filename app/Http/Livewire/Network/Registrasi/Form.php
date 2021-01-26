<?php

namespace App\Http\Livewire\Network\Registrasi;

use App\Models\Pin;
use App\Models\Paket;
use App\Models\Saldo;
use App\Models\Negara;
use App\Models\Anggota;
use App\Models\Referal;
use Livewire\Component;
use App\Models\Transaksi;
use Illuminate\Support\Str;
use App\Mail\RegistrasiEmail;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class Form extends Component
{
    public $name, $package, $country, $referral, $email, $position, $back, $failed, $package_cost, $package_ticket, $package_name, $balance, $pin, $left_turnover = 0, $right_turnover = 0;

    public $data_negara = [], $data_paket = [], $data_anggota = [];

    protected $rules = [
        'name' => 'required',
        'package' => 'required',
        'position' => 'required',
        'referral' => 'required',
        'email' => 'required|email',
        'country' => 'required'
    ];

    protected $listeners = [
        'set:setreferral' => 'setReferral',
        'set:setpackage' => 'setPackage',
        'set:setcountry' => 'setCountry'
    ];

    public function setReferral($referral)
    {
        $this->emit('reinitialize');
        $this->referral = $referral;
    }

    public function setCountry($country)
    {
        $this->emit('reinitialize');
        $this->country = $country;
    }

    public function setPackage($package)
    {
        $this->emit('reinitialize');
        if ($package) {
            $this->package = $package;
            $package_filter = $this->data_paket->where('paket_id', $package)->first();
            $this->package_cost = $package_filter['paket_harga'];
            $this->package_ticket = $package_filter['paket_pin'];
            $this->package_name = $package_filter['paket_name'];
        } else {
            $this->reset(['package']);
        }
    }

    public function updated()
    {
        $this->emit('reinitialize');

        $saldo = new Saldo();
        $pin = new Pin();

        $this->balance = $saldo->terakhir;
        $this->pin = $pin->terakhir;
    }

    public function mount()
    {
        $this->updated();
        $this->referral = auth()->id();
        $this->back = Str::contains(url()->previous(), ['tambah', 'edit'])? '/network/registration': url()->previous();
        $this->data_negara = Negara::orderBy('negara_nama')->get();
        $this->data_paket = Paket::all();
        $this->data_anggota = Anggota::where('anggota_jaringan', 'like', auth()->user()->anggota_jaringan.auth()->id().'%')->get();
    }

    public function countryChanged()
    {
        $this->showTable = 1;
    }

    public function submit()
    {
        $this->emit('reinitialize');
        //$this->validate();

        $saldo = new Saldo();
        $pin = new Pin();

        $this->reset('failed');

        if($this->position < 0 || $this->position > 1){
            $this->failed .= "<li>Position not available</li>";
        }
        if ($saldo->terakhir < $this->package_cost) {
            $this->failed .= "<li>Insufficient <strong>balance</strong></li>";
        }
        if ($pin->terakhir < $this->package_ticket) {
            $this->failed .= "<li>Not enough <strong>activation tickets</strong></li>";
        }
        if ($this->failed) {
            return $this->failed;
        }

        // DB::transaction(function () use ($saldo, $pin) {
        //     $keterangan = "Member registration on behalf of ".$this->name;

        //     $id = Str::random(10)."-".date('Ymdhis').round(microtime(true) * 1000);

        //     $transaksi = new Transaksi();
        //     $transaksi->transaksi_id = $id;
        //     $transaksi->transaksi_keterangan = $keterangan." by ".auth()->user()->anggota_uid;
        //     $transaksi->save();

        //     $saldo->saldo_keterangan = $keterangan;
        //     $saldo->saldo_debit = $this->package_cost;
        //     $saldo->saldo_kredit = 0;
        //     $saldo->transaksi_id = $id;
        //     $saldo->anggota_id = auth()->id();
        //     $saldo->save();

        //     $pin->pin_keterangan = $keterangan;
        //     $pin->pin_debit = $this->package_ticket;
        //     $pin->pin_kredit = 0;
        //     $pin->transaksi_id = $id;
        //     $pin->anggota_id = auth()->id();
        //     $pin->save();

        //     $anggota = new Anggota();
        //     $anggota->anggota_nama = $this->name;
        //     $anggota->anggota_email = $this->email;
        //     $anggota->negara_id = $this->country;
        //     $anggota->paket_id = $this->package;
        //     $anggota->anggota_parent_posisi = $this->position;
        //     $anggota->anggota_parent = $this->referral;
        //     $anggota->anggota_jaringan = auth()->user()->anggota_jaringan.auth()->id().($this->position == 0? 'ki': 'ka');
        //     $anggota->save();

        //     $referal = new Referal();
        //     $referal->referal_token = Str::random(40).$anggota->anggota_id;
        //     $referal->anggota_id = $anggota->anggota_id;
        //     $referal->save();
        // });

        Mail::to('andifajarlah@gmail.com')->send(new RegistrasiEmail());
        //$this->reset(['name', 'email', 'country', 'package', 'position']);

    }

    public function render()
    {
        return view('livewire.network.registrasi.form')
            ->extends('livewire.main', [
                'breadcrumb' => ['Network', 'Registration'],
                'title' => 'Registration',
                'description' => 'Registration new member'
            ])
            ->section('subcontent');
    }
}
