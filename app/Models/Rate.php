<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rate extends Model
{
    use HasFactory;

    protected $table = 'rate';
    protected $primaryKey = 'rate_id';

    public function getLastDollarAttribute()
    {
        return $this->where('rate_currency', 'USD')->orderBy('created_at', 'desc')->get()->first()->rate_price;
    }
}
