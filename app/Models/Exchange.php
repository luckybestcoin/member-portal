<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Exchange extends Model
{
    use HasFactory;

    protected $table = 'exchange';
    protected $primaryKey = 'exchange_id';
}
