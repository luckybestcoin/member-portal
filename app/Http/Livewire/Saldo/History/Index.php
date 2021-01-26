<?php

namespace App\Http\Livewire\Saldo\History;

use Carbon\Carbon;
use App\Models\Saldo;
use Livewire\Component;
use Livewire\WithPagination;

class Index extends Component
{
    use WithPagination;

    public $period = "This Month Only";

    protected $paginationTheme = 'bootstrap';
    public function render()
    {
        $saldo = new Saldo();
        $data = $saldo->where('anggota_id', auth()->id());

        if($this->period === "This Month Only"){
            $from = Carbon::parse(now())->format("Y-m-01 00:00:00");
            $to = Carbon::parse(now())->format("Y-m-t 00:00:00");

            $data = $data->whereBetween('created_at', [
                $from,
                $to
            ]);
        }

        $data = $data->paginate(10);
        return view('livewire.saldo.history.index', [
            'no' => ($this->page - 1) * 10,
            'data' => $data,
            'total' => $saldo->terakhir
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Balance', 'History'],
            'title' => 'Balance',
            'description' => 'The History of Your Balance'
        ])
        ->section('subcontent');
    }
}
