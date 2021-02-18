<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PinReward extends Model
{
    use HasFactory;

    protected $table = 'bonus_pin';
    protected $primaryKey = 'bonus_pin_id';

    public function getTerakhirAttribute()
    {
        $bonus = 0;
        $data_bonus = $this->select('bonus_pin_debit', 'bonus_pin_kredit')->where('anggota_id', auth()->id())->get();

        return $data_bonus->sum('bonus_pin_kredit') - $data_bonus->sum('bonus_pin_debit');
    }
}
