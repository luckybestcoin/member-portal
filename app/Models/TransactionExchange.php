<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TransactionExchange extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'transaction_exchange';
    protected $primaryKey = null;
    public $incrementing = false;

    protected $fillable = array('transaction_exchange_amount', 'transaction_id', 'member_id', 'created_at', 'created_at');

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }

    public function getTotalAttribute()
    {
        return $total = $this->select('transaction_exchange_amount')->where('member_id', auth()->id())->get()->sum('transaction_exchange_amount');
    }
}
