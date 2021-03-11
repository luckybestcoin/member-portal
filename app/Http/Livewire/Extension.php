<?php

namespace App\Http\Livewire;

use Carbon\Carbon;
use App\Models\Rate;
use App\Models\Member;
use App\Models\Rating;
use Livewire\Component;
use App\Models\Exchange;
use App\Models\Achievement;
use App\Models\Transaction;
use Illuminate\Support\Str;
use App\Models\TransactionPin;
use App\Models\InvalidTurnover;
use App\Models\TransactionReward;
use Illuminate\Support\Facades\DB;
use App\Models\TransactionExchange;
use Illuminate\Support\Facades\Hash;

class Extension extends Component
{
    public $back, $notification, $contract, $rate = 0, $lbc_amount = 0, $password;

    protected $rules = [
        'password' => 'required'
    ];

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

    public function mount()
    {
        $this->rate = new Rate();
        $this->lbc_amount = auth()->user()->contract_price/$this->rate->last_dollar;
        $this->contract = auth()->user()->contract_price;
    }

    public function submit()
    {
        $this->validate();
        $this->lbc_amount = auth()->user()->contract_price/$this->rate->last_dollar;
        $pin = new TransactionPin();
        $error = null;
        try {
            if (Str::length(auth()->user()->app_key) == 0) {
                $error .= "<li>The app key is not yet available</li>";
            }

            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if ($pin->balance < auth()->user()->contract->contract_pin) {
                $error .= "<li>Not enough <strong>PIN".(auth()->user()->contract->contract_pin == 1?:"s")."</strong></li>";
            }

            if ($this->lbc_amount > bitcoind()->getbalance(auth()->user()->username)[0]){
                $error .= "<li>Account has insufficient funds.</li>";
            }

            $trx_exchange = new TransactionExchange();
            if ((auth()->user()->contract_price * 3) - $trx_exchange->total > auth()->user()->contract->contract_reward_exchange_min){
                $error .= "<li>You have the remaining conversion $ ".((auth()->user()->contract_price * 3) - $trx_exchange->total)."</li>";
            }

            if ($error) {
                $this->reset(['password']);
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }
            DB::transaction(function () use ($pin) {
                $information = "Extension on behalf of ".auth()->user()->member_user;
                $id = bitcoind()->getaccountaddress(auth()->user()->username).date('Ymdhis').round(microtime(true) * 1000);

                TransactionExchange::where('member_id', auth()->id())->delete();
                auth()->user()->update([
                    'extension' => auth()->user()->extension + 1,
                    'due_date' => null
                    ]);

                $exchange = new Exchange();
                $exchange->contract_id = auth()->user()->contract_id;
                $exchange->member_id = auth()->id();
                $exchange->save();

                $transaction = new Transaction();
                $transaction->transaction_id = $id;
                $transaction->transaction_information = $information;
                $transaction->save();

                $pin->transaction_pin_information = $information;
                $pin->transaction_pin_amount = -auth()->user()->contract->contract_pin;
                $pin->transaction_id = $id;
                $pin->member_id = auth()->id();
                $pin->save();

                TransactionExchange::where('member_id', auth()->id())->delete();

                $bagi_hasil = new TransactionReward();
                $bagi_hasil->transaction_reward_information = $information;
                $bagi_hasil->transaction_reward_type = "Referral";
                $bagi_hasil->transaction_reward_amount = auth()->user()->contract_price * 10 /100;
                $bagi_hasil->transaction_id = $id;
                $bagi_hasil->member_id = auth()->user()->member_parent;
                $bagi_hasil->save();

                $this->setParent(Member::with('parent')->with('rating')->with('invalid_left_turnover')->with('invalid_right_turnover')->select("member_id", "member_email", "member_user", "member_parent", "member_position", "rating_id", "contract_price", "member_network", "due_date", "deleted_at",
                DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ki")))=concat(member.member_id, "ki") ) left_turnover'),
                DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ka")))=concat(member.member_id, "ka") ) right_turnover'))->where('member_id', auth()->id())->first());

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
                            return $q->rating_min_turnover <= $kaki_kecil;
                        })->sortBy('rating_min_turnover')->first();

                        if ($rating && strlen($child->member_parent) > 1 && Achievement::where('member_id', $row['id'])->where('rating_id', $rating->rating_id)->get()->count() == 0) {
                            $child->rating_id = $rating->rating_id;

                            $pcp = new Achievement();
                            $pcp->member_id = $row['id'];
                            $pcp->rating_id = $rating->rating_id;
                            $pcp->save();
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
                                        'transaction_reward_information' => $pairing." left side by ".$this->new_username,
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
                                        'transaction_reward_information' => $pairing." right side by ".$this->new_username,
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
                bitcoind()->move(auth()->user()->username, "administrator", round($this->lbc_amount, 8), 1, $information);
                $this->reset(['password']);
            });
        } catch(\Exception $e){
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $e->getMessage()
            ];
        }
    }

    public function render()
    {
        return view('livewire.extension')
            ->extends('livewire.main', [
                'breadcrumb' => ['Extension'],
                'title' => 'Extension'
            ])
            ->section('subcontent');
    }
}
