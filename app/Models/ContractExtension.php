<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ContractExtension extends Model
{
    use HasFactory;

    protected $table = 'reinvest';
    protected $primaryKey = 'reinvest_id';
}
