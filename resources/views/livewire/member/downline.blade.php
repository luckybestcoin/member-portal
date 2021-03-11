<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 text-center">
                    <input type="text" wire:model="user" class="form-control">
                    <br>
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
                                        <th colspan="2" class="text-nowrap">Turnover <small>Left | Right</small></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($data->left_child as $item)
                                    <tr>
                                        <td class="text-nowrap"><a href="/member?key={{ $item->member_id }}">{{ $item->member_user }}</a></td>
                                        <td class="text-nowrap">{{ $item->member_name }}</td>
                                        <td class="text-right text-nowrap">{!! number_format($item->contract_price, 2) !!}</td>
                                        <td class="text-right text-nowrap">{{ number_format($item->left_turnover - $item->invalid_left_turnover->sum('invalid_turnover_amount'), 2) }}</td>
                                        <td class="text-right text-nowrap">{{ number_format($item->right_turnover - $item->invalid_right_turnover->sum('invalid_turnover_amount'), 2) }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer clearfix">
                            <label class="float-right ">{{ number_format($data->left_turnover - $data->invalid_left_turnover->sum('invalid_turnover_amount'), 2) }}</label>
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
                                        <th colspan="2" class="text-nowrap">Turnover <small>Left | Right</small></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($data->right_child as $item)
                                    <tr>
                                        <td class="text-nowrap"><a href="/member?key={{ $item->member_id }}">{{ $item->member_user }}</a></td>
                                        <td class="text-nowrap">{{ $item->member_name }}</td>
                                        <td class="text-right text-nowrap">{!! number_format($item->contract_price, 2) !!}</td>
                                        <td class="text-right text-nowrap">{{ number_format($item->left_turnover - $item->invalid_left_turnover->sum('invalid_turnover_amount'), 2) }}</td>
                                        <td class="text-right text-nowrap">{{ number_format($item->right_turnover - $item->invalid_right_turnover->sum('invalid_turnover_amount'), 2) }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer clearfix">
                            <label class="float-right ">{{ number_format($data->right_turnover - $data->invalid_right_turnover->sum('invalid_turnover_amount'), 2) }}</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 text-center">
                    <a href="/member" class="btn btn-primary">Reset</a>
                </div>
            </div>
        </div>
    </section>
</div>
