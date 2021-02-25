<?php

namespace App\Http\Livewire;

use Livewire\Component;
use App\Models\Achievement;

class AchievementHistory extends Component
{
    public function render()
    {
        $data = Achievement::where('member_id', auth()->id())->with('rating')->get();
        return view('livewire.achievement-history', [
            'data' => $data
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Achievement'],
            'title' => 'Achievement'
        ])
        ->section('subcontent');
    }
}
