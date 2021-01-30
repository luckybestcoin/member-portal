<?php

namespace App\Http\Livewire\Benefit;

use Carbon\Carbon;
use Livewire\Component;
use App\Models\BagiHasil;
use Livewire\WithPagination;

class Turnover extends Component
{
    use WithPagination;

    public $period = "This Month Only";

    protected $paginationTheme = 'bootstrap';
    protected $queryString = ['period'];

    public function render()
    {
        $pin = new BagiHasil();
        $data = $pin->where('anggota_id', auth()->id())->where('bagi_hasil_jenis', 'Turnover Growth');

        if($this->period === "This Month Only"){
            $from = Carbon::parse(now())->format("Y-m-01 00:00:00");
            $to = Carbon::parse(now())->format("Y-m-t 00:00:00");

            $data = $data->whereBetween('created_at', [
                $from,
                $to
            ]);
        }

        $data = $data->paginate(10);
        return view('livewire.benefit.turnover', [
            'no' => ($this->page - 1) * 10,
            'data' => $data,
            'total' => $pin->terakhiromset
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Benefit', 'Turnover Growth'],
            'title' => 'Turnover Growth Benefit',
            'description' => 'Turnover Growth Benefit that you have earned'
        ])
        ->section('subcontent');
    }
}
