<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Pin extends Model
{
    use HasFactory;
    protected $table = 'pin';
    protected $primaryKey = 'pin_id';

    public function getTerakhirAttribute()
    {
        $pin = 0;
        $data_pin = $this->select('pin_debit', 'pin_kredit')->where('anggota_id', auth()->id())->get();
        if ($data_pin->count() > 0) {
            $pin = $data_pin->map(function ($pin)
            {
                return $pin->sum('pin_kredit') - $pin->sum('pin_debit');
            })->first();
        }
        return $pin;
    }
}
