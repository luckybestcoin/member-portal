<div>
    <section class="content">
        <div class="container-fluid">
            <div class="card card-default">
                <div class="card-header">
                    <h3 class="card-title">
                        <label class="text-danger p-t-10">Your total reward is <strong>$ {{ number_format($total, 2) }}</strong></label>
                    </h3>
                    <div class="card-tools form-inline">
                        <div class="input-group input-group-sm">
                            <select class="form-control input-group-sm" wire:model="category">
                                <option value="All">All Category</option>
                                <option value="Daily">Daily</option>
                                <option value="Referral">Referral</option>
                                <option value="Growth">Growth</option>
                            </select>
                        </div>&nbsp;
                        <div class="input-group input-group-sm">
                            <select class="form-control input-group-sm" wire:model="period">
                                <option value="">All Periode</option>
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
                            <th>Debit</th>
                            <th>Credit</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach ($data as $i => $row)
                            <tr>
                                <td class="align-middle" style="width: 5px">{{ ++$no }}</td>
                                <td class="align-middle">{{ $row->transaksi_id }}</td>
                                <td class="align-middle">{{ $row->created_at }}</td>
                                <td class="align-middle">{{ $row->bagi_hasil_keterangan }}</td>
                                <td class="align-middle">{{ $row->bagi_hasil_jenis }}</td>
                                <td class="align-middle text-nowrap text-right">{{ number_format($row->bagi_hasil_debit, 2) }}</td>
                                <td class="align-middle text-nowrap text-right">{{ number_format($row->bagi_hasil_kredit, 2) }}</td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
                <!-- /.card-body -->
                <div class="card-footer clearfix">
                    <label>Total Data : {{ $data->total() }}</label>
                    <div class="float-right pagination-sm">
                        {{ $data->links() }}
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
