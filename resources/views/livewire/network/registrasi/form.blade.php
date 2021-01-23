<div>
    @push('css')
    <!-- Select 2 css -->
    <link rel="stylesheet" href="/bower_components/select2/dist/css/select2.min.css" />
    @endpush
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
                                        <label>Name</label>
                                        <input type="text" class="form-control" wire:model.defer="name" autocomplete="off">
                                        @error('name')
                                        <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="text" class="form-control" wire:model.defer="email" autocomplete="off">
                                        @error('email')
                                        <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <div class="form-group">
                                        <label>Country</label>
                                        <select class="select2 country" wire:model.defer="country">
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
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                            <span class="input-group-text" id="basic-addon1">{{ $country_code }}</span></div>
                                            <input type="text" class="form-control" wire:model.defer="phone_number">
                                        </div>
                                        @error('phone_number')
                                        <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="alert alert-primary background-primary" wire:ignore.self>
                                        <div class="form-group">
                                            <label>Package</label>
                                            <select class="select2 package" wire:model.defer="package">
                                                <option value="">-- Choose Package --</option>
                                                @foreach ($data_paket as $paket)
                                                <option value="{{ $paket->paket_id }}">{{ $paket->paket_nama }} ($ {{ number_format($paket->paket_harga, 2) }})</option>
                                                @endforeach
                                            </select>
                                            @error('package')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <label>Position</label>
                                            <select class="form-control" wire:model.defer="position">
                                                <option value="">-- Choose Position --</option>
                                                <option value="1">Kanan</option>
                                                <option value="0">Kiri</option>
                                            </select>
                                            @error('position')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
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
    <!-- Masking js -->
    <script type="text/javascript" src="/bower_components/select2/dist/js/select2.full.min.js"></script>
    <script>
        $(document).ready(function(){
            $(".select2").select2();

            $(".package").on("change", function(e) {
                window.livewire.emit('set:setpackage', $(this).select2('data')[0]['id']);
            });

            $(".country").on("change", function(e) {
                window.livewire.emit('set:setcountry', $(this).select2('data')[0]['id']);
            });
        });

        Livewire.on('reinitialize', () => {
            $(".select2").select2();

            $(".package").on("change", function(e) {
                window.livewire.emit('set:setpackage', $(this).select2('data')[0]['id']);
            });

            $(".country").on("change", function(e) {
                window.livewire.emit('set:setcountry', $(this).select2('data')[0]['id']);
            });
        });
    </script>
    @endpush
</div>
