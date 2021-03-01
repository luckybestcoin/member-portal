<?php

namespace App\Http\Livewire\Authentication;

use Carbon\Carbon;
use App\Models\Member;
use App\Models\Rating;
use App\Models\Wallet;
use Livewire\Component;
use App\Models\Referral;
use App\Models\Achievement;
use App\Models\Transaction;
use Illuminate\Support\Str;
use App\Models\TransactionReward;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class Activation extends Component
{
    public $name, $email, $phone_number, $new_username, $contract_price, $member_id, $new_user_id, $new_password, $token, $data, $agree;
    public $notification;

    protected $queryString = ['token'];

    protected $rules = [
        'name' => 'required',
        'email' => 'required',
        'phone_number' => 'required',
        'new_username' => 'required',
        'new_password' => 'required',
        'agree' => 'required'
    ];

    public function mount()
    {
        if ($this->token) {
            $this->data = Referral::where('referral_token', $this->token)->first();
            if($this->data && $this->data->member){
                $this->member_id = $this->data->member_id;
                $this->name = $this->data->member->member_name;
                $this->email = $this->data->member->member_email;
                $this->phone_number = $this->data->member->member_phone;
                $this->contract_price = $this->data->member->contract_price;
            }
        }
    }

    private $parent = [];

    public function setParent($data)
    {
        $left_turnover = (float) $data->left_turnover - (float) $data->invalid_left_turnover->sum('invalid_turnover_amount');
        $right_turnover = (float) $data->right_turnover - (float) $data->invalid_right_turnover->sum('invalid_turnover_amount');

        if(strlen($data->deleted_at) === 0 || $data->due_date){
            array_push($this->parent, [
                'id' => $data->member_id,
                'user' => $data->member_user,
                'parent' => $data->member_parent,
                'network' => $data->member_network,
                'contract' => $data->contract_price,
                'position' => $data->member_position,
                'founder' => $data->member_parent? 0: 1,
                'pair' => $left_turnover > 0 && $right_turnover > 0? 1: 0,
                'left' => $left_turnover,
                'right' => $right_turnover,
                'rating' => $data->rating? $data->rating->rating_order: null,
                "active" => $data->deleted_at? 0: 1,
                'due_date' => $data->due_date
            ]);
        }

        if($data->parent)
            $this->setParent($data->parent);
    }

    public function updated()
    {
        $this->reset('notification');
        $this->validate();
    }

    public function submit()
    {
        $this->validate();
        $error = null;

        if (Member::where('member_user', $this->new_username)->count() > 0){
            $error .= "<li>The username <strong>".$this->new_username."</strong> is already registered</li>";
        }

        if (Referral::where('referral_token', $this->token)->count() === 0) {
            $error .= '<li>Invalid referral code!!!</li>';
        }

        if ($error) {
            $this->reset(['new_password', 'agree']);
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $error
            ];
        }

        DB::transaction(function () {
            $member = Member::findOrFail($this->member_id);
            $member->member_user = $this->new_username;
            $member->member_password = Hash::make($this->new_password);
            $member->save();

            $wallet = new Wallet();
            $wallet->member_id = $this->member_id;
            $wallet->wallet_address = bitcoind()->getaccountaddress($this->new_username);
            $wallet->save();

            $this->data->delete();

            $information = "Member activation on behalf of ".$this->new_user_id;

            $id = Str::random(10)."-".date('Ymdhis').round(microtime(true) * 1000);

            $transaction = new Transaction();
            $transaction->transaction_id = $id;
            $transaction->transaction_information = $information." by ".$member->member_user;
            $transaction->save();

            $this->setParent(Member::with('parent')->with('rating')->with('invalid_left_turnover')->with('invalid_right_turnover')->select("member_id", "member_email", "member_user", "member_parent", "member_position", "rating_id", "contract_price", "member_network", "due_date", "deleted_at",
            DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ki")))=concat(member.member_id, "ki") ) left_turnover'),
            DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ka")))=concat(member.member_id, "ka") ) right_turnover'))->where('member_id', $this->member_id)->first());

            $data_rating = Rating::all();

            $bonus = [];
            $omset_keluar = [];
            $parent_length = 0;
            $network = $member->member_network;
            foreach (collect($this->parent)->filter(function($q) use($member){
                return $q['id'] != $member->member_id;
            }) as $key => $row) {
                $achievement_id = 0;
                if(is_null($row['due_date']) == 1 && $row['active'] == 1){
                    $kaki_kecil = collect([$row['left'], $row['right']])->min();
                    $child = Member::findOrFail($row['id']);

                    $rating = $data_rating->filter(function ($q) use ($kaki_kecil)
                    {
                        return $q->rating_omset_min <= $kaki_kecil;
                    })->sortBy('rating_omset_min')->first();

                    if ($rating && Achievement::where('member_id', $row['id'])->where('achievement_id', $child->rating_id)->count() == 0) {
                        $child->rating_id = $rating['rating_id'];

                        $pcp = new Achievement();
                        $pcp->member_id = $row['id'];
                        $pcp->rating_id = $rating->rating_id;
                        $pcp->save();
                    }else{
                        $child->rating_id = null;
                    }
                    $child->save();

                    if($row['pair'] === 1) {
                        $pairing = "Turnonver growth ".$this->new_user_id." 5% of ".number_format($member->contract_price, 2);
                        if(substr($network, -2) == 'ki'){
                            if($row['left'] - $member->contract_price < $row['right']){
                                $reward = 0;
                                if($row['left'] > $row['right']){
                                    $reward = $row['right'] - $row['left'] + $member->contract_price;
                                }else{
                                    $reward = $member->contract_price;
                                }
                                array_push($bonus,[
                                    'transaction_reward_information' => $pairing." left side registration",
                                    'transaction_reward_type' => "Turnover Growth",
                                    'transaction_reward_amount' => $reward * 5 /100,
                                    'transaction_id' => $id,
                                    'member_id' => $row['id'],
                                    'created_at' => Carbon::now(),
                                    'updated_at' => Carbon::now()
                                ]);
                            }
                        }else if(substr($network, -2) == 'ka'){
                            if($row['right'] - $member->contract_price < $row['left']){
                                $reward = 0;
                                if($row['right'] > $row['left']){
                                    $reward = $row['left'] - $row['right'] + $member->contract_price;
                                }else{
                                    $reward = $member->contract_price;
                                }
                                array_push($bonus,[
                                    'transaction_reward_information' => $pairing." right side registration",
                                    'transaction_reward_type' => "Turnover Growth",
                                    'transaction_reward_amount' => $reward * 5 /100,
                                    'transaction_id' => $id,
                                    'member_id' => $row['id'],
                                    'created_at' => Carbon::now(),
                                    'updated_at' => Carbon::now()
                                ]);
                            }
                        }
                    }
                }
                if ($row['due_date']) {
                    array_push($omset_keluar,[
                        'member_id' => $row['id'],
                        'invalid_turnover_from' => $member->member_id,
                        'invalid_turnover_amount' => $member->contract_price,
                        'invalid_turnover_position' => substr($network, -2) == "ka"? 1: 0
                    ]);
                }
                $parent_length = strlen($row['id'].($row['position'] == 0? 'ki': 'ka'));
                $network = substr($network, 0, (strlen($network) - $parent_length));
            }
            $keluar = collect($omset_keluar)->chunk(10);

            foreach ($keluar as $ins)
            {
                InvalidTurnover::insert($ins->toArray());
            }
            $insert = collect($bonus)->chunk(10);
            foreach ($insert as $ins)
            {
                TransactionReward::insert($ins->toArray());
            }
        });

        if (Auth::attempt(['member_email' => $this->email, 'password' => $this->new_password], false)) {
            Auth::logoutOtherDevices($this->new_password, 'member_password');
            return redirect('dashboard');
        }
        return $this->notification = [
            'tipe' => 'success',
            'pesan' => 'Your account activation is successful!!!'
        ];
    }

    public function render()
    {
        return view('livewire.authentication.activation')->extends('layouts.auth')->section('content');
    }
}
