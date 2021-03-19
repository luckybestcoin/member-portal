<?php

namespace App\Http\Livewire;

use Livewire\Component;
use App\Models\Achievement;
use App\Models\TransactionReward;
use App\Models\TransactionExchange;
use App\Models\TransactionRewardPin;

class Dashboard extends Component
{
    public $reward, $fee, $conversion, $daily, $trx_exchange_reward = 0, $achievement, $remaining;

    public function mount()
    {
        $trx_reward = new TransactionReward();
        $trx_pin = new TransactionRewardPin();
        $trx_exchange = new TransactionExchange();
        $this->achievement = Achievement::where('member_id', auth()->id())->orderBy('rating_id')->with('rating')->get();
        $this->trx_exchange_reward = $trx_exchange->total_reward;
        $this->remaining = $trx_reward->where('member_id', auth()->id())->get()->sum('transaction_reward_amount');
        $this->reward = $trx_reward->where('member_id', auth()->id())->where('transaction_reward_amount', '>', 0)->get()->sum('transaction_reward_amount');
        $this->daily = $trx_reward->where('transaction_reward_type', 'Daily')->where('member_id', auth()->id())->get()->sum('transaction_reward_amount');
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
