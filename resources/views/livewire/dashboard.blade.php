<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- ./col -->
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-body">
                            <p style="text-align: justify; text-indent: 50px;">Menyikapi himbauan pemerintah Republik Indonesia untuk menutup system network luckybestcomunity.com dan di blokirnya web luckybestcoin.com, maka manajemen LBC pada dasarnya telah berupaya memenuhi semua persyaratan perizinan namun demikian hingga saat ini masih dalam proses sehingga belum dapat memenuhi secara maksimal keinginan para member.</p>
                            <p style="text-align: justify; text-indent: 50px;">Dalam meeting management dan founder telah diperoleh solusi yang dharapkan dapat mempercepat memenuhi keinginan para member agar bisa Conversi/WD dan dapat bertransaksi dimarket, yaitu bekerjasama dengan pihak HEBA token yang teknologinya menggunakan TRC20 yang diketahui blockchainnya lebih cepat dan mudah untuk digunakan, adapun solusi yang diputuskan sebagai berikut:</p>
                            <ol>
                                <li>
                                    Management akan menyelesaikan kewajibannya dg memberikan pembayaran sisa kontrak sekaligus sampai Tuntas
                                </li>
                                <li>
                                    Penyelesaian Sisa kontrak 300% dari Seluruh akun yang akan di bayarkan sekaligus menggunakan produk crypto HEBA Token yang sudah listing disalah satu market indonesia.
                                </li>
                                <li>
                                    Mekanisme WD Conversi ke HEBA Token bisa dilakukan langsung melalui akun masingmasing member dengan perhitungan harga HEBA ($0,05) atau setara dg Rp.750,-
                                </li>
                                <li>
                                    HEBA dengan pair IDR akan listing di digiasset exchanger pada tgl 1 juli 2021 dan member bisa WD/Konversi dan transaksi trade pada tgl 5 juli 2021
                                </li>
                                <li>
                                    Diharapkan bagi seluruh member supaya segera regiatrasi akun di DigiAsset agar dapat melakukan WD/Konversi dan bisa bertransaksi langsung di market Exchanger Digi Asset
                                </li>
                                <li>
                                    Dengan menyelesaikan kewajiban kepada seluruh member maka management menutup selluruh oprasional terkait LBC.
                                </li>
                            </ol>
                            <p>
                                Demikian pengunuman ini dibuat untuk dimaklumi dan difahami terimakasih.
                            </p>
                            <p>
                                Management
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="row">
                        <div class="col-lg-6 col-6">
                            <!-- small box -->
                            <div class="small-box bg-primary">
                                <div class="inner">
                                    <h3>$ {{ number_format((auth()->user()->contract_price * 3) - $trx_exchange_reward, 2) }}</h3>

                                    <p>Remaining Contract</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-dollar-sign"></i>
                                </div>
                                <a href="#" class="small-box-footer">&nbsp;</a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-6 col-6">
                            <!-- small box -->
                            <div class="small-box bg-maroon">
                                <div class="inner">
                                    <h3>{{ number_format(ceil($heba)) }}</h3>
                                    <p>HEBA Earned</p>
                                </div>
                                <div class="icon">
                                    <i>
                                        <a href="https://heba.live" target="_blank"><img src="https://heba.live/assets/img/favicon.png" style="margin-top: -60px; height: 80px" alt=""></a>
                                    </i>
                                </div>
                                <a href="#" class="small-box-footer">&nbsp;</a>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            @php
                                $now = date('YmdHis');
                                $open = 20210705200000;
                            @endphp
                            @if ($done)
                            <div class="alert alert-success text-center">
                                <h5>You have converted the entire remaining contract to HEBA at {{ $this->done }}<br>
                                    <a href="javascript:;" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                                        Click Here to Logout
                                    </a>
                                    <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                                        @csrf
                                    </form>
                                </h5>
                            </div>
                            @else
                            @if ($now  < $open)
                            <div class="alert alert-warning text-center">
                                <h4><small>You can convert you remaining contract to HEBA on :</small> <br><br> July 5, 2021<br>13:00 UTC<br>
                                    (20:00 Western Indonesian Time)
                                    <br><br>
                                    <small>Don't Miss It!!!</small></h4>
                            </div>
                            @else
                            <form wire:submit.prevent="submit">
                                <div class="card">
                                    <div class="card-body">
                                        <h5>Convert All Your Remaining Contract to HEBA Tokens here :</h5>
                                        <hr>
                                        <div class="form-group">
                                            <label>Total HEBA</label>
                                            <input type="text" step="any" class="form-control" value="{{ number_format(ceil($heba)) }}" readonly autocomplete="off">
                                            @error('heba')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <label>Digi Asset UID</label>
                                            <input type="text" class="form-control" wire:model.defer="uid" autocomplete="off">
                                            @error('uid')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <label>Password</label>
                                            <input type="password" class="form-control" wire:model.defer="password" autocomplete="off">
                                            @error('password')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        @if ($error)
                                            <div class="alert alert-danger">
                                                {{ $error }}
                                            </div>
                                        @endif
                                    </div>
                                    <div class="card-footer">
                                        <button type="submit" class="btn btn-primary">Convert Now</button>
                                    </div>
                                </div>
                            </form>
                            @endif
                            @endif
                            <div class="text-center">
                                Powered By
                                <a href="https://heba.live" target="_blank" class="text-primary"><u>HEBA</u></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal"  tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">PENGUMUMAN DAN INFORMASI</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>[INFO LBC]</p>
                        <p>Hal : PENGUMUMAN LBC</p>
                        <p>25 Juni 2021</p>

                        <p>Terkait dengan info di web sebelumnya tentang listing di salah satu market Indonesia, Diinformasikan kembali kepada seluruh member bahwa sebelumnya estimasi conversi/WD akan di buka tgl 25-06-2021 , akan tetapi ada beberapa item terkait pemutakhiran blockchain yg belum selesai oleh team IT maka conversi/WD akan dibuka setelah dipastikan listing di market sudah tayang dan estimasi waktunya pada  tgl 01-07-2021</p>

                        <p>Mohon untuk tidak melakukan transaksi (deposit atau Withdraw) dimarket karna masih ada eror pada lalu lintas transaksi blockchain, sampai selesainya proses pemutakhiran</p>

                        <p>Seluruh System tetap normal kecuali menu conversi/WD</p>


                        <p>Demikian informasi yang kami sampaikan sebelumnya kami mohon maaf yang sebesar besarnya dan mohon  untuk di maklumi terimakasih🙏🙏</p>
                        <p>System tetap normal kecuali menu conversi/WD</p>
                        <p>Demikian informasi yang kami sampaikan mohon untuk di maklumi terimakasih</p>
                        <br>
                        <p>Hormat kami</p>
                        <p>MANAGEMENT LBC</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    @push('scripts')
    <!-- OPTIONAL SCRIPTS -->
    <script src="/plugins/chart.js/Chart.min.js"></script>
    <script src="/highchart/highstock.js"></script>
    <script src="/highchart/modules/data.js"></script>
    <script type="text/javascript">
        // $('#myModal').modal('show');
            $.get("/turnoverbalance", function (result){
                $("#left-turnover").text(result['left_turnover']);
                $("#right-turnover").text(result['right_turnover']);
            });
        Highcharts.getJSON('/rate', function (data) {

            Highcharts.stockChart('container', {
                chart: {
                    alignTicks: false
                },

                rangeSelector: {
                    selected: 1
                },

                title: {
                    text: 'LBC to Dollar'
                },

                series: [{
                    type: 'column',
                    name: 'LBC to Dollar',
                    data: data
                }]
            });
        });
    </script>
    @endpush
</div>
