<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TransactionRewardPin extends Model
{
    use HasFactory;
    protected $table = 'transaction_reward_pin';
    protected $primaryKey = null;
    public $incrementing = false;

    protected $fillable = array('transaction_pin_information', 'transaction_reward_pin_amount', 'transaction_id', 'member_id', 'created_at', 'created_at');

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }

    public function getBalanceAttribute()
    {
        $pin = 0;
        return $balance = $this->select('transaction_reward_pin_amount')->where('member_id', auth()->id())->get()->sum('transaction_reward_pin_amount');
    }
}