<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CoinpaymentTransactionItems extends Model
{
    use HasFactory;

    protected $table = 'coinpayment_transaction_items';
    protected $primaryKey = null;
    public $incrementing = false;

}
