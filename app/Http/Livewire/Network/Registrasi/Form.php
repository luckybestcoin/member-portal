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
use Illuminate\Support\Facades\DB;

class Form extends Component
{
    public $name, $package, $country, $phone_number, $country_code, $email, $position, $back, $failed, $package_cost, $package_ticket, $package_name;

    public $data_negara = [], $data_paket = [];

    protected $rules = [
        'name' => 'required',
        'package' => 'required',
        'position' => 'required',
        'country_code' => 'required',
        'phone_number' => 'required|numeric',
        'email' => 'required|email',
        'country' => 'required'
    ];

    protected $listeners = [
        'set:setcountry' => 'setCountry',
        'set:setpackage' => 'setPackage'
    ];

    public function setPackage($package)
    {
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

    public function setCountry($country)
    {
        if ($country) {
            $this->country = $country;
            $this->country_code = $this->data_negara->where('negara_id', $country)->first()['negara_kode'];
        } else {
            $this->reset(['country_code','country']);
        }
    }

    public function updated()
    {
        $this->emit('reinitialize');
    }

    public function mount()
    {
        $this->back = Str::contains(url()->previous(), ['tambah', 'edit'])? '/network/registration': url()->previous();
        $this->data_negara = Negara::orderBy('negara_nama')->get();
        $this->data_paket = Paket::all();
    }

    public function countryChanged()
    {
        $this->showTable = 1;
    }

    public function submit()
    {
        $this->validate();

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

        DB::transaction(function () {
            $keterangan = "Member registration on behalf of ".$this->name;

            $transaksi = new Transaksi();
            $transaksi->transaksi_id = Str::random(40)."-".date('Ymdhis').round(microtime(true) * 1000);
            $transaksi->transaksi_keterangan = $keterangan." by ".auth()->user()->anggota_uid;
            $transaksi->save();

            $saldo->saldo_keterangan = $keterangan;
            $saldo->saldo_debit = $this->package_cost;
            $saldo->saldo_kredit = 0;
            $saldo->transaksi_id = $transaksi->transaksi_id;
            $saldo->anggota_id = auth()->id();
            $saldo->save();

            $pin->pin_ketarangan = $keterangan;
            $pin->pin_debit = $this->package_ticket;
            $pin->pin_kredit = 0;
            $pin->transaksi_id = $transaksi->transaksi_id;
            $pin->anggota_id = auth()->id();
            $pin->save();

            $anggota = new Anggota();
            $anggota->anggota_nama = $this->name;
            $anggota->anggota_email = $this->email;
            $anggota->negara_id = $this->country;
            $anggota->anggota_hp = $this->country_code.$this->phone_number;
            $anggota->paket_id = $this->package;
            $anggota->anggota_parent_posisi = $this->position;
            $anggota->anggota_parent = auth()->id();
            $anggota->jaringan = auth()->user()->anggota_jaringan.auth()->id().($this->position == 0? 'ki': 'ka');
            $anggota->save();

            $referal = new Referal();
            $referal->referal_token = Str::random(40).$anggota->anggota_id;
            $referal->anggota_id = $anggota->anggota_id;
            $referal->save();
        });

    }

    public function render()
    {
        $this->emit('reinitialize');
        return view('livewire.network.registrasi.form')
            ->extends('livewire.main', [
                'breadcrumb' => ['Network', 'Registration'],
                'title' => 'Registration',
                'description' => 'Registration new member'
            ])
            ->section('subcontent');
    }
}
