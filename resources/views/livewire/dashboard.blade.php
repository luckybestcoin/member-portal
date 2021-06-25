<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                @if (auth()->user()->due_date)
                <div class="col-md-12">
                    <div class="alert alert-warning">
                        Your account is within the grace period until {{ auth()->user()->due_date }}, <a href="/extension">click here</a> to extend the contract.
                    </div>
                </div>
                @endif
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-navy">
                        <div class="inner">
                            <h3>$ {{ number_format((auth()->user()->contract_price * 3) - $trx_exchange_reward, 2) }}</h3>

                            <p>Max. Contract Benefit</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-maximize"></i>
                        </div>
                        <a href="#" class="small-box-footer">&nbsp;</a>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-purple">
                        <div class="inner">
                            <h3>$ {{ number_format($remaining, 2) }}</h3>

                            <p>Remaining Reward</p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-gift"></i>
                        </div>
                        <a href="/conversion?type=reward" class="small-box-footer">Convert <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <!-- ./col -->
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                      <div class="small-box bg-lime">
                          <div class="inner">
                              <h3>$ {{ number_format($daily, 2) }}</h3>

                              <p>Daily Reward</p>
                          </div>
                          <div class="icon">
                              <i class="fa fa-gift"></i>
                          </div>
                          <a href="/conversion?type=reward" class="small-box-footer">Convert <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                  <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-maroon">
                        <div class="inner">
                            <h3>$ {{ number_format($fee, 2) }}</h3>

                            <p>Pin Fee Reward</p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-ticket-alt"></i>
                        </div>
                        <a href="/conversion?type=pinfee" class="small-box-footer">Convert <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <div id="container" style="height: 400px"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="small-box bg-yellow">
                        <div class="inner">
                            <h3>$ {{ number_format($reward + $fee, 2) }}</h3>

                            <p>Total Reward</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-maximize"></i>
                        </div>
                        <a href="#" class="small-box-footer">&nbsp;</a>
                    </div>
                    <div class="info-box mb-3 bg-secondary">
                        <div class="row m-2" style="width: 100%">
                            <div class="col-lg-12">
                                <label>Left Side Turnover</label>
                                <h3 class="text-nowrap" id="left-turnover"></h3>
                                <hr>
                                <label>Right Side Turnover</label>
                                <h3 class="text-nowrap" id="right-turnover"></h3>
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
        $('#myModal').modal('show');
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
