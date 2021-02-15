@inject('saldo', 'App\Models\Saldo')
@inject('pin', 'App\Models\Pin')
@inject('anggota', 'App\Models\Anggota')

@push('css')
<link rel="stylesheet" type="text/css" href="/assets/icon/icofont/css/icofont.css">
@endpush

@php
    $omset = auth()->user()->select(DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ki")))=concat(anggota.anggota_id, "ki") ) omset_kiri'), DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ka")))=concat(anggota.anggota_id, "ka") ) omset_kanan'))->where('anggota_id', auth()->id())->first();
@endphp

<div class="info-box mb-3 bg-dark">
    <span class="info-box-icon">
        <i class="icofont icofont-coins"></i>
    </span>
    <div class="info-box-content">
        <span class="info-box-text"><h5>Your LBC Balance</h5></span>
        <span class="info-box-number">
            {{ number_format(0, 2) }}
            <small>($ 0)</small>
        </span>
    </div>
</div>
<div class="info-box mb-3 bg-info">
    <span class="info-box-icon">
        <i class="icofont icofont-ticket"></i>
    </span>
    <div class="info-box-content">
        <span class="info-box-text"><h5>Your PIN</h5></span>
        <span class="info-box-number">
            {{ number_format($pin->terakhir) }}
        </span>
    </div>
</div>
<div class="info-box mb-3 bg-default">
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
