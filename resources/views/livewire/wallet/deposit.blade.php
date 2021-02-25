<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    @include('includes.notification')
                </div>
                <div class="col-md-4">
                    <form wire:submit.prevent="submit">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Form</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label>LBC Amount</label>
                                    <input type="number" class="form-control" wire:model="amount" autocomplete="off">
                                    @error('amount')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Note</label>
                                    <input type="text" class="form-control" wire:model="note" autocomplete="off">
                                    @error('note')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" class="form-control" wire:model="password" autocomplete="off">
                                    @error('password')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <h4 class="text-success">Total Payment : $ {{ number_format($total_payment) }}</h4>
                            </div>
                            <div class="card-footer clearfix">
                                <input type="submit" value="Pay Now" class="btn btn-success">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-8">

                    <div class="card card-primary">
                        <div class="card-body">
                            <h4>Recent Transaction</h4>
                            <div class="table-responsiv overflow-auto" style="height: 500px">
                                <table class="table">
                                    <tr>
                                        <th>Timestamp</th>
                                        <th>UUID</th>
                                        <th>LBC Amount</th>
                                        <th>Tf Amount</th>
                                        <th>Status Url</th>
                                        <th>Checkout Url</th>
                                        <th>Status</th>
                                    </tr>
                                    @foreach ($transaction as $item)
                                    <tr>
                                        <td>{{ $item->created_at }}</td>
                                        <td>{{ $item->uuid }}</td>
                                        <td>{{ $item->items->first()->qty }}</td>
                                        <td>{{ $item->amountf." ".$item->coin }}</td>
                                        <td><a href="{{ $item->status_url }}" target="_blank">Status URL</a></td>
                                        <td><a href="{{ $item->checkout_url }}" target="_blank">Checkout</a></td>
                                        <td>{{ $item->status_text }}</td>
                                    </tr>
                                    @endforeach
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
