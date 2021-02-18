<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rating extends Model
{
    use HasFactory;

    protected $table = 'rating';
    protected $primaryKey = 'rating_id';

    public function anggota()
    {
        return $this->hasMany('App\Models\Member', 'rating_id');
    }
}
