<div>
    <!-- page body start -->
    <div class="page-body">
        <div class="row">
            <div class="col-sm-12">
                <!-- Session Idle Timeout card start -->
                <div class="card">
                    <div class="card-header">
                        <label class="text-danger">Your remaining daily benefits is <span class="badge badge-default">$ {{ number_format($total, 2) }}</span></label>
                        <div class="float-right form-inline">
                            <select class="form-control" wire:model="period">
                                <option value="">All Periode</option>
                                <option value="This Month Only">This Month Only</option>
                            </select>
                        </div>
                    </div>
                    <div class="card-block">
                        <div class="table-responsive">
                            <table class="table table-framed">
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
                                        <td class="align-middle">{{ $row->bagi_hasil_keterangan }}</td>
                                        <td class="align-middle text-nowrap text-right">{{ number_format($row->bagi_hasil_debit, 2) }}</td>
                                        <td class="align-middle text-nowrap text-right">{{ number_format($row->bagi_hasil_kredit, 2) }}</td>
                                    </tr>
                                @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-10 col-xl-10 col-xs-12">
                                {{ $data->links() }}
                            </div>
                            <div class="col-md-6 col-lg-2 col-xl-2 col-xs-12">
                                <label class="pull-right">Total Data : {{ $data->total() }}</label>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Session Idle Timeout card end -->
            </div>
        </div>
    </div>
    <!-- page body end -->
</div>
