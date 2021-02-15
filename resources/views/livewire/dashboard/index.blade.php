<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-3 col-6">
                  <!-- small box -->
                  <div class="small-box bg-primary">
                    <div class="inner">
                      <h3>$ {{ number_format(auth()->user()->paket_harga) }}</h3>

                      <p>Stacking</p>
                    </div>
                    <div class="icon">
                      <i class="ion ion-bag"></i>
                    </div>
                    <a href="#" class="small-box-footer">&nbsp;</a>
                  </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-danger">
                      <div class="inner">
                        <h3>$ {{ number_format(auth()->user()->paket_harga * 3) }}</h3>

                        <p>Max. Stacking Reward</p>
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
                  <div class="small-box bg-success">
                    <div class="inner">
                      <h3>$ 0</h3>

                      <p>Stacking Reward</p>
                    </div>
                    <div class="icon">
                      <i class="ion ion-trophy"></i>
                    </div>
                    <a href="#" class="small-box-footer">Exchange <i class="fas fa-arrow-circle-right"></i></a>
                  </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                  <!-- small box -->
                  <div class="small-box bg-warning">
                    <div class="inner">
                      <h3>$ 0</h3>

                      <p>Pin Fee</p>
                    </div>
                    <div class="icon">
                      <i class="fa fa-ticket-alt"></i>
                    </div>
                    <a href="#" class="small-box-footer">Exchange <i class="fas fa-arrow-circle-right"></i></a>
                  </div>
                </div>

                <div class="col-lg-8">
                    <div class="card">
                    <div class="card-header border-0">
                        <div class="d-flex justify-content-between">
                        <h3 class="card-title">Online Store Visitors</h3>
                        <a href="javascript:void(0);">View Report</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="d-flex">
                        <p class="d-flex flex-column">
                            <span class="text-bold text-lg">820</span>
                            <span>Visitors Over Time</span>
                        </p>
                        <p class="ml-auto d-flex flex-column text-right">
                            <span class="text-success">
                            <i class="fas fa-arrow-up"></i> 12.5%
                            </span>
                            <span class="text-muted">Since last week</span>
                        </p>
                        </div>
                        <!-- /.d-flex -->

                        <div class="position-relative mb-4">
                        <canvas id="visitors-chart" height="200"></canvas>
                        </div>

                        <div class="d-flex flex-row justify-content-end">
                        <span class="mr-2">
                            <i class="fas fa-square text-primary"></i> This Week
                        </span>

                        <span>
                            <i class="fas fa-square text-gray"></i> Last Week
                        </span>
                        </div>
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
<script src="/assets/admin-lte/plugins/chart.js/Chart.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/assets/admin-lte/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="/assets/admin-lte/dist/js/pages/dashboard3.js"></script>
    @endpush
</div>
