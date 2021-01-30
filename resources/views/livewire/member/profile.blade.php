<div>
    @push('css')
    <!-- Select 2 css -->
    <link rel="stylesheet" href="/bower_components/select2/dist/css/select2.min.css" />
    @endpush
    <!-- page body start -->
    <div class="page-body">
        <!-- Session Idle Timeout card start -->
        <div class="row">
            <div class="col-lg-7">
                <form wire:submit.prevent="submit">
                    <div class="card">
                        <div class="card-block">
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" class="form-control" wire:model="name" autocomplete="off">
                                @error('name')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="text" class="form-control" wire:model="email" autocomplete="off">
                                @error('email')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Country</label>
                                <select class="select2 country" wire:model="country">
                                    <option value="">-- Choose Country --</option>
                                    @foreach ($data_negara as $negara)
                                    <option value="{{ $negara->negara_id }}">{{ $negara->negara_nama }}</option>
                                    @endforeach
                                </select>
                                @error('country')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="text" class="form-control" wire:model="phone_number" autocomplete="off">
                                @error('phone_number')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <hr>
                            <div class="form-group">
                                <label>Package</label>
                                <input type="text" class="form-control text-right" wire:model="package" autocomplete="off" disabled>
                                @error('package')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Referral</label>
                                <input type="text" class="form-control" wire:model="referral" autocomplete="off" disabled>
                                @error('referral')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <input type="submit" value="Update" class="btn btn-success">
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-5">
                @include('includes.information')
            </div>
        </div>
        <!-- Session Idle Timeout card end -->
    </div>
    <!-- page body end -->
    @include('includes.notification')
    @include('includes.error-validation')
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

            $(".package").on("change", function(e) {
                window.livewire.emit('set:setpackage', $(this).select2('data')[0]['id']);
            });

            $(".referral").on("change", function(e) {
                window.livewire.emit('set:setreferral', $(this).select2('data')[0]['id']);
            });

            $(".country").on("change", function(e) {
                window.livewire.emit('set:setcountry', $(this).select2('data')[0]['id']);
            });
        }
    </script>
    @endpush
</div>
