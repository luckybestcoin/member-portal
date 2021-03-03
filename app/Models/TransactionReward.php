<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TransactionReward extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'transaction_reward';
    protected $primaryKey = "transaction_reward_id";

    protected $fillable = array('transaction_reward_information', 'transaction_reward_type', 'transaction_reward_amount', 'transaction_id', 'member_id', 'created_at', 'created_at');

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }

    public function getBalanceAttribute()
    {
        $pin = 0;
        return $balance = $this->select('transaction_reward_amount')->where('member_id', auth()->id())->get()->sum('transaction_reward_amount');
    }

    public function getConvertedAttribute()
    {
        $pin = 0;
        return $balance = $this->select('transaction_reward_amount')->where('transaction_reward_type', "Conversion")->where('member_id', auth()->id())->get()->sum('transaction_reward_amount');
    }
}
