<div>
    @push('css')
    <link rel="stylesheet" href="/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="/plugins/bootstrap-select/dist/css/bootstrap-select.min.css">
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
                                    <input type="text" class="form-control" wire:model.defer="name" autocomplete="off">
                                    @error('name')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" class="form-control" wire:model.defer="email" autocomplete="off">
                                    @error('email')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Country</label>
                                    <select class="selectpicker form-control" wire:model.defer="country" data-size="10" data-live-search="true" title="Choose one of the following..." data-style="btn-secondary" style="width: 100%;">
                                        @foreach ($country_data as $country)
                                        <option value="{{ $country->country_id }}" data-code="{{ $country->country_code }}">{{ $country->country_name }}</option>
                                        @endforeach
                                    </select>
                                    @error('country')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Phone Number</label>
                                    <input type="text" class="form-control" wire:model.defer="phone_number" autocomplete="off">
                                    @error('phone_number')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <hr>
                                <div class="form-group">
                                    <label>Contract</label>
                                    <select class="selectpicker form-control" title="Choose one of the following..." data-style="btn-primary" wire:model.defer="contract" style="width: 100%;">
                                        @foreach ($contract_data as $contract)
                                        <option value="{{ $contract->contract_id }}" data-content="{{ $contract->contract_name }} <span class='badge badge-warning'>$ {{ number_format($contract->contract_price, 2) }}</span>"></option>
                                        @endforeach
                                    </select>
                                    @error('contract')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Referral</label>
                                    <select class="selectpicker form-control" title="Choose one of the following..." data-size="10" data-live-search="true" data-style="btn-danger" wire:model.defer="referral" style="width: 100%;">
                                        <option value="{{ auth()->id() }}" selected>{{ auth()->user()->member_uid." (".auth()->user()->member_name.")" }}</option>
                                        @foreach ($member_data as $member)
                                        <option value="{{ $member->member_id }}" data-content="{{ $member->member_user }} <span class='badge badge-warning'>{{ $member->member_name }}</span>"></option>
                                        @endforeach
                                    </select>
                                    @error('referral')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group">
                                    <label>Turnover</label>
                                    <select class="selectpicker form-control" title="Choose one of the following..." data-style="btn-warning" wire:model.defer="turnover">
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
                    @include('includes.error-validation')
                    @include('includes.notification')
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
    <script type="text/javascript" src="/plugins/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
    <script>
        $(document).ready(function(){
            init();
        });

        Livewire.on('reinitialize', () => {
            init();
        });

        function init() {
            $(".selectpicker").selectpicker('refresh');
            $(".country").on("change", function(e) {
                window.livewire.emit('set:setcountry', $(this).find('option:selected').data('code'));
            });
        }
    </script>
    @endpush
</div>
