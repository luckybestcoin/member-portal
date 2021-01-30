<?php

namespace App\Http\Livewire\Member;

use App\Models\Anggota;
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
        $data_member = Anggota::with('child_kiri')->with('child_kanan')->with('omset_keluar_kiri')->with('omset_keluar_kanan')->select("anggota_id", "anggota_uid", "peringkat_id", "anggota_parent", "anggota_nama", "anggota_posisi", "paket_harga", "anggota_jaringan", "jatuh_tempo", "deleted_at",
        DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_jaringan, anggota.anggota_id, "ki")))=concat(anggota.anggota_jaringan, anggota.anggota_id, "ki") ) omset_kiri'),
        DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_jaringan, anggota.anggota_id, "ka")))=concat(anggota.anggota_jaringan, anggota.anggota_id, "ka") ) omset_kanan'))->where('anggota_id', $this->member)->first();
        // dd($data_member);
        return view('livewire.member.downline', [
            'data' => $data_member
        ])
        ->extends('livewire.main', [
            'breadcrumb' => ['Member', 'Downline'],
            'title' => 'Downline',
            'description' => 'Your downline member'
        ])
        ->section('subcontent');
    }
}
