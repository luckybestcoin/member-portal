<div>
    @push('css')
    <link rel="stylesheet" href="/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    @endpush
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    @include('includes.error-validation')
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
                                    <label>Name</label>
                                    <input type="text" class="form-control" wire:model="name" autocomplete="off">
                                    @error('name')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" class="form-control" wire:model="email" autocomplete="off">
                                    @error('email')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Country</label>
                                    <select class="select2 country" wire:model="country" style="width: 100%;">
                                        <option value=""></option>
                                        @foreach ($country_data as $country)
                                        <option value="{{ $country->country_id }}">{{ $country->country_name }}</option>
                                        @endforeach
                                    </select>
                                    @error('country')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group form-primary">
                                    <label>Phone Number</label>
                                    <div class="input-group">
                                        <div class="input-group-append">
                                            <div class="input-group-text">
                                                {{ $country_code }}
                                            </div>
                                        </div>
                                        <input type="text" class="form-control" wire:model="phone_number" autocomplete="off">
                                    </div>
                                    @error('phone_number')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <hr>
                                <div class="form-group">
                                    <label>Contract</label>
                                    <select class="select2 contract" wire:model="contract" style="width: 100%;">
                                        <option value=""></option>
                                        @foreach ($contract_data as $contract)
                                        <option value="{{ $contract->contract_id }}">{{ $contract->contract_name }} ($ {{ number_format($contract->contract_price, 2) }})</option>
                                        @endforeach
                                    </select>
                                    @error('contract')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Referral</label>
                                    <select class="select2 referral" wire:model="referral" style="width: 100%;">
                                        <option value="{{ auth()->id() }}" selected>{{ auth()->user()->member_uid." (".auth()->user()->member_name.")" }}</option>
                                        @foreach ($member_data as $member)
                                        <option value="{{ $member->member_id }}">{{ $member->member_user." (".$member->member_name.")" }}</option>
                                        @endforeach
                                    </select>
                                    @error('referral')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Turnover</label>
                                    <select class="form-control" wire:model="turnover">
                                        <option value=""></option>
                                        <option value="0">Left Side</option>
                                        <option value="1">Right Side</option>
                                    </select>
                                    @error('turnover')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <h4 class="text-success">You Need : {{ number_format($lbc_amount, 8) }} LBC</h4>
                            </div>
                            <div class="card-footer clearfix">
                                <input type="submit" value="Submit" class="btn btn-success">
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
    @push('scripts')
    <!-- Masking js -->
    <script type="text/javascript" src="/plugins/select2/js/select2.full.min.js"></script>
    <script>
        $(document).ready(function(){
            init();
        });

        Livewire.on('reinitialize', () => {
            init();
        });

        function init() {
            $(".select2").select2();

            $(".contract").on("change", function(e) {
                window.livewire.emit('set:setcontract', $(this).select2('data')[0]['id']);
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
