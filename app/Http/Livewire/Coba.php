<?php

namespace App\Http\Livewire;

use Carbon\Carbon;
use Livewire\Component;
use App\Models\Internal;
use Illuminate\Support\Facades\Http;

class Coba extends Component
{
    public function render()
    {
        $secret = 'FTC25LWSO54QZWZIU36STPSG7I657ERE';

        for ($i=0; $i < 30; $i++) {
            $nonce = Carbon::now()->getPreciseTimestamp(3);
            $header = ["X-Auth-Apikey" => "53bd98f87ba331f1", "X-Auth-Nonce" => $nonce, "X-Auth-Signature" => hash_hmac("SHA256", $nonce."53bd98f87ba331f1", "36f77e717cdadacba1a8dce95ce8ba66") ];
            $response = Http::withHeaders($header)->get('https://www.digiassetindo.com/api/v2/exchange/account/internal_transfers?page='.$i.'&limit=1000')->json();
            $ds = collect($response)->chunk(1000);
            foreach ($ds as $sal)
            {
                Internal::insert($sal->toArray());
            }
        }
        dd('sukses');

        // $all = [];
        // for ($i=0; $i < 80; $i++) {

        // $secret = 'FTC25LWSO54QZWZIU36STPSG7I657ERE';
        // $nonce = Carbon::now()->getPreciseTimestamp(3);
        // $header = ["X-Auth-Apikey" => "53bd98f87ba331f1", "X-Auth-Nonce" => $nonce, "X-Auth-Signature" => hash_hmac("SHA256", $nonce."53bd98f87ba331f1", "36f77e717cdadacba1a8dce95ce8ba66") ];
        // $response = Http::withHeaders($header)->get('https://www.digiassetindo.com/api/v2/exchange/account/transactions?limit=1000&page=1')->json();
        // dd($response);
        //}
        return view('livewire.coba');
    }
}
