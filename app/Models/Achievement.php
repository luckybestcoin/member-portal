<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Achievement extends Model
{
    use HasFactory;

    protected $table = 'achievement';
    protected $primaryKey = 'achievement_id';


    public function rating()
    {
        return $this->belongsTo('App\Models\Rating', 'rating_id');
    }
}
