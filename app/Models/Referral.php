<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Referral extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'referral';
    protected $primaryKey = 'referral_id';

    public function member()
    {
        return $this->belongsTo('App\Models\Member', 'member_id');
    }
}
