<div>
    @push('css')
    <!-- Select 2 css -->
    <link rel="stylesheet" href="/bower_components/select2/dist/css/select2.min.css" />
    @endpush
    <!-- page body start -->
    <div class="page-body">
        <div class="row">
            <div class="col-lg-7">
                <!-- Session Idle Timeout card start -->
                <form wire:submit.prevent="submit">
                    <div class="card">
                        <div class="card-block">
                            <div class="form-group">
                                <label>LBIT Amount</label>
                                <input type="number" class="form-control" wire:model="amount" autocomplete="off">
                                @error('amount')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Payment</label>
                                <select class="select2 payment" wire:model="payment">
                                    <option value="">-- Choose Payment --</option>
                                    @foreach ($data_kurs_pembayaran as $negara)
                                    <option value="{{ $negara->kurs_pembayaran_metode }}">{{ $negara->kurs_pembayaran_nama }}</option>
                                    @endforeach
                                </select>
                                @error('payment')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            @if ($amount_transfer > 0)
                            <h4 class="text-right"><small>Amount {{ $this->payment }}</small> : <strong>{{ number_format($amount_transfer, 2) }}</strong></h4>
                            <input type="submit" value="Pay Now" class="btn btn-success">
                            @endif
                            <br>
                            @include('includes.notification')
                        </div>
                    </div>
                </form>
                <!-- Session Idle Timeout card end -->
            </div>
            <div class="col-lg-5">
                @include('includes.information')
            </div>
        </div>
    </div>
    <!-- page body end -->
    @push('scripts')
    <!-- Masking js -->
    <script type="text/javascript" src="/bower_components/select2/dist/js/select2.full.min.js"></script>
    <script>
        $(document).ready(function(){
            init();
        });

        Livewire.on('reinitialize', () => {
            init();
        });

        function init() {
            $(".select2").select2();

            $(".payment").on("change", function(e) {
                window.livewire.emit('set:setpayment', $(this).select2('data')[0]['id']);
            });
        }
    </script>
    @endpush
</div>
