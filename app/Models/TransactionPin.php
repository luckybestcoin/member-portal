<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TransactionPin extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'transaction_pin';
    protected $primaryKey = null;
    public $incrementing = false;

    protected $fillable = array('transaction_pin_information', 'transaction_pin_amount', 'transaction_id', 'member_id', 'created_at', 'created_at');

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }

    public function getBalanceAttribute()
    {
        $pin = 0;
        return $balance = $this->select('transaction_pin_amount')->where('member_id', auth()->id())->get()->sum('transaction_pin_amount');
    }
}
