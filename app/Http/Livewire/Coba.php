<?php

namespace App\Http\Livewire;

use Carbon\Carbon;
use Livewire\Component;
use Illuminate\Support\Facades\Http;

class Coba extends Component
{
    public function render()
    {
        // $all = [];
        // for ($i=0; $i < 80; $i++) {
            $secret = 'FTC25LWSO54QZWZIU36STPSG7I657ERE';

            $nonce = Carbon::now()->getPreciseTimestamp(3);
            $header = ["X-Auth-Apikey" => "53bd98f87ba331f1", "X-Auth-Nonce" => $nonce, "X-Auth-Signature" => hash_hmac("SHA256", $nonce."53bd98f87ba331f1", "36f77e717cdadacba1a8dce95ce8ba66") ];
            $response = Http::withHeaders($header)->post('https://www.digiassetindo.com/api/v2/exchange/account/account_transfers', [
                'currency' => 'HEBA',
                'amount' => 1,
                'username_or_uid' => 'ID4C53159693',
            ])->json();
            dd($response);
        //}
        return view('livewire.coba');
    }
}
