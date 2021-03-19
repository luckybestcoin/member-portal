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
                        <a href="/exchange?type=reward" class="small-box-footer">Convert <i class="fas fa-arrow-circle-right"></i></a>
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
                          <a href="/exchange?type=reward" class="small-box-footer">Convert <i class="fas fa-arrow-circle-right"></i></a>
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
                        <a href="/exchange?type=pinfee" class="small-box-footer">Convert <i class="fas fa-arrow-circle-right"></i></a>
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
                    <div class="card">
                        <div class="card-body">
                            <h4 class="ml-2">Achievement</h4>
                            <hr>
                            <table class="w-100">
                                @foreach ($achievement as $item)
                                <tr>
                                    <td>
                                        {{ $item->rating->rating_name }}
                                    </td>
                                    <td class="text-right">
                                        @if ($item->process)
                                        {{ $item->process }} LBC
                                        @else
                                        Waiting
                                        @endif
                                    </td>
                                </tr>
                                @endforeach
                            </table>
                        </div>
                    </div>
                    <div class="small-box bg-yellow">
                        <div class="inner">
                            <h3>$ {{ number_format($reward, 2) }}</h3>

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
    </section>
    @push('scripts')
    <!-- OPTIONAL SCRIPTS -->
    <script src="/plugins/chart.js/Chart.min.js"></script>
    <script src="/highchart/highstock.js"></script>
    <script src="/highchart/modules/data.js"></script>
    <script type="text/javascript">
        setInterval(function() {
            $.get("/turnoverbalance", function (result){
                $("#left-turnover").text(result['left_turnover']);
                $("#right-turnover").text(result['right_turnover']);
            });
        }, 1000);
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
