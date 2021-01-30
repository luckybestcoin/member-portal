<?php

namespace App\Http\Livewire\Authentication;

use Carbon\Carbon;
use App\Models\Anggota;
use App\Models\Referal;
use Livewire\Component;
use App\Models\BagiHasil;
use App\Models\Peringkat;
use App\Models\Transaksi;
use App\Models\Pencapaian;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class Referral extends Component
{
    public $name, $email, $phone_number, $package, $anggota_id, $new_user_id, $new_password, $kode, $data, $agree;
    public $notification;

    protected $queryString = ['kode'];

    protected $rules = [
        'name' => 'required',
        'email' => 'required',
        'phone_number' => 'required',
        'new_user_id' => 'required',
        'new_password' => 'required',
        'agree' => 'required'
    ];

    public function mount()
    {
        if ($this->kode) {
            $this->data = Referal::where('referal_token', $this->kode)->first();
            if($this->data){
                $this->anggota_id = $this->data->anggota_id;
                $this->name = $this->data->anggota->anggota_nama;
                $this->email = $this->data->anggota->anggota_email;
                $this->phone_number = $this->data->anggota->anggota_hp;
                $this->package = $this->data->anggota->paket_harga;
            }
        }
    }

    private $parent = [];

    public function setParent($data)
    {
        $omset_kiri = (float) $data->omset_kiri - (float) $data->omset_keluar_kiri->sum('omset_keluar_jumlah');
        $omset_kanan = (float) $data->omset_kanan - (float) $data->omset_keluar_kiri->sum('omset_keluar_jumlah');

        if(strlen($data->deleted_at) === 0 || $data->jatuh_tempo){
            array_push($this->parent, [
                'id' => $data->anggota_id,
                'user' => $data->anggota_uid,
                'parent' => $data->anggota_parent,
                'silsilah' => $data->anggota_jaringan,
                'paket' => $data->paket_harga,
                'posisi' => $data->anggota_posisi,
                'founder' => $data->anggota_parent? 0: 1,
                'pair' => $omset_kiri > 0 && $omset_kanan > 0? 1: 0,
                'kiri' => $omset_kiri,
                'kanan' => $omset_kanan,
                'peringkat' => $data->peringkat? $data->peringkat->peringkat_nama: null,
                "aktif" => $data->deleted_at? 0: 1,
                'jatuh_tempo' => $data->jatuh_tempo
            ]);
        }

        if($data->parent)
            $this->setParent($data->parent);
    }

    public function updated()
    {
        $this->reset('notification');
    }

    public function submit()
    {
        $error = null;

        if (Referal::where('referal_token', $this->kode)->count() === 0) {
            return $error .= '<li>Invalid referral code!!!</li>';
        }

        if ($error) {
            $this->reset(['amount', 'password']);
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $error
            ];
        }

        $this->validate();

        DB::transaction(function () {
            $anggota = Anggota::findOrFail($this->anggota_id);
            $anggota->anggota_uid = $this->new_user_id;
            $anggota->anggota_kata_sandi = Hash::make($this->new_password);
            $anggota->save();

            $this->data->delete();

            $keterangan = "Member activation on behalf of ".$this->new_user_id;

            $id = Str::random(10)."-".date('Ymdhis').round(microtime(true) * 1000);

            $transaksi = new Transaksi();
            $transaksi->transaksi_id = $id;
            $transaksi->transaksi_keterangan = $keterangan." by ".$anggota->anggota_uid;
            $transaksi->save();

            $this->setParent(Anggota::with('parent')->with('peringkat')->with('omset_keluar_kiri')->with('omset_keluar_kanan')->select("anggota_id", "anggota_uid", "anggota_parent", "anggota_posisi", "peringkat_id", "paket_harga", "anggota_jaringan", "jatuh_tempo", "deleted_at",
            DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ki")))=concat(anggota.anggota_id, "ki") ) omset_kiri'),
            DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ka")))=concat(anggota.anggota_id, "ka") ) omset_kanan'))->where('anggota_id', $this->anggota_id)->first());

            $data_peringkat = Peringkat::all();

            $bonus = [];
            $omset_keluar = [];
            $parent_length = 0;
            $silsilah = $anggota->anggota_jaringan;
            foreach (collect($this->parent)->filter(function($q) use($anggota){
                return $q['id'] != $anggota->anggota_id;
            }) as $key => $row) {
                $pencapaian = 0;
                if(is_null($row['jatuh_tempo']) == 1 && $row['aktif'] == 1){
                    $kaki_kecil = collect([$row['kiri'], $row['kanan']])->min();
                    $member = Anggota::findOrFail($row['id']);

                    $peringkat = $data_peringkat->filter(function ($q) use ($kaki_kecil)
                    {
                        return $q->peringkat_omset_min <= $kaki_kecil;
                    })->sortBy('peringkat_omset_min')->first();

                    if ($peringkat && Pencapaian::where('anggota_id', $row['id'])->where('pencapaian_id', $member->peringkat_id)->count() == 0) {
                        $member->peringkat_id = $peringkat['peringkat_id'];

                        $pcp = new Pencapaian();
                        $pcp->anggota_id = $row['id'];
                        $pcp->peringkat_id = $peringkat->peringkat_id;
                        $pcp->save();
                    }else{
                        $member->peringkat_id = null;
                    }
                    $member->save();

                    if($row['pair'] === 1) {
                        $pairing = "Turnonver growth ".$this->new_user_id." 5% of ".number_format($anggota->paket_harga, 2);
                        if(substr($silsilah, -2) == 'ki'){
                            if($row['kiri'] - $anggota->paket_harga < $row['kanan']){
                                $nilai_bonus = 0;
                                if($row['kiri'] > $row['kanan']){
                                    $nilai_bonus = $row['kanan'] - $row['kiri'] + $anggota->paket_harga;
                                }else{
                                    $nilai_bonus = $anggota->paket_harga;
                                }
                                array_push($bonus,[
                                    'bagi_hasil_keterangan' => $pairing." left side registration",
                                    'bagi_hasil_jenis' => "Turnover Growth",
                                    'bagi_hasil_debit' => 0,
                                    'bagi_hasil_kredit' => $nilai_bonus * 5 /100,
                                    'transaksi_id' => $id,
                                    'anggota_id' => $row['id'],
                                    'created_at' => Carbon::now(),
                                    'updated_at' => Carbon::now()
                                ]);
                            }
                        }else if(substr($silsilah, -2) == 'ka'){
                            if($row['kanan'] - $anggota->paket_harga < $row['kiri']){
                                $nilai_bonus = 0;
                                if($row['kanan'] > $row['kiri']){
                                    $nilai_bonus = $row['kiri'] - $row['kanan'] + $anggota->paket_harga;
                                }else{
                                    $nilai_bonus = $anggota->paket_harga;
                                }
                                array_push($bonus,[
                                    'bagi_hasil_keterangan' => $pairing." right side registration",
                                    'bagi_hasil_jenis' => "Turnover Growth",
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
                        'omset_keluar_jumlah' => $anggota->paket_harga,
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
        });

        if (Auth::attempt(['anggota_uid' => $this->new_user_id, 'password' => $this->new_password], false)) {
            Auth::logoutOtherDevices($this->new_password, 'anggota_kata_sandi');
            return redirect('dashboard');
        }
        return $this->notification = [
            'tipe' => 'success',
            'pesan' => 'Your account activation is successful!!!'
        ];
    }

    public function render()
    {
        return view('livewire.authentication.referral')->extends('layouts.app')->section('content');
    }
}
