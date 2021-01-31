<?php

namespace App\Http\Livewire\Registrationticket;

use Carbon\Carbon;
use App\Models\Pin;
use App\Models\Saldo;
use App\Models\Anggota;
use Livewire\Component;
use App\Models\BonusPin;
use App\Models\Peringkat;
use App\Models\Transaksi;
use App\Models\Pendapatan;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Buy extends Component
{
    public $amount, $password, $back, $notification, $harga_tiket;

    protected $rules = [
        'amount' => 'numeric',
        'password' => 'required'
    ];

    public function mount()
    {
        $this->harga_tiket = config("constant.harga_tiket");
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

    public function submit()
    {
        $this->validate();

        $saldo = new Saldo();
        $error = null;

        $this->reset('notification');

        if(Hash::check($this->password, auth()->user()->anggota_kata_sandi) === false){
            return $error .= "<li>Wrong <strong>password</strong></li>";
        }

        if ($this->amount <= 0) {
            $error .= "<li>Amount cannot be less than 0</li>";
        }

        // if ($saldo->terakhir < $this->harga_tiket * $this->amount) {
        //     $error .= "<li>Insufficient <strong>balance</strong></li>";
        // }

        if ($error) {
            $this->reset(['amount', 'password']);
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
            $transaksi->transaksi_keterangan = $keterangan." by ".auth()->user()->anggota_uid;
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

            $pembagian = [];
            $now = Carbon::now();

            $jenis = 'Registration Ticket';
            $pendapatan = new Pendapatan();
            $pendapatan->pendapatan_keterangan = $keterangan." by ".auth()->user()->anggota_uid;
            $pendapatan->pendapatan_jenis = $jenis;
            $pendapatan->pendapatan_jumlah = config("constant.admin_harga_tiket") * $this->amount;
            $pendapatan->transaksi_id = $id;
            $pendapatan->save();

            if(strlen(trim(auth()->user()->anggota_parent)) == 0){
                array_push($pembagian,[
                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                    'bonus_pin_debit' => 0,
                    'bonus_pin_kredit' => 7 * $this->amount,
                    'transaksi_id' => $id,
                    'anggota_id' => auth()->id(),
                    'created_at' => $now,
                    'updated_at' => $now
                ]);
            }else{
                $this->setParent(Anggota::with('parent')->with('peringkat')->with('omset_keluar_kiri')->with('omset_keluar_kanan')->select("anggota_id", "anggota_uid", "anggota_parent", "anggota_posisi", "peringkat_id", "paket_harga", "anggota_jaringan", "jatuh_tempo", "deleted_at",
                DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ki")))=concat(anggota.anggota_id, "ki") ) omset_kiri'),
                DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ka")))=concat(anggota.anggota_id, "ka") ) omset_kanan'))->where('anggota_id', auth()->id())->first());

                $parent = collect($this->parent);

                $founder = $parent->where('founder', 1);
                $bronze = $parent->where('peringkat', 'Bronze');
                $silver = $parent->where('peringkat', 'Silver');
                $gold = $parent->where('peringkat', 'Gold');

                if($bronze){
                    if ($silver) {
                        if($gold){
                            array_push($pembagian,[
                                'anggota_id' => $bronze->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 3.5 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            array_push($pembagian,[
                                'anggota_id' => $silver->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 1.75 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            array_push($pembagian,[
                                'anggota_id' => $gold->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 1.05 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            if ($founder) {
                                array_push($pembagian,[
                                    'anggota_id' => $founder->first()['id'],
                                    'transaksi_id' => $id,
                                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                    'bonus_pin_debit' => 0,
                                    'bonus_pin_kredit' => 0.7 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                            }
                        }else{
                            array_push($pembagian,[
                                'anggota_id' => $bronze->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 3.5 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            array_push($pembagian,[
                                'anggota_id' => $silver->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 2.1 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            if ($founder) {
                                array_push($pembagian,[
                                    'anggota_id' => $founder->first()['id'],
                                    'transaksi_id' => $id,
                                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                    'bonus_pin_debit' => 0,
                                    'bonus_pin_kredit' => 1.4 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                            }
                        }
                    }else{
                        if($gold){
                            array_push($pembagian,[
                                'anggota_id' => $bronze->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 3.5 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            array_push($pembagian,[
                                'anggota_id' => $gold->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 2.1 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            if ($founder) {
                                array_push($pembagian,[
                                    'anggota_id' => $founder->first()['id'],
                                    'transaksi_id' => $id,
                                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                    'bonus_pin_debit' => 0,
                                    'bonus_pin_kredit' => 1.4 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                            }
                        }else{
                            array_push($pembagian,[
                                'anggota_id' => $bronze->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 3.5 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            if ($founder) {
                                array_push($pembagian,[
                                    'anggota_id' => $founder->first()['id'],
                                    'transaksi_id' => $id,
                                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                    'bonus_pin_debit' => 0,
                                    'bonus_pin_kredit' => 3.5 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                            }
                        }
                    }
                }else {
                    if($silver){
                        if($gold){
                            array_push($pembagian,[
                                'anggota_id' => $silver->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 4.2 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            array_push($pembagian,[
                                'anggota_id' => $gold->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 1.75 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            if ($founder) {
                                array_push($pembagian,[
                                    'anggota_id' => $founder->first()['id'],
                                    'transaksi_id' => $id,
                                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                    'bonus_pin_debit' => 0,
                                    'bonus_pin_kredit' => 1.05 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                            }
                        }else{
                            array_push($pembagian,[
                                'anggota_id' => $silver->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 4.2 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            if ($founder) {
                                array_push($pembagian,[
                                    'anggota_id' => $founder->first()['id'],
                                    'transaksi_id' => $id,
                                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                    'bonus_pin_debit' => 0,
                                    'bonus_pin_kredit' => 2.8 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                            }
                        }
                    }else{
                        if($gold){
                            array_push($pembagian,[
                                'anggota_id' => $gold->first()['id'],
                                'transaksi_id' => $id,
                                'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                'bonus_pin_debit' => 0,
                                'bonus_pin_kredit' => 5.25 * $this->amount,
                                'created_at' => $now,
                                'updated_at' => $now
                            ]);
                            if ($founder) {
                                array_push($pembagian,[
                                    'anggota_id' => $founder->first()['id'],
                                    'transaksi_id' => $id,
                                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                    'bonus_pin_debit' => 0,
                                    'bonus_pin_kredit' => 1.75 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                            }
                        }else{
                            if ($founder) {
                                array_push($pembagian,[
                                    'anggota_id' => $founder->first()['id'],
                                    'transaksi_id' => $id,
                                    'bonus_pin_keterangan' => $keterangan." by ".auth()->user()->anggota_uid,
                                    'bonus_pin_debit' => 0,
                                    'bonus_pin_kredit' => 7 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                            }
                        }
                    }
                }
            }

            $insert = collect($pembagian)->chunk(10);
            foreach ($insert as $ins)
            {
                BonusPin::insert($ins->toArray());
            }
        });

        $this->reset(['amount', 'password']);

        return $this->notification = [
            'tipe' => 'success',
            'pesan' => 'Registration ticket purchase was successful!!!'
        ];
    }

    public function updated()
    {
        $this->reset('notification');
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
