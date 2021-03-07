<?php

namespace App\Http\Controllers;

use App\Models\Rate;
use App\Models\User;
use Illuminate\Http\Request;
use App\Models\TransactionPin;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class WalletController extends Controller
{
    public function balance(Request $req)
    {
        $rate = new Rate();
        $lbc_balance = bitcoind()->getbalance(auth()->user()->username)[0];
        $rate_dollar = $rate->last_dollar;
        return "LBC : ".$lbc_balance." = $ ".number_format($lbc_balance * $rate_dollar, 2);
    }

    public function pin(Request $req)
    {
        $pin = new TransactionPin();
        return $pin->balance;
    }

    public function turnover(Request $req)
    {
        return $omset = auth()->user()->select(
            DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ki")))=concat(member.member_network, member.member_id, "ki") ) left_turnover'),
            DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ka")))=concat(member.member_network, member.member_id, "ka") ) right_turnover'))->where('member_id', auth()->id())->first();
    }
}
