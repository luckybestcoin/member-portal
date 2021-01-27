<?php

namespace App\Http\Livewire\Registrationticket;

use Carbon\Carbon;
use App\Models\Pin;
use Livewire\Component;
use Livewire\WithPagination;

class History extends Component
{
    use WithPagination;

    public $period = "This Month Only";

    protected $paginationTheme = 'bootstrap';
    public function render()
    {
        $pin = new Pin();
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
        return view('livewire.registrationticket.history', [
            'no' => ($this->page - 1) * 10,
            'data' => $data,
            'total' => $pin->terakhir
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Registration Ticket', 'History'],
            'title' => 'Registration Ticket',
            'description' => 'The History of Your Registration Ticket'
        ])
        ->section('subcontent');
    }
}
