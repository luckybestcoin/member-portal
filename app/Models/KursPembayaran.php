<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KursPembayaran extends Model
{
    use HasFactory;

    protected $table = 'kurs_pembayaran';
    protected $primaryKey = 'kurs_pembayaran_id';
}
