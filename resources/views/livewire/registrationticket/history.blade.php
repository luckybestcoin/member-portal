<div>
    <!-- page body start -->
    <div class="page-body">
        <div class="row">
            <div class="col-sm-12">
                <!-- Session Idle Timeout card start -->
                <div class="card">
                    <div class="card-header">
                        <a href="{{ route('tiket.beli') }}" class="btn btn-primary">Top Up</a>
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
                                    <th>Debit</th>
                                    <th>Credit</th>
                                </tr>
                                </thead>
                                <tbody>
                                @foreach ($data as $i => $row)
                                    <tr>
                                        <td class="align-middle">{{ ++$no }}</td>
                                        <td class="align-middle">{{ $row->transaksi_id }}</td>
                                        <td class="align-middle">{{ $row->created_at }}</td>
                                        <td class="align-middle text-nowrap text-right">{{ number_format($row->pin_debit) }}</td>
                                        <td class="align-middle text-nowrap text-right">{{ number_format($row->pin_kredit) }}</td>
                                    </tr>
                                @endforeach
                                    <tr>
                                        <th>Total Registration Ticket</th>
                                        <th class="align-middle text-nowrap text-right">{{ number_format($total) }}</th>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- Session Idle Timeout card end -->
            </div>
        </div>
    </div>
    <!-- page body end -->
</div>
