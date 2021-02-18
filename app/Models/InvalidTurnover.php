<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InvalidTurnover extends Model
{
    use HasFactory;
    protected $table = 'invalid_turnover';
    protected $primaryKey = 'invalid_turnover';
}
