@inject('pin', 'App\Models\TransactionPin')
@inject('member', 'App\Models\Member')
@inject('rate', 'App\Models\Rate')

@push('css')
<link rel="stylesheet" type="text/css" href="/icon/icofont/css/icofont.css">
@endpush

@php
    $omset = auth()->user()->select(DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ki")))=concat(member.member_id, "ki") ) omset_kiri'), DB::raw('(select ifnull(sum(contract_price * extension), 0) from member a where a.member_password is not null and left(a.member_network, length(concat(member.member_id, "ka")))=concat(member.member_id, "ka") ) omset_kanan'))->where('member_id', auth()->id())->first();
@endphp

<div class="info-box mb-3 bg-info">
    <span class="info-box-icon">
        <i class="icofont icofont-ticket"></i>
    </span>
    <div class="info-box-content">
        <span class="info-box-text"><h5>Your PIN</h5></span>
        <span class="info-box-number">
            {{ number_format($pin->balance) }}
        </span>
    </div>
</div>
<div class="info-box mb-3 bg-secondary">
    <div class="row m-2" style="width: 100%">
        <div class="col-lg-12">
            <label>Left Side Turnover</label>
            <h3 class="text-nowrap"><li class="fa fa-dollar"></li>$ {{ number_format($omset->omset_kiri, 2) }}</h3>
            <hr>
            <label>Right Side Turnover</label>
            <h3 class="text-nowrap"><li class="fa fa-dollar"></li>$ {{ number_format($omset->omset_kanan,2) }}</h3>
        </div>
    </div>
</div>
