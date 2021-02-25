<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    @include('includes.notification')
                </div>
                <div class="col-md-8">
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
                <div class="col-md-4">
                    @include('includes.information')
                </div>
            </div>
        </div>
    </section>
</div>
