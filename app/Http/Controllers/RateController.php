<?php

namespace App\Http\Controllers;

use App\Models\Rate;
use Illuminate\Http\Request;

class RateController extends Controller
{
    //
    public function dollar()
    {
        $data = [];
        foreach ( Rate::where('rate_currency', 'USD')->orderBy('created_at')->get() as $index => $row) {
            array_push($data ,[
                strtotime($row->created_at) * 1000,
                (float)$row->rate_price,
            ]);
        }
        return $data;
    }
}
