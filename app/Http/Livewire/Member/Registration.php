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
    public $name, $package, $country, $referral, $phone_number, $email, $position, $back, $notification, $package_cost, $package_ticket, $package_name;

    public $data_negara = [], $data_paket = [], $data_anggota = [];

    protected $rules = [
        'name' => 'required',
        'package' => 'required',
        'position' => 'required',
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

    private $parent = [];

    public function setParent($data)
    {
        array_push($this->parent, [
            'id' => $data->anggota_id,
            'user' => $data->anggota_uid,
            'parent' => $data->anggota_parent,
            'silsilah' => $data->anggota_jaringan,
            'paket' => $data->paket_harga,
            'posisi' => $data->anggota_posisi,
            'founder' => $data->anggota_parent? 0: 1,
            'pair' => $data->pair,
            'kiri' => (float) $data->omset_kiri - (float) $data->omset_keluar_kiri->sum('omset_keluar_jumlah'),
            'kanan' => (float) $data->omset_kanan - (float) $data->omset_keluar_kiri->sum('omset_keluar_jumlah'),
            "aktif" => $data->deleted_at? 0: 1,
            'jatuh_tempo' => $data->jatuh_tempo
        ]);
        if($data->parent)
            $this->setParent($data->parent);
    }

    public function submit()
    {
        $this->emit('reinitialize');
        $this->validate();

        $saldo = new Saldo();
        $pin = new Pin();

        $this->reset('notification');
        $error = null;

        if($this->position < 0 || $this->position > 1){
            $error .= "<li>Position not available</li>";
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
            $error .= "<li>The phone nimber <strong>".$this->phone_number."</strong> is already registered</li>";
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
            $anggota->anggota_posisi = $this->position;
            $anggota->anggota_parent = $this->referral;
            $anggota->anggota_jaringan = auth()->user()->anggota_jaringan.auth()->id().($this->position == 0? 'ki': 'ka');
            $anggota->save();

            $referal = new Referal();
            $referal->referal_token = Str::random(40).$anggota->anggota_id;
            $referal->anggota_id = $anggota->anggota_id;
            $referal->save();

            $bonus = [];
            array_push($bonus,[
                'bagi_hasil_keterangan' => $keterangan,
                'bagi_hasil_jenis' => "Referral",
                'bagi_hasil_debit' => 0,
                'bagi_hasil_kredit' => $paket_nominal * 10 /100,
                'transaksi_id' => $id,
                'anggota_id' => $this->referral,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now()
            ]);

            $this->setParent(Anggota::with('parent')->with('omset_keluar_kiri')->with('omset_keluar_kanan')->select("anggota_id", "anggota_uid", "anggota_parent", "anggota_posisi", "paket_harga", "anggota_jaringan", "jatuh_tempo", "deleted_at",
            DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ki")))=concat(anggota.anggota_id, "ki") ) omset_kiri'),
            DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ka")))=concat(anggota.anggota_id, "ka") ) omset_kanan'),
            DB::raw("(select ifnull(count(anggota_id), 0) pair from anggota a where a.anggota_parent = anggota.anggota_id) pair"))->where('anggota_id', auth()->id())->first());

            $data_peringkat = Peringkat::all();

            $omset_keluar = [];
            $parent_length = 0;
            $silsilah = $anggota->anggota_jaringan;
            foreach (collect($this->parent)->filter(function($q) use($anggota){
                return $q['id'] != $anggota->anggota_id;
            }) as $key => $row) {
                $pencapaian = 0;
                if(is_null($row['jatuh_tempo']) == 1 && $row['status'] == 1){
                    $kaki_kecil = collect([$row['kiri'], $row['kanan']])->min();
                    $member = Anggota::findOrFail($row['id']);

                    $peringkat = $data_peringkat->filter(function ($q) use ($kaki_kecil)
                    {
                        return $q->peringkat_omset_min <= $kaki_kecil;
                    })->sortBy('peringkat_omset_min')->first();

                    if ($peringkat && Pencapaian::where('anggota_id', $row['id'])->where('pencapaian_id', $pencapaian->peringkat_id)->count() == 0) {
                        $member->peringkat_id = $peringkat['peringkat_id'];
                        $member->save();

                        $pcp = new Pencapaian();
                        $pcp->anggota_id = $row['id'];
                        $pcp->peringkat_id = $peringkat->peringkat_id;
                        $pcp->save();
                    }

                    if($row['pair'] == 2) {
                        $pairing = "Turnonver growth ".$this->name." 5% of ".number_format($this->package_cost, 2);
                        if(substr($silsilah, -2) == 'ki'){
                            if($row['kiri'] - $paket_nominal < $row['kanan']){
                                $nilai_bonus = 0;
                                if($row['kiri'] > $row['kanan']){
                                    $nilai_bonus = $row['kanan'] - $row['kiri'] + $paket_nominal;
                                }else{
                                    $nilai_bonus = $paket_nominal;
                                }
                                array_push($bonus,[
                                    'bagi_hasil_keterangan' => $pairing." left side registration",
                                    'bagi_hasil_jenis' => "Turnover",
                                    'bagi_hasil_debit' => 0,
                                    'bagi_hasil_kredit' => $nilai_bonus * 5 /100,
                                    'transaksi_id' => $id,
                                    'anggota_id' => $row['id'],
                                    'created_at' => Carbon::now(),
                                    'updated_at' => Carbon::now()
                                ]);
                            }
                        }else if(substr($silsilah, -2) == 'ka'){
                            if($row['kanan'] - $paket_nominal < $row['kiri']){
                                $nilai_bonus = 0;
                                if($row['kanan'] > $row['kiri']){
                                    $nilai_bonus = $row['kiri'] - $row['kanan'] + $paket_nominal;
                                }else{
                                    $nilai_bonus = $paket_nominal;
                                }
                                array_push($bonus,[
                                    'bagi_hasil_keterangan' => $pairing." right side registration",
                                    'bagi_hasil_jenis' => "Turnover",
                                    'bagi_hasil_debit' => 0,
                                    'bagi_hasil_kredit' => $nilai_bonus * 5 /100,
                                    'transaksi_id' => $id,
                                    'anggota_id' => $row['id'],
                                    'created_at' => Carbon::now(),
                                    'updated_at' => Carbon::now()
                                ]);
                            }
                        }
                    }
                }
                if ($row['jatuh_tempo']) {
                    array_push($omset_keluar,[
                        'anggota_id' => $row['id'],
                        'omset_keluar_anggota' => $anggota->anggota_id,
                        'omset_keluar_jumlah' => $paket_nominal,
                        'omset_keluar_posisi' => substr($silsilah, -2) == "ka"? 1: 0
                    ]);
                }
                $parent_length = strlen($row['id'].($row['posisi'] == 0? 'ki': 'ka'));
                $silsilah = substr($silsilah, 0, (strlen($silsilah) - $parent_length));
            }
            $keluar = collect($omset_keluar)->chunk(10);

            foreach ($keluar as $ins)
            {
                OmsetKeluar::insert($ins->toArray());
            }
            $insert = collect($bonus)->chunk(10);
            foreach ($insert as $ins)
            {
                BagiHasil::insert($ins->toArray());
            }

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

        $this->reset(['name', 'email', 'country', 'package', 'position']);
        $this->updated();
        return $this->notification = [
            'tipe' => 'success',
            'pesan' => 'New member registration is successful. An email has been sent to '.$this->email
        ];
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
