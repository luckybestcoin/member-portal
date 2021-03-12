<?php

namespace App\Http\Livewire;

use Carbon\Carbon;
use Livewire\Component;
use Livewire\WithPagination;
use App\Models\TransactionReward;

class RewardHistory extends Component
{
    use WithPagination;

    public $period = "This Month Only", $category = "All", $type = "All";

    protected $paginationTheme = 'bootstrap';
    protected $queryString = ['period'];

    public function render()
    {
        $transaction = new TransactionReward();
        $data = $transaction->where('member_id', auth()->id());


        if($this->period === "This Month Only"){
            $from = Carbon::parse(now())->format("Y-m-01 00:00:00");
            $to = Carbon::parse(now())->format("Y-m-t 00:00:00");

            $data = $data->whereBetween('created_at', [
                $from,
                $to
            ]);
        }

        if($this->type != "All"){
            $data = $data->where('transaction_reward_type', $this->type);
        }

        $data = $data->paginate(10);
        return view('livewire.reward-history', [
            'no' => ($this->page - 1) * 10,
            'data' => $data,
            'total' => $transaction->balance
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Reward'],
            'title' => 'Reward',
            'description' => 'Reward that you have earned'
        ])
        ->section('subcontent');
    }
}
