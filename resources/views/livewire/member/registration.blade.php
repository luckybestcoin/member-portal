<div>
    @push('css')
    <link rel="stylesheet" href="/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="/plugins/bootstrap-select/dist/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    @endpush
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                    <div wire:loading>
                        <h3 class="text-primary ml-2">Validation process. Please Wait...</h3>
                    </div>
                    <div wire:loading.remove>
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
                                        <select class="selectpicker form-control" wire:model.defer="country" data-size="10" data-live-search="true" data-style="btn-secondary" style="width: 100%;">
                                            <option value="">--Choose One--</option>
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
                                        <select class="selectpicker form-control" data-style="btn-primary" wire:model.defer="contract" style="width: 100%;">
                                            <option value="">--Choose One--</option>
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
                                        <select class="selectpicker form-control" data-size="10" data-live-search="true" data-style="btn-danger" wire:model.defer="referral" style="width: 100%;">
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
                                        <select class="selectpicker form-control" data-style="btn-warning" wire:model.defer="turnover">
                                            <option value="">--Choose One--</option>
                                            <option value="0">Left Side</option>
                                            <option value="1">Right Side</option>
                                        </select>
                                        @error('turnover')
                                        <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="card-footer clearfix">
                                    <input type="submit" value="Submit" class="btn btn-success">
                                </div>
                            </div>
                        </form>
                        @include('includes.error-validation')
                        @include('includes.notification')
                    </div>
                </div>
                <div class="col-md-4">
                    @include('includes.information')
                </div>
            </div>
        </div>
        <div wire:ignore.self wire:loading.remove class="modal fade" id="modal-save">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Confirmation</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-striped">
                            <tr>
                                <th style="width: 150px">Name</th>
                                <td style="width:10px"> : </td>
                                <td>{{ $name }}</td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td> : </td>
                                <td>{{ $email }}</td>
                            </tr>
                            <tr>
                                <th>Country</th>
                                <td> : </td>
                                <td>{{ $country_name }}</td>
                            </tr>
                            <tr>
                                <th>Phone Number</th>
                                <td> : </td>
                                <td>{{ $phone_number }}</td>
                            </tr>
                            <tr>
                                <th>Contract</th>
                                <td> : </td>
                                <td>{{ $contract_name." $ ".number_format($contract_price) }}</td>
                            </tr>
                            <tr>
                                <th>Referral</th>
                                <td> : </td>
                                <td>{{ $email }}</td>
                            </tr>
                            <tr>
                                <th>Turnover</th>
                                <td> : </td>
                                <td>{{ $turnover == 1? 'Right Side': 'Left Side' }}</td>
                            </tr>
                        </table>
                        <hr>
                        <h3 class="ml-2">You Need :</h3>
                        <table class="table">
                            <tr>
                                <th style="width: 10px">PIN</th>
                                <th style="width: 10px"> : </th>
                                <th>{{ $contract_pin }}</th>
                                <td></td>
                                <th style="width: 10px">LBC</th>
                                <th style="width: 10px"> : </td>
                                <th>{{ $lbc_amount }} Luck</th>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" wire:click.prevent="save()" class="btn btn-success">Accept & Go</button>
                    </div>
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

        Livewire.on('save', () => {
            $('#modal-save').modal('show');
        });

        Livewire.on('done', () => {
            $('#modal-save').modal('toggle');
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
