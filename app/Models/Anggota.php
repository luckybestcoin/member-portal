<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;

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

    public function getJaringanAttribute()
    {
        array_push($this->parent, [
            'id' => $data->pengguna_id,
            'user' => $data->pengguna_username,
            'parent' => $data->pengguna_parent,
            'silsilah' => $data->pengguna_silsilah,
            'paket' => $data->pengguna_paket,
            'posisi' => $data->pengguna_sisi,
            'founder' => $data->founder,
            'pair' => $data->pair,
            'kiri' => (float) $data->omset_kiri - (float) ($data->omset_keluar_kiri? $data->omset_keluar_kiri->omset_keluar_nilai: 0),
            'kanan' => (float) $data->omset_kanan - (float) ($data->omset_keluar_kanan? $data->omset_keluar_kanan->omset_keluar_nilai: 0),
            "status" => $data->status,
            'withdraw_terakhir' => $data->withdraw_terakhir
        ]);
        if($data->parent)
            $this->parent($data->parent);
    }
}
