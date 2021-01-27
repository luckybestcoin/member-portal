<div>
    @push('css')
    <!-- Select 2 css -->
    <link rel="stylesheet" href="/bower_components/select2/dist/css/select2.min.css" />
    @endpush
    <!-- page body start -->
    <div class="page-body">
        <!-- Session Idle Timeout card start -->
        <div class="row">
            <div class="col-xl-7">
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
                                <select class="select2 package" wire:model="package">
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
                                <label>Referral</label>
                                <select class="select2 referral" wire:model="referral">
                                    <option value="{{ auth()->id() }}" selected>{{ auth()->user()->anggota_uid."(".auth()->user()->anggota_nama.")" }}</option>
                                    @foreach ($data_anggota as $anggota)
                                    <option value="{{ $anggota->anggota_id }}">{{ $anggota->anggota_uid."(".$anggota->anggota_nama.")" }}</option>
                                    @endforeach
                                </select>
                                @error('referral')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Position</label>
                                <select class="form-control" wire:model="position">
                                    <option value="">-- Choose Position --</option>
                                    <option value="0">Left Side</option>
                                    <option value="1">Right Side</option>
                                </select>
                                @error('position')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            <input type="submit" value="Submit" class="btn btn-success">
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-xl-5">
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
