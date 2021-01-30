<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Saldo extends Model
{
    use HasFactory;

    protected $table = 'saldo';
    protected $primaryKey = 'saldo_id';

    public function getTerakhirAttribute()
    {
        $saldo = 0;
        $data_saldo = $this->select('saldo_debit', 'saldo_kredit')->where('anggota_id', auth()->id())->get();
        return $data_saldo->sum('saldo_kredit') - $data_saldo->sum('saldo_debit');
    }
}
