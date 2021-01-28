@inject('saldo', 'App\Models\Saldo')
@inject('pin', 'App\Models\Pin')
@inject('anggota', 'App\Models\Anggota')

<div class="card bg-c-green text-white">
    <div class="card-block">
        <div class="row align-items-center">
            <div class="col">
                <p class="m-b-5">Balance</p>
                <h4 class="m-b-0 text-nowrap">{{ number_format($saldo->terakhir, 2) }}</h4>
            </div>
            <div class="col col-auto text-right">
                <i class="fa fa-coins f-50 text-c-green"></i>
            </div>
        </div>
    </div>
</div>
<div class="card bg-c-pink text-white">
    <div class="card-block">
        <div class="row align-items-center">
            <div class="col">
                <p class="m-b-5">Balance</p>
                <h4 class="m-b-0 text-nowrap"><li class="fa fa-dollar"></li> {{ number_format($saldo->terakhir, 2) }}</h4>
            </div>
            <div class="col col-auto text-right">
                <i class="fa fa-dollar f-50 text-c-pink"></i>
            </div>
        </div>
    </div>
</div>
<div class="card bg-c-blue text-white">
    <div class="card-block">
        <div class="row align-items-center">
            <div class="col">
                <p class="m-b-5">Reg. Ticket</p>
                <h4 class="m-b-0">{{ number_format($pin->terakhir) }}</h4>
            </div>
            <div class="col col-auto text-right">
                <i class="fa fa-ticket f-50 text-c-blue"></i>
            </div>
        </div>
    </div>
</div>
@php
    $omset = auth()->user()->select(DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ki")))=concat(anggota.anggota_id, "ki") ) omset_kiri'), DB::raw('(select ifnull(sum(paket_harga * reinvest), 0) from anggota a where a.anggota_uid is not null and left(a.anggota_jaringan, length(concat(anggota.anggota_id, "ka")))=concat(anggota.anggota_id, "ka") ) omset_kanan'))->where('anggota_id', auth()->id())->first();
@endphp
<div class="alert alert-warning bg-c-yellow text-white">
    <label>Left Side Turnover</label>
    <h3 class="text-nowrap"><li class="fa fa-dollar"></li> {{ number_format($omset->omset_kiri, 2) }}</h3>
    <hr>
    <label>Right Side Turnover</label>
    <h3 class="text-nowrap"><li class="fa fa-dollar"></li> {{ number_format($omset->omset_kanan,2) }}</h3>
</div>
