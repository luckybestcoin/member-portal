<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Achievement extends Model
{
    use HasFactory;

    protected $table = 'achievement';
    protected $primaryKey = ['rating_id', 'member_id'];
    protected $keyType = 'string';
    public $incrementing = false;


    public function rating()
    {
        return $this->belongsTo('App\Models\Rating', 'rating_id');
    }
}
