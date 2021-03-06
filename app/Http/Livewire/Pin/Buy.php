<?php

namespace App\Http\Livewire\Pin;

use Carbon\Carbon;
use App\Models\Pin;
use App\Models\Rate;
use App\Models\Member;
use App\Models\Rating;
use Livewire\Component;
use App\Models\Transaction;
use Illuminate\Support\Str;
use App\Models\TransactionPin;
use App\Models\TransactionIncome;
use Illuminate\Support\Facades\DB;
use App\Models\TransactionRewardPin;
use Illuminate\Support\Facades\Hash;

class Buy extends Component
{
    public $amount = 0, $password, $back, $notification, $pin_price, $rate, $lbc_amount = 0;

    protected $rules = [
        'amount' => 'numeric',
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

    public function submit()
    {
        $this->validate();

        $error = null;
        $this->amount = (float)$this->amount;
        $this->reset('notification');

        try {
            $this->lbc_amount = ($this->amount?: 0) * $this->pin_price;

            if (Str::length(auth()->user()->app_key) == 0) {
                $error .= "<li>The app key is not yet available</li>";
            }

            if(Hash::check($this->password, auth()->user()->member_password) === false){
                $error .= "<li>Wrong <strong>password</strong></li>";
            }

            if($this->amount <= 0) {
                $error .= "<li>Amount of PIN to be purchased cannot be less than 1</li>";
            }

            if($this->lbc_amount > bitcoind()->getbalance(auth()->user()->username)[0]-1){
                $error .= "<li>Account has insufficient funds.</li>";
            }

            if($error) {
                $this->reset(['amount', 'password']);
                return $this->notification = [
                    'tipe' => 'danger',
                    'pesan' => $error
                ];
            }

            DB::transaction(function () {
                $information = "Buy ".$this->amount." PIN".($this->amount == 1? '': 's');

                $id = bitcoind()->getaccountaddress(auth()->user()->username).date('Ymdhis').round(microtime(true) * 1000);

                $transaksi = new Transaction();
                $transaksi->transaction_id = $id;
                $transaksi->transaction_information = $information." by ".auth()->user()->member_user;
                $transaksi->save();

                $pin = new TransactionPin();
                $pin->transaction_pin_information = $information;
                $pin->transaction_pin_amount = $this->amount;
                $pin->transaction_id = $id;
                $pin->member_id = auth()->id();
                $pin->save();

                $pembagian = [];
                $now = Carbon::now();

                $type = 'Pin';
                $income = new TransactionIncome();
                $income->transaction_income_information = $information." by ".auth()->user()->member_user;
                $income->transaction_income_type = $type;
                $income->transaction_income_amount = config("constant.pin_price_admin") * $this->amount;
                $income->transaction_id = $id;
                $income->save();

                if(strlen(trim(auth()->user()->member_parent)) == 0){
                    array_push($pembagian,[
                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                        'transaction_reward_pin_amount' => 7 * $this->amount,
                        'transaction_id' => $id,
                        'member_id' => auth()->id(),
                        'created_at' => $now,
                        'updated_at' => $now
                    ]);
                }else{
                    $this->setParent(Member::with('parent')->with('rating')->with('invalid_left_turnover')->with('invalid_right_turnover')->select("member_id", "member_parent", "member_email", "member_user", "member_position", "rating_id", "contract_price", "member_network", "due_date", "deleted_at",
                    DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ki")))=concat(member.member_id, "ki") ) left_turnover'),
                    DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ka")))=concat(member.member_id, "ka") ) right_turnover'))->where('member_id', auth()->id())->first());

                    $parent = collect($this->parent);
                    $founder = $parent->where('founder', 1);
                    $first = $parent->where('rating', 1);
                    $second = $parent->where('rating', 2);
                    $third = $parent->where('rating', 3);

                    if($first->count() > 0){
                        if($second->count() > 0) {
                            if($third->count() > 0){
                                array_push($pembagian,[
                                    'member_id' => $first->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 3.5 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                array_push($pembagian,[
                                    'member_id' => $second->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 1.75 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                array_push($pembagian,[
                                    'member_id' => $third->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 1.05 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                if($founder) {
                                    array_push($pembagian,[
                                        'member_id' => $founder->first()['id'],
                                        'transaction_id' => $id,
                                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                        'transaction_reward_pin_amount' => 0.7 * $this->amount,
                                        'created_at' => $now,
                                        'updated_at' => $now
                                    ]);
                                }
                            }else{
                                array_push($pembagian,[
                                    'member_id' => $first->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 3.5 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                array_push($pembagian,[
                                    'member_id' => $second->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 2.1 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                if($founder) {
                                    array_push($pembagian,[
                                        'member_id' => $founder->first()['id'],
                                        'transaction_id' => $id,
                                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                        'transaction_reward_pin_amount' => 1.4 * $this->amount,
                                        'created_at' => $now,
                                        'updated_at' => $now
                                    ]);
                                }
                            }
                        }else{
                            if($third->count() > 0){
                                array_push($pembagian,[
                                    'member_id' => $first->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 3.5 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                array_push($pembagian,[
                                    'member_id' => $third->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 2.1 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                if($founder) {
                                    array_push($pembagian,[
                                        'member_id' => $founder->first()['id'],
                                        'transaction_id' => $id,
                                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                        'transaction_reward_pin_amount' => 1.4 * $this->amount,
                                        'created_at' => $now,
                                        'updated_at' => $now
                                    ]);
                                }
                            }else{
                                array_push($pembagian,[
                                    'member_id' => $first->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 3.5 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                if($founder) {
                                    array_push($pembagian,[
                                        'member_id' => $founder->first()['id'],
                                        'transaction_id' => $id,
                                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                        'transaction_reward_pin_amount' => 3.5 * $this->amount,
                                        'created_at' => $now,
                                        'updated_at' => $now
                                    ]);
                                }
                            }
                        }
                    }else {
                        if($second->count() > 0){
                            if($third->count() > 0){
                                array_push($pembagian,[
                                    'member_id' => $second->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 4.2 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                array_push($pembagian,[
                                    'member_id' => $third->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 1.75 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                if($founder) {
                                    array_push($pembagian,[
                                        'member_id' => $founder->first()['id'],
                                        'transaction_id' => $id,
                                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                        'transaction_reward_pin_amount' => 1.05 * $this->amount,
                                        'created_at' => $now,
                                        'updated_at' => $now
                                    ]);
                                }
                            }else{
                                array_push($pembagian,[
                                    'member_id' => $second->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 4.2 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                if($founder) {
                                    array_push($pembagian,[
                                        'member_id' => $founder->first()['id'],
                                        'transaction_id' => $id,
                                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                        'transaction_reward_pin_amount' => 2.8 * $this->amount,
                                        'created_at' => $now,
                                        'updated_at' => $now
                                    ]);
                                }
                            }
                        }else{
                            if($third->count() > 0){
                                array_push($pembagian,[
                                    'member_id' => $third->first()['id'],
                                    'transaction_id' => $id,
                                    'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                    'transaction_reward_pin_amount' => 5.25 * $this->amount,
                                    'created_at' => $now,
                                    'updated_at' => $now
                                ]);
                                if($founder) {
                                    array_push($pembagian,[
                                        'member_id' => $founder->first()['id'],
                                        'transaction_id' => $id,
                                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                        'transaction_reward_pin_amount' => 1.75 * $this->amount,
                                        'created_at' => $now,
                                        'updated_at' => $now
                                    ]);
                                }
                            }else{
                                if($founder) {
                                    array_push($pembagian,[
                                        'member_id' => $founder->first()['id'],
                                        'transaction_id' => $id,
                                        'transaction_reward_pin_information' => $information." by ".auth()->user()->member_user,
                                        'transaction_reward_pin_amount' => 7 * $this->amount,
                                        'created_at' => $now,
                                        'updated_at' => $now
                                    ]);
                                }
                            }
                        }
                    }
                }

                $insert = collect($pembagian)->chunk(10);
                foreach ($insert as $ins)
                {
                    TransactionRewardPin::insert($ins->toArray());
                }

                bitcoind()->move(auth()->user()->username, "administrator", round($this->lbc_amount, 8), 1, $information);
            });

            $this->reset(['amount', 'password', 'lbc_amount']);
            return $this->notification = [
                'tipe' => 'success',
                'pesan' => 'PIN purchase was successful!!!'
            ];
		} catch(\Exception $e){
            return $this->notification = [
                'tipe' => 'danger',
                'pesan' => $e->getMessage()
            ];
        }
    }

    public function updated()
    {
        $this->rate = new Rate();
        $this->pin_price = config("constant.pin_price")/$this->rate->last_dollar;
        $this->reset('notification');
        $this->lbc_amount = ($this->amount?: 0) * $this->pin_price;
    }

    public function render()
    {
        return view('livewire.pin.buy')
            ->extends('livewire.main', [
                'breadcrumb' => ['Pin', 'Buy'],
                'title' => 'Buy Pin',
                'description' => 'Buy pin to register new member'
            ])
            ->section('subcontent');
    }
}
