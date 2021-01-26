<?php

namespace App\Http\Livewire\Authentication;

use App\Models\Anggota;
use App\Models\Referal;
use Livewire\Component;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class Referral extends Component
{
    public $nama, $email, $no_hp, $paket, $anggota_id, $new_user_id, $new_password, $kode, $data, $agree;
    public $failed;

    protected $queryString = ['kode'];

    protected $rules = [
        'nama' => 'required',
        'email' => 'required',
        'no_hp' => 'required',
        'new_user_id' => 'required',
        'new_password' => 'required',
        'agree' => 'required'
    ];

    public function mount()
    {
        if ($this->kode) {
            $this->data = Referal::where('referal_token', $this->kode)->first();
            if($this->data){
                $this->anggota_id = $this->data->anggota_id;
                $this->nama = $this->data->anggota->anggota_nama;
                $this->email = $this->data->anggota->anggota_email;
                $this->no_hp = $this->data->anggota->anggota_hp;
                $this->paket = $this->data->anggota->paket->paket_nama;
            }
        }
    }

    public function submit()
    {
        try {
            // if ($this->data = Referal::where('referal_token', $this->kode)->count() === 0) {
            //     return $this->failed = 'Referral code not found';
            // }

            $this->validate();

            DB::transaction(function () {
                $anggota = Anggota::findOrFail($this->anggota_id);
                $anggota->anggota_uid = $this->new_user_id;
                $anggota->anggota_kata_sandi = Hash::make($this->new_password);
                $anggota->save();

                $this->data->delete();
            });

            if (Auth::attempt(['anggota_uid' => $this->new_user_id, 'password' => $this->new_password], false)) {
                Auth::logoutOtherDevices($this->new_password, 'anggota_kata_sandi');
                return redirect('dashboard');
            }
        } catch (\Throwable $th) {
            $this->failed = $th->getMessage();
        }
    }

    public function render()
    {
        return view('livewire.authentication.referral')->extends('layouts.app')->section('content');
    }
}
