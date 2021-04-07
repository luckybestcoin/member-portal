<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TransactionExchange extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'transaction_exchange';
    protected $primaryKey = 'transaction_exchange_id';

    protected $fillable = array('transaction_exchange_amount', 'transaction_id', 'member_id', 'created_at', 'created_at');

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }

    public function getTotalPinAttribute()
    {
        return $total = $this->select('transaction_exchange_amount')->where('transaction_exchange_type', 'Pin Fee')->where('member_id', auth()->id())->get()->sum('transaction_exchange_amount');
    }

    public function getTotalRewardAttribute()
    {
        return $total = $this->select('transaction_exchange_amount')->where('transaction_exchange_type', 'Reward')->where('member_id', auth()->id())->get()->sum('transaction_exchange_amount');
    }

    public function getLastRewardAttribute()
    {
        return $this->select('created_at')->where('member_id', auth()->id())->where('transaction_exchange_type', 'Reward')->orderBy('created_at', 'desc')->first()->created_at;
    }

    public function getLastPinFeeAttribute()
    {
        return $this->select('created_at')->where('member_id', auth()->id())->where('transaction_exchange_type', 'Pin Fee')->orderBy('created_at', 'desc')->first()->created_at;
    }
}
