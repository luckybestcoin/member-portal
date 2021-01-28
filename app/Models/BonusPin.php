<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BonusPin extends Model
{
    use HasFactory;

    protected $table = 'bonus_pin';
    protected $primaryKey = 'bonus_pin_id';
}
