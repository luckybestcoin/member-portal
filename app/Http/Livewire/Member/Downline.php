<?php

namespace App\Http\Livewire\Member;

use App\Models\Member;
use Livewire\Component;
use Illuminate\Support\Facades\DB;

class Downline extends Component
{
    public $key;

    protected $queryString = ['key'];

    public function mount()
    {
        $this->key = $this->key?:auth()->user()->member_user;
    }

    public function setMember($key)
    {
        $this->key = $key;
        $this->emit('reinitialize');
    }

    public function render()
    {
        $data_member = Member::with('left_child')->with('right_child')->with('invalid_left_turnover')->with('invalid_right_turnover')->select("member_id", "member_email", "member_user",  "rating_id", "member_parent", "member_name", "member_position", "contract_price", "member_network", "due_date", "deleted_at",
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ki")))=concat(member.member_network, member.member_id, "ki") ) left_turnover'),
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ka")))=concat(member.member_network, member.member_id, "ka") ) right_turnover'))->where('member_user', $this->key);

        if ($this->key != auth()->user()->member_user) {
            $data_member = $data_member->where('member_network', 'like', auth()->id()."k%");
        }

        return view('livewire.member.downline', [
            'data' => $data_member->first()
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Member', 'Downline'],
            'title' => 'Downline'
        ])
        ->section('subcontent');
    }
}
