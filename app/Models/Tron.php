<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tron extends Model
{
    use HasFactory;

    protected $table = 'tron';
    protected $primaryKey = 'id';
}
