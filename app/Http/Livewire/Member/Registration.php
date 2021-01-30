<?php

namespace App\Http\Livewire\Member;

use Carbon\Carbon;
use App\Models\Pin;
use App\Models\Paket;
use App\Models\Saldo;
use App\Models\Negara;
use App\Models\Anggota;
use App\Models\Referal;
use Livewire\Component;
use App\Models\BagiHasil;
use App\Models\Peringkat;
use App\Models\Transaksi;
use App\Models\Pencapaian;
use Illuminate\Support\Str;
use App\Mail\RegistrasiEmail;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class Registration extends Component
{
    public $name, $package, $country, $referral, $phone_number, $email, $turnover, $back, $notification, $package_cost, $package_ticket, $package_name;

    public $data_negara = [], $data_paket = [], $data_anggota = [];

    protected $rules = [
        'name' => 'required',
        'package' => 'required',
        'turnover' => 'required',
        'referral' => 'required',
        'email' => 'required|email',
        'phone_number' => 'required|min:9',
        'country' => 'required'
    ];

    protected $listeners = [
        'set:setreferral' => 'setReferral',
        'set:setpackage' => 'setPackage',
        'set:setcountry' => 'setCountry'
    ];

    public function setReferral($referral)
    {
        $this->updated();
        $this->referral = $referral;
    }

    public function setCountry($country)
    {
        $this->updated();
        $this->country = $country;
    }

    public function setPackage($package)
    {
        $this->updated();
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
        $this->notification = null;
    }

    public function mount()
    {
        $this->updated();
        $this->referral = auth()->id();
        $this->back = Str::contains(url()->previous(), ['tambah', 'edit'])? '/Member/registration': url()->previous();
        $this->data_negara = Negara::orderBy('negara_nama')->get();
        $this->data_paket = Paket::all();
        $this->data_anggota = Anggota::whereNotNull('anggota_uid')->where('anggota_jaringan', 'like', auth()->user()->anggota_jaringan.auth()->id().'%')->get();
    }

    public function countryChanged()
    {
        $this->showTable = 1;
    }

    public function submit()
    {
        $this->emit('reinitialize');
        $this->validate();

        $saldo = new Saldo();
        $pin = new Pin();

        $this->reset('notification');
        $error = null;

        if($this->turnover < 0 || $this->turnover > 1){
            $error .= "<li>Turnover position not available</li>";
        }
        if ($saldo->terakhir < $this->package_cost) {
            $error .= "<li>Insufficient <strong>balance</strong></li>";
        }
        if ($pin->terakhir < $this->package_ticket) {
            $error .= "<li>Not enough <strong>activation tickets</strong></li>";
        }
        if (Anggota::where('anggota_email', $this->email)->count() > 0){
            $error .= "<li>The email address <strong>".$this->email."</strong> is already registered</li>";
        }
        if (Anggota::where('anggota_hp', $this->phone_number)->count() > 0){
            $error .= "<li>The phone nomber <strong>".$this->phone_number."</strong> is already registered</li>";
        }
        if ($error) {
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $error
            ];
        }

        DB::transaction(function () use ($saldo, $pin) {
            $keterangan = "Member registration on behalf of ".$this->name;

            $id = Str::random(10)."-".date('Ymdhis').round(microtime(true) * 1000);

            $transaksi = new Transaksi();
            $transaksi->transaksi_id = $id;
            $transaksi->transaksi_keterangan = $keterangan." by ".auth()->user()->anggota_uid;
            $transaksi->save();

            $saldo->saldo_keterangan = $keterangan;
            $saldo->saldo_debit = $this->package_cost;
            $saldo->saldo_kredit = 0;
            $saldo->transaksi_id = $id;
            $saldo->anggota_id = auth()->id();
            $saldo->save();

            $pin->pin_keterangan = $keterangan;
            $pin->pin_debit = $this->package_ticket;
            $pin->pin_kredit = 0;
            $pin->transaksi_id = $id;
            $pin->anggota_id = auth()->id();
            $pin->save();

            $anggota = new Anggota();
            $anggota->anggota_nama = $this->name;
            $anggota->anggota_email = $this->email;
            $anggota->negara_id = $this->country;
            $anggota->paket_harga = $this->package_cost;
            $anggota->anggota_hp = $this->phone_number;
            $anggota->anggota_posisi = $this->turnover;
            $anggota->anggota_parent = $this->referral;
            $anggota->anggota_jaringan = auth()->user()->anggota_jaringan.auth()->id().($this->turnover == 0? 'ki': 'ka');
            $anggota->save();

            $referal = new Referal();
            $referal->referal_token = Str::random(40).$anggota->anggota_id;
            $referal->anggota_id = $anggota->anggota_id;
            $referal->save();

            $bagi_hasil = new BagiHasil();
            $bagi_hasil->bagi_hasil_keterangan = $keterangan;
            $bagi_hasil->bagi_hasil_jenis = "Referral";
            $bagi_hasil->bagi_hasil_debit = 0;
            $bagi_hasil->bagi_hasil_kredit = $this->package_cost * 10 /100;
            $bagi_hasil->transaksi_id = $id;
            $bagi_hasil->anggota_id = auth()->id();
            $bagi_hasil->save();

            Mail::send('email.registrasi', [
                'token' => $referal->referal_token,
                'nama' => $this->name,
                'paket' => $this->package,
                'email' => $this->email
            ], function($message) {
                $message->to($this->email, $this->name)->subject
                    ('Lucky BIT Registration Referral Code');
                $message->from('no-reply@luckybit.id', 'Admin LuckyBIT');
            });
        });

        $this->updated();
        return $this->notification = [
            'tipe' => 'success',
            'pesan' => 'New member registration is successful. An email has been sent to '.$this->email
        ];
        $this->reset(['name', 'email', 'country', 'package', 'phone_number', 'turnover']);
    }

    public function render()
    {
        return view('livewire.member.registration')
            ->extends('livewire.main', [
                'breadcrumb' => ['Member', 'Registration'],
                'title' => 'Registration',
                'description' => 'Registration new member'
            ])
            ->section('subcontent');
    }
}
