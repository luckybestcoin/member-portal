<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Peringkat extends Model
{
    use HasFactory;

    protected $table = 'peringkat';
    protected $primaryKey = 'peringkat_id';
}
