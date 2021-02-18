<?php

namespace App\Http\Livewire\Pin;

use Carbon\Carbon;
use Livewire\Component;
use App\Models\PinReward;
use Livewire\WithPagination;

class Fee extends Component
{
    use WithPagination;

    public $period = "This Month Only";

    protected $paginationTheme = 'bootstrap';
    protected $queryString = ['period'];

    public function render()
    {
        $pin = new PinReward();
        $data = $pin->where('anggota_id', auth()->id());

        if($this->period === "This Month Only"){
            $from = Carbon::parse(now())->format("Y-m-01 00:00:00");
            $to = Carbon::parse(now())->format("Y-m-t 00:00:00");

            $data = $data->whereBetween('created_at', [
                $from,
                $to
            ]);
        }

        $data = $data->paginate(10);
        return view('livewire.pin.fee', [
            'no' => ($this->page - 1) * 10,
            'data' => $data,
            'total' => $pin->terakhir
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Pin', 'Fee'],
            'title' => 'Pin Fee',
            'description' => 'Pin fee that you have earned'
        ])
        ->section('subcontent');
    }
}
