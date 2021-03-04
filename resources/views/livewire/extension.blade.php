<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Form</h3>
                        </div>
                        <form wire:submit.prevent="submit">
                            <div class="card-body">
                                <div class="form-group">
                                    <label>Contract Price</label>
                                    <input type="number" disabled class="form-control" wire:model="contract" autocomplete="off" step="any">
                                    @error('contract')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" class="form-control" wire:model.defer="password" autocomplete="off">
                                    @error('password')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <h4 class="text-success">You Need : {{ number_format($lbc_amount, 8) }} LBC</h4>
                                <div class="alert alert-warning">When you click <strong>Accept & Go</strong>, the process cannot be undone!!!</div>
                            </div>
                            <div class="card-footer clearfix">
                                <button type="submit" class="btn btn-success">Accept & Go</button>
                            </div>
                        </form>
                    </div>
                    @include('includes.error-validation')
                    @include('includes.notification')
                </div>
                <div class="col-md-4">
                    @include('includes.information')
                </div>
            </div>
        </div>
    </section>
</div>
