<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Referal extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'referal';
    protected $primaryKey = 'referal_id';

    public function anggota()
    {
        return $this->belongsTo('App\Models\Anggota', 'anggota_id');
    }
}
