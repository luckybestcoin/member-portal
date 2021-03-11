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
                <div class="col-lg-4 col-6">
                    <!-- small box -->
                    <div class="small-box bg-navy">
                        <div class="inner">
                            <h3>$ {{ number_format((auth()->user()->contract_price * 3) - $trx_exchange) }}</h3>

                            <p>Max. Contract Benefit</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-maximize"></i>
                        </div>
                        <a href="#" class="small-box-footer">&nbsp;</a>
                    </div>
                </div>
                  <!-- ./col -->
                <div class="col-lg-4 col-6">
                  <!-- small box -->
                    <div class="small-box bg-purple">
                        <div class="inner">
                            <h3>$ {{ number_format($reward, 2) }}</h3>

                            <p>Reward</p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-gift"></i>
                        </div>
                        <a href="/exchange?type=reward" class="small-box-footer">Exchange <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-4 col-6">
                    <!-- small box -->
                    <div class="small-box bg-maroon">
                        <div class="inner">
                            <h3>$ {{ number_format($fee, 2) }}</h3>

                            <p>Pin Fee</p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-ticket-alt"></i>
                        </div>
                        <a href="/exchange?type=pinfee" class="small-box-footer">Exchange <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <div id="container" style="height: 400px"></div>
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
                <div class="col-md-4">
                    @include('includes.information')
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
