<div>
    <!-- page body start -->
    <div class="page-body">
        <div class="row">
            <div class="col-sm-8">
                <!-- Session Idle Timeout card start -->
                <form wire:submit.prevent="submit">
                    <div class="card">
                        <div class="card-block">
                            <div class="form-group">
                                <label>Amount</label>
                                <input type="number" class="form-control" wire:model="amount" autocomplete="off">
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
            <div class="col-sm-4">
                @include('includes.information')
            </div>
        </div>
    </div>
    <!-- page body end -->
    @include('includes.notification')
</div>
