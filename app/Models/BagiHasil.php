<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BagiHasil extends Model
{
    use HasFactory;

    protected $table = 'bagi_hasil';
    protected $primaryKey = 'bagi_hasil_id';

    public function getTerakhirAttribute()
    {
        $bonus = 0;
        $data_bonus = $this->select('bagi_hasil_debit', 'bagi_hasil_kredit')->where('anggota_id', auth()->id())->get();

        return $data_bonus->sum('bagi_hasil_kredit') - $data_bonus->sum('bagi_hasil_debit');
    }

    public function getTerakhirHarianAttribute()
    {
        $bonus = 0;
        $data_bonus = $this->select('bagi_hasil_debit', 'bagi_hasil_kredit')->where('bagi_hasil_jenis', 'Daily')->where('anggota_id', auth()->id())->get();

        return $data_bonus->sum('bagi_hasil_kredit') - $data_bonus->sum('bagi_hasil_debit');
    }

    public function getTerakhirOmsetAttribute()
    {
        $bonus = 0;
        $data_bonus = $this->select('bagi_hasil_debit', 'bagi_hasil_kredit')->where('bagi_hasil_jenis', 'Turnover Growth')->where('anggota_id', auth()->id())->get();

        return $data_bonus->sum('bagi_hasil_kredit') - $data_bonus->sum('bagi_hasil_debit');
    }

    public function getTerakhirReferalAttribute()
    {
        $bonus = 0;
        $data_bonus = $this->select('bagi_hasil_debit', 'bagi_hasil_kredit')->where('bagi_hasil_jenis', 'Referral')->where('anggota_id', auth()->id())->get();

        return $data_bonus->sum('bagi_hasil_kredit') - $data_bonus->sum('bagi_hasil_debit');
    }
}
