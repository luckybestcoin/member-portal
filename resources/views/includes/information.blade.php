@inject('saldo', 'App\Models\Saldo')
@inject('pin', 'App\Models\Pin')
@inject('anggota', 'App\Models\Anggota')

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
{{-- <div class="alert alert-warning bg-c-yellow text-white">
    <label>Left Side Turnover</label>
    <h3 class="text-nowrap"><li class="fa fa-dollar"></li> {{ number_format($left_turnover, 2) }}</h3>
    <hr>
    <label>Right Side Turnover</label>
    <h3 class="text-nowrap"><li class="fa fa-dollar"></li> {{ number_format($right_turnover,2) }}</h3>
</div> --}}
