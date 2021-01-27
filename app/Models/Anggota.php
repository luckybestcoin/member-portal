<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Anggota extends Authenticatable
{
    use HasFactory, Notifiable;

    protected $table = 'anggota';
    protected $primaryKey = 'anggota_id';
    protected $remmberTokenName = 'remember_token';

    protected $fillable = [
        'anggota_uid',
        'anggota_kata_sandi',
        'anggota_nama',
        'anggota_email',
        'anggota_hp',
        'paket_id'
    ];

    protected $hidden = [
        'anggota_kata_sandi',
        'remember_token',
    ];

    public function getAuthPassword()
    {
        return $this->anggota_kata_sandi;
    }

    public function wallet()
    {
        return $this->hasOne('App\Models\Wallet', 'anggota_id');
    }

    public function paket()
    {
        return $this->belongsTo('App\Models\Paket', 'paket_id');
    }

    public function peringkat()
    {
        return $this->belongsTo('App\Models\Peringkat', 'peringkat_id');
    }

    // private $parent = [];

    // private function setParent($data)
    // {
    //     array_push($this->parent, [
    //         'id' => $data->anggota_id,
    //         'user' => $data->anggota_uid,
    //         'parent' => $data->anggota_parent,
    //         'silsilah' => $data->anggota_jaringan,
    //         'paket' => $data->paket->paket_harga,
    //         'posisi' => $data->anggota_posisi,
    //         'founder' => $data->anggota_parent? 0: 1,
    //         'pair' => $data->pair,
    //         'kiri' => (float) $data->omset_kiri - (float) ($data->omset_keluar_kiri? $data->omset_keluar_kiri->omset_keluar_nilai: 0),
    //         'kanan' => (float) $data->omset_kanan - (float) ($data->omset_keluar_kanan? $data->omset_keluar_kanan->omset_keluar_nilai: 0),
    //         "deleted_at" => $data->deleted_at,
    //         'jatuh_tempo' => $data->jatuh_tempo
    //     ]);
    //     if($data->parent)
    //         $this->setParent($data->parent);
    // }

    // public function getParentAttribute()
    // {
    //     return $this->with('parent');
    // }

    public function parent()
    {
        return $this->hasOne('App\Models\Anggota', 'anggota_id', 'anggota_parent')->with('parent')->with('omset_keluar_kiri')->with('omset_keluar_kanan')->select("anggota_id", "anggota_uid", "anggota_parent", "anggota_posisi", "paket_harga", "anggota_jaringan", "jatuh_tempo", "deleted_at",
        DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where left(a.anggota_jaringan, length(concat(anggota.anggota_jaringan, anggota.anggota_id, "ki")))=concat(anggota.anggota_jaringan, anggota.anggota_id, "ki") ) omset_kiri'),
        DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where left(a.anggota_jaringan, length(concat(anggota.anggota_jaringan, anggota.anggota_id, "ka")))=concat(anggota.anggota_jaringan, anggota.anggota_id, "ka") ) omset_kanan'),
        DB::raw('(select ifnull(count(anggota_id), 0) pair from anggota a where a.anggota_parent = anggota.anggota_id) pair'));
    }

    public function omset_keluar_kanan()
    {
        return $this->hasMany('App\Models\OmsetKeluar', 'anggota_id')->where("omset_keluar_posisi", 1);
    }

    public function omset_keluar_kiri()
    {
        return $this->hasMany('App\Models\OmsetKeluar', 'anggota_id')->where("omset_keluar_posisi", 0);
    }
}
