<?php

namespace App\Http\Livewire;

use Livewire\Component;
use App\Models\TransactionReward;
use App\Models\TransactionExchange;
use App\Models\TransactionRewardPin;

class Dashboard extends Component
{
    public $reward, $fee, $conversion;

    public function mount()
    {
        $trx_reward = new TransactionReward();
        $trx_pin = new TransactionRewardPin();
        $this->reward = $trx_reward->balance;
        $this->fee = $trx_pin->balance;
    }

    public function render()
    {
        return view('livewire.dashboard')
        ->extends('livewire.main', [
            'breadcrumb' => [],
            'title' => 'Dashboard',
            'description' => 'Main Page'
        ])
        ->section('subcontent');
    }
}
