<div>
    <section class="content">
        <div class="container-fluid">
            <div class="card card-default">
                <div class="card-header">
                    <div class="card-title">
                        <a href="{{ route('pin.buy') }}" class="btn btn-xs btn-primary"><i class="fa fa-plus"></i> Buy PIN</a>
                    </div>
                    <div class="card-tools form-inline">
                        <div class="input-group input-group-sm">
                            <select class="form-control" wire:model="period">
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
                                <td class="align-middle">{{ $row->pin_keterangan }}</td>
                                <td class="align-middle text-nowrap text-right">{{ number_format($row->pin_debit) }}</td>
                                <td class="align-middle text-nowrap text-right">{{ number_format($row->pin_kredit) }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <!-- /.card-body -->
                <div class="card-footer clearfix text-center">
                    <label class="float-left">Total Data : {{ $data->total() }}</label>
                    <label class="text-success">You have {{ number_format($total) }} PIN{{ $total > 1? 'S': '' }}</label>
                    <div class="float-right pagination-sm">
                        {{ $data->links() }}
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
