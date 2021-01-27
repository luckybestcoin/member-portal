<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reinvest extends Model
{
    use HasFactory;

    protected $table = 'reinvest';
    protected $primaryKey = 'reinvest_id';
}
