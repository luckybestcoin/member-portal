<?php

namespace App\Http\Livewire;

use Livewire\Component;
use Illuminate\Support\Facades\Http;

class Coba extends Component
{
    public function render()
    {
        for ($i=0; $i < 17000; $i++) {
            $secret = 'FTC25LWSO54QZWZIU36STPSG7I657ERE';

            // $nonce = Carbon::now()->getPreciseTimestamp(3).$i;
            $header = ["X-Auth-Apikey" => "53bd98f87ba331f1", "X-Auth-Nonce" => $i, "X-Auth-Signature" => hash_hmac("SHA256", $i."53bd98f87ba331f1", "36f77e717cdadacba1a8dce95ce8ba66") ];
            $response = Http::withHeaders($header)->post('https://www.digiassetindo.com/api/v2/exchange/account/account_transfers', [
                'currency' => 'HEBA',
                'amount' => 1,
                'username_or_uid' => 'ID4C53159693',
            ])->json();
            sleep(100);
        }
        return view('livewire.coba');
    }
}
