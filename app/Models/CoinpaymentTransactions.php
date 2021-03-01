<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CoinpaymentTransactions extends Model
{
    use HasFactory;

    protected $table = 'coinpayment_transactions';
    protected $primaryKey = 'id';

    public function items()
    {
        return $this->hasMany('App\Models\CoinpaymentTransactionItems', 'coinpayment_transaction_id', 'id');
    }
}
