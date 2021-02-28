<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class WalletController extends Controller
{
    public function send(Request $req)
    {
        try {
            $validator = Validator::make($req->all(), [
                'source' => 'required',
                'destination' => 'required',
                'amount' => 'required',
                'note' => 'required'
            ]);

            if ($validator->fails()) {
                $response = [
                    'success'   => false,
                    'header'    => "application/json",
                    'status'   => $validator->messages(),
                ];
            }else{
                bitcoind()->move($req->get('source'), $req->get('destination'), number_format($req->get('amount'), 8), 6, $req->get('note'));
                $response = [
                    'success'   => true,
                    'header'    => "application/json",
                    'status'   => 'OK',
                ];
            }
        }
        catch(\Exception $e)
        {
            $response = [
                'success'   => false,
                'header'    => "application/json",
                'status'   => strip_tags($e->getMessage())
            ];
        }
        return response()->json($response);
    }

    public function transaction(Request $req)
    {
        try {
            $validator = Validator::make($req->all(), [
                'user' => 'required'
            ]);

            if ($validator->fails()) {
                $response = [
                    'success'   => false,
                    'header'    => "application/json",
                    'status'   => $validator->messages(),
                ];
            }else{
                $balance = collect(bitcoind()->listtransactions($req->get('user'), 30)->result());
                $response = [
                    'success'   => true,
                    'header'    => "application/json",
                    'status'   => $balance,
                ];
            }
        }
        catch(\Exception $e)
        {
            $response = [
                'success'   => false,
                'header'    => "application/json",
                'status'   => strip_tags($e->getMessage())
            ];
        }
        return response()->json($response);
    }

    public function balance(Request $req)
    {
        try {
            $validator = Validator::make($req->all(), [
                'user' => 'required'
            ]);

            if ($validator->fails()) {
                $response = [
                    'success'   => false,
                    'header'    => "application/json",
                    'status'   => $validator->messages(),
                ];
            }else{
                $balance = bitcoind()->getbalance($req->get('user'))[0];
                $response = [
                    'success'   => true,
                    'header'    => "application/json",
                    'status'   => $balance,
                ];
            }
        }
        catch(\Exception $e)
        {
            $response = [
                'success'   => false,
                'header'    => "application/json",
                'status'   => strip_tags($e->getMessage())
            ];
        }
        return response()->json($response);
    }

    public function create(Request $req)
    {
        try
        {
            $validator = Validator::make($req->all(), [
                'nick' => 'required',
            ]);

            if ($validator->fails()) {
                $response = [
                    'success'   => false,
                    'header'    => "application/json",
                    'status'   => $validator->messages(),
                ];
            }else{
                $user = User::where('user_nick', $req->get('nick'))->first();
                $user->user_wallet = bitcoind()->getaccountaddress($req->get('nick'));
                $user->save();

                $response = [
                    'success'   => true,
                    'header'    => "application/json",
                    'status'   => 'OK',
                ];
            }
        }
        catch(\Exception $e)
        {
            $response = [
                'success'   => false,
                'header'    => "application/json",
                'status'   => strip_tags($e->getMessage())
            ];
        }
        return response()->json($response);
    }
}
