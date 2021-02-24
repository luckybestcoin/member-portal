<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Form</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label>Amount</label>
                                <input type="number" class="form-control" wire:model="amount" autocomplete="off" step="any">
                            </div>
                            <h4 class="text-success">You Need : {{ number_format($lbc_amount, 8) }} LBC</h4>
                        </div>
                        <div class="card-footer clearfix">
                            <a href="javascript.void(0);" data-toggle="modal" data-target="#default-modal" class="btn btn-success"> Submit</a>
                        </div>
                    </div>
                    <div class="alert alert-info">
                        1 Pin = {{ number_format($pin_price, 8) }} LBC
                    </div>
                    @include('includes.notification')
                </div>
                <div class="col-md-4">
                    @include('includes.information')
                </div>
            </div>
        </div>
        <div wire:ignore.self class="modal fade" id="default-modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <form wire:submit.prevent="submit">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Confirmation</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Amount of PIN to be Purchased</label>
                                <input type="number" class="form-control" value="{{ $amount }}" autocomplete="off" disabled>
                                @error('amount')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Amount of LBC Will Be Taken</label>
                                <input type="number" class="form-control" value="{{ number_format($lbc_amount, 8) }}" autocomplete="off" disabled>
                            </div>
                            <hr>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" class="form-control" wire:model="password" autocomplete="off">
                                @error('password')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="alert alert-warning">When you click <strong>Accept & Go</strong>, the process cannot be undone!!!</div>
                            @include('includes.error-validation')
                            @include('includes.notification')
                        </div>
                        <div class="modal-footer justify-content-between">
                            <button type="submit" class="btn btn-primary">Accept & Go</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    @push('scripts')
        <script>
            Livewire.on('done', id => {
                $('#default-modal').modal('toggle');
            });
        </script>
    @endpush
</div>
