<div>
    <!-- page body start -->
    <div class="page-body">
        <div class="row">
            <div class="col-lg-8">
                <!-- Session Idle Timeout card start -->
                <form wire:submit.prevent="submit">
                    <div class="card">
                        <div class="card-block">
                            <div class="form-group">
                                <label>Top Up Amount</label>
                                <input type="text" class="form-control currency text-right" wire:model="amount" autocomplete="off">
                                @error('amount')
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
                            <input type="submit" value="Submit" class="btn btn-success">
                        </div>
                    </div>
                </form>
                <!-- Session Idle Timeout card end -->
            </div>
            <div class="col-lg-4">
                @include('includes.information')
            </div>
        </div>
    </div>
    <!-- page body end -->
    @include('includes.notification')
    @push('scripts')
    <script type="text/javascript" src="/assets/pages/j-pro/js/autoNumeric.js"></script>
    <!-- Custom js -->
    <script type="text/javascript" src="/assets/pages/j-pro/js/custom/currency-form.js"></script>

    @endpush
</div>
