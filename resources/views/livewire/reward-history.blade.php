<div>
    <section class="content">
        <div class="container-fluid">
            <div class="card card-default">
                <div class="card-header">
                    <h3 class="card-title">
                        &nbsp;
                    </h3>
                    <div class="card-tools form-inline">
                        <div class="input-group input-group-sm">
                            <select class="form-control input-group-sm" wire:model="type">
                                <option value="All">All Reward</option>
                                <option value="Daily">Daily Reward</option>
                                <option value="Referral">Referral Reward</option>
                                <option value="Turnover Growth">Turnover Growth Reward</option>
                            </select>
                        </div>
                        <div class="input-group input-group-sm">
                            <select class="form-control input-group-sm" wire:model="period">
                                <option value="All">All Periode</option>
                                <option value="This Month Only">This Month Only</option>
                            </select>
                        </div>
                    </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body table-responsive p-1">
                    <table class="table table-hovered">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Transaction ID</th>
                            <th>Timestamp</th>
                            <th>Description</th>
                            <th>Type</th>
                            <th>Amount</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach ($data as $i => $row)
                            <tr>
                                <td class="align-middle" style="width: 5px">{{ ++$no }}</td>
                                <td class="align-middle">{{ $row->transaction_id }}</td>
                                <td class="align-middle">{{ $row->created_at }}</td>
                                <td class="align-middle">{{ $row->transaction_reward_information }}</td>
                                <td class="align-middle">{{ $row->transaction_reward_type }}</td>
                                <td class="align-middle text-nowrap text-right">{{ number_format($row->transaction_reward_amount, 2) }}</td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
                <!-- /.card-body -->
                <div class="card-footer clearfix">
                    <label class="text-success">Your total reward is <strong>$ {{ number_format($total, 2) }}</strong></label>
                    <div class="float-right pagination-sm">
                        {{ $data->links() }}
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
