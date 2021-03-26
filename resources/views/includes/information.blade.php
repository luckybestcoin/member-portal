@inject('pin', 'App\Models\TransactionPin')
@inject('member', 'App\Models\Member')
@push('css')
<link rel="stylesheet" type="text/css" href="/icon/icofont/css/icofont.css">
@endpush

<div class="info-box mb-3 bg-info">
    <span class="info-box-icon">
        <i class="icofont icofont-ticket"></i>
    </span>
    <div class="info-box-content">
        <span class="info-box-text"><h5>Your PIN</h5></span>
        <span class="info-box-number">
            {{ $pin->balance }}
        </span>
    </div>
</div>
@php
    $turnover = $member->select(
            DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ki")))=concat(member.member_network, member.member_id, "ki") ) left_turnover'),
            DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_network, member.member_id, "ka")))=concat(member.member_network, member.member_id, "ka") ) right_turnover'))->where('member_id', auth()->id())->first();
@endphp
<div class="info-box mb-3 bg-secondary">
    <div class="row m-2" style="width: 100%">
        <div class="col-lg-12">
            <label>Left Side Turnover</label>
            <h3 class="text-nowrap">{{ $turnover['left_turnover'] }}</h3>
            <hr>
            <label>Right Side Turnover</label>
            <h3 class="text-nowrap">{{ $turnover['right_turnover'] }}</h3>
        </div>
    </div>
</div>
