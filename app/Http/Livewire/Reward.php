<?php

namespace App\Http\Livewire;

use Carbon\Carbon;
use Livewire\Component;
use App\Models\BagiHasil;
use Livewire\WithPagination;

class Reward extends Component
{
    use WithPagination;

    public $period = "This Month Only", $category = "All";

    protected $paginationTheme = 'bootstrap';
    protected $queryString = ['period'];

    public function render()
    {
        $pin = new BagiHasil();
        $data = $pin->where('anggota_id', auth()->id());

        if ($this->category != 'All') {
            $data = $data->where('bagi_hasil_jenis', $this->category);
        }

        if($this->period === "This Month Only"){
            $from = Carbon::parse(now())->format("Y-m-01 00:00:00");
            $to = Carbon::parse(now())->format("Y-m-t 00:00:00");

            $data = $data->whereBetween('created_at', [
                $from,
                $to
            ]);
        }

        $data = $data->paginate(10);
        return view('livewire.reward', [
            'no' => ($this->page - 1) * 10,
            'data' => $data,
            'total' => $pin->terakhir
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Reward'],
            'title' => 'Reward',
            'description' => 'Reward that you have earned'
        ])
        ->section('subcontent');
    }
}
