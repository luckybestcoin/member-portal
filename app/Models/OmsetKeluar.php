<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OmsetKeluar extends Model
{
    use HasFactory;
    protected $table = 'omset_keluar';
    protected $primaryKey = 'omset_keluar_id';
}
