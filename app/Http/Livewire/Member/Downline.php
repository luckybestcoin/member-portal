<?php

namespace App\Http\Livewire\Member;

use App\Models\Member;
use Livewire\Component;
use Illuminate\Support\Facades\DB;

class Downline extends Component
{
    public $member;

    public function mount()
    {
        $this->member = $this->member?:auth()->id();
    }

    public function setMember($member)
    {
        $this->member = $member;
        $this->emit('reinitialize');
    }

    public function render()
    {
        $data_member = Member::with('left_child')->with('right_child')->with('invalid_left_turnover')->with('invalid_right_turnover')->select("member_id", "member_email", "member_user",  "rating_id", "member_parent", "member_name", "member_position", "contract_price", "member_network", "due_date", "deleted_at",
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ki")))=concat(member.member_network, member.member_id, "ki") ) left_turnover'),
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ka")))=concat(member.member_network, member.member_id, "ka") ) right_turnover'))->where('member_id', $this->member)->first();
        // dd($data_member);
        return view('livewire.member.downline', [
            'data' => $data_member
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Member', 'Downline'],
            'title' => 'Downline'
        ])
        ->section('subcontent');
    }
}
