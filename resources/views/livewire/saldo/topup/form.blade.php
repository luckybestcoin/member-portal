<div>
    <!-- page body start -->
    <div class="page-body">
        <div class="row">
            <div class="col-sm-12">
                <!-- Session Idle Timeout card start -->
                <form wire:submit.prevent="submit">
                    <div class="card">
                        <div class="card-block">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Top Up Amount</label>
                                        <input type="text" class="form-control currency text-right" wire:model.defer="amount" autocomplete="off">
                                        @error('amount')
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
                                    <div class="form-group">
                                        <label>Exchanger</label>
                                        <select class="form-control" wire:model="period">
                                            <option value="">Justweb</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Coin</label>
                                        <select class="form-control" wire:model="period">
                                            <option value="">USDT</option>
                                            <option value="This Month Only">LBIT</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="alert alert-primary background-primary" wire:ignore.self>

                                    </div>
                                </div>
                            </div>
                            <input type="submit" value="Submit" class="btn btn-success">
                        </div>
                    </div>
                </form>
                <!-- Session Idle Timeout card end -->
            </div>
        </div>
    </div>
    <!-- page body end -->
    @include('includes.error')
    @push('scripts')
    <script type="text/javascript" src="/assets/pages/j-pro/js/autoNumeric.js"></script>
    <!-- Custom js -->
    <script type="text/javascript" src="/assets/pages/j-pro/js/custom/currency-form.js"></script>

    @endpush
</div>
