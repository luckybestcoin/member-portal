<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BagiHasil extends Model
{
    use HasFactory;

    protected $table = 'bagi_hasil';
    protected $primaryKey = 'bagi_hasil_id';
}
