<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Member extends Authenticatable
{
    use HasFactory, Notifiable, SoftDeletes;

    protected $table = 'member';
    protected $primaryKey = 'member_id';
    protected $remmberTokenName = 'remember_token';

    protected $fillable = [
        'member_password',
        'member_name',
        'member_user',
        'member_email',
        'member_phone',
        'contract_',
        'rating_id'
    ];

    protected $hidden = [
        'member_password',
        'remember_token',
    ];

    public function getAuthPassword()
    {
        return $this->member_password;
    }

    public function wallet()
    {
        return $this->hasOne('App\Models\Wallet', 'member_id');
    }

    public function contract()
    {
        return $this->belongsTo('App\Models\Contract', 'contract_id');
    }

    public function rating()
    {
        return $this->belongsTo('App\Models\Rating', 'rating_id');
    }

    public function left_child()
    {
        return $this->hasMany('App\Models\Member', 'member_parent', 'member_id')->with('contract')->with('rating')->with('invalid_left_turnover')->with('invalid_right_turnover')->where('member_position', 0)->whereNotNull('member_password')->select("member_id", "member_user", "member_email", "rating_id", "member_parent", "member_position", "contract_id", "contract_price", "member_network", "due_date", "deleted_at", "member_name",
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ki")))=concat(member.member_network, member.member_id, "ki") ) left_turnover'),
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ka")))=concat(member.member_network, member.member_id, "ka") ) right_turnover'))->orderBy('member_user');
    }

    public function right_child()
    {
        return $this->hasMany('App\Models\Member', 'member_parent', 'member_id')->with('contract')->with('rating')->with('invalid_left_turnover')->with('invalid_right_turnover')->where('member_position', 1)->whereNotNull('member_password')->select("member_id", "member_user", "member_email", "rating_id", "member_parent", "member_position", "contract_id", "contract_price", "member_network", "due_date", "deleted_at", "member_name",
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ki")))=concat(member.member_network, member.member_id, "ki") ) left_turnover'),
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ka")))=concat(member.member_network, member.member_id, "ka") ) right_turnover'))->orderBy('member_user');
    }

    public function parent()
    {
        return $this->hasOne('App\Models\Member', 'member_id', 'member_parent')->with('parent')->with('rating')->with('invalid_left_turnover')->with('invalid_right_turnover')->select("member_id", "member_email", "member_name", "rating_id", "member_parent", "member_position", "contract_price", "member_network", "due_date", "deleted_at",
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ki")))=concat(member.member_network, member.member_id, "ki") ) left_turnover'),
        DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ka")))=concat(member.member_network, member.member_id, "ka") ) right_turnover'))->withTrashed();
    }

    public function invalid_right_turnover()
    {
        return $this->hasMany('App\Models\InvalidTurnover', 'member_id')->where("invalid_turnover_position", 1);
    }

    public function invalid_left_turnover()
    {
        return $this->hasMany('App\Models\InvalidTurnover', 'member_id')->where("invalid_turnover_position", 0);
    }
}
