<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 text-center">
                    <label>{{ $data->member_name }}</label>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Left Side</h3>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table class="table table-striped table-valign-middle">
                                <thead>
                                    <tr>
                                        <th>UID</th>
                                        <th>Name</th>
                                        <th>Package</th>
                                        <th colspan="2">Turnover <small>Left | Right</small></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($data->right_child as $item)
                                    <tr>
                                        <td class="text-unwrap">{{ $item->member_email }}</td>
                                        <td class="text-unwrap">{{ $item->member_name }}</td>
                                        <td class="text-right text-unwrap">$ {{ $item->paket->paket_name." ".number_format($row->paket_harga, 2) }}</td>
                                        <td class="text-right text-unwrap">$ {{ number_format($row->left_turnover - $row->invalid_left_turnover->sum('invalid_turnover_amount'), 2) }}</td>
                                        <td class="text-right text-unwrap">$ {{ number_format($row->right_turnover - $row->invalid_right_turnover->sum('invalid_turnover_amount'), 2) }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer clearfix">
                            <label class="float-right ">$ {{ number_format($data->left_turnover - $data->invalid_left_turnover->sum('invalid_turnover_amount'), 2) }}</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Right Side</h3>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table class="table table-striped table-valign-middle">
                                <thead>
                                    <tr>
                                        <th>UID</th>
                                        <th>Name</th>
                                        <th>Package</th>
                                        <th colspan="2">Turnover <small>Left | Right</small></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($data->right_child as $item)
                                    <tr>
                                        <td class="text-unwrap">{{ $item->member_email }}</td>
                                        <td class="text-unwrap">{{ $item->member_name }}</td>
                                        <td class="text-right text-unwrap">$ {{ $item->paket->paket_name." ".number_format($row->paket_harga, 2) }}</td>
                                        <td class="text-right text-unwrap">$ {{ number_format($row->left_turnover - $row->invalid_left_turnover->sum('invalid_turnover_amount'), 2) }}</td>
                                        <td class="text-right text-unwrap">$ {{ number_format($row->right_turnover - $row->invalid_right_turnover->sum('invalid_turnover_amount'), 2) }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer clearfix">
                            <label class="float-right ">$ {{ number_format($data->right_turnover - $data->invalid_right_turnover->sum('invalid_turnover_amount'), 2) }}</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
