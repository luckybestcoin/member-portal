<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Anggota extends Authenticatable
{
    use HasFactory, Notifiable, SoftDeletes;

    protected $table = 'anggota';
    protected $primaryKey = 'anggota_id';
    protected $remmberTokenName = 'remember_token';

    protected $fillable = [
        'anggota_uid',
        'anggota_kata_sandi',
        'anggota_nama',
        'anggota_email',
        'anggota_hp',
        'paket_id',
        'peringkat_id'
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

    public function peringkat()
    {
        return $this->belongsTo('App\Models\Peringkat', 'peringkat_id');
    }

    public function parent()
    {
        return $this->hasOne('App\Models\Anggota', 'anggota_id', 'anggota_parent')->with('parent')->with('peringkat')->with('omset_keluar_kiri')->with('omset_keluar_kanan')->select("anggota_id", "anggota_uid", "peringkat_id", "anggota_parent", "anggota_posisi", "paket_harga", "anggota_jaringan", "jatuh_tempo", "deleted_at",
        DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_jaringan, anggota.anggota_id, "ki")))=concat(anggota.anggota_jaringan, anggota.anggota_id, "ki") ) omset_kiri'),
        DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_jaringan, anggota.anggota_id, "ka")))=concat(anggota.anggota_jaringan, anggota.anggota_id, "ka") ) omset_kanan'))->withTrashed();
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
