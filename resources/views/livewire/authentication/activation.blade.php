<div>
    <div class="login-box">
        <div class="card card-outline card-primary">
            <div class="card-header text-center">
                <img src="/images/logoatasbawah.png" alt="logo.png" style="height: 150px"><br>
            </div>
            <div class="card-body">
                @include('includes.notification')
                <form wire:submit.prevent="submit">
                    @if ($data)
                    <p class="login-box-msg">Account activation</p>
                    <div class="form-group form-primary">
                        <input type="text" value="{{ $name }}" readonly class="form-control" placeholder="Name" autocomplete="off">
                        @error('name')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="form-group form-primary">
                        <input type="text" value="{{ $email }}" readonly class="form-control" placeholder="Email" autocomplete="off">
                        @error('email')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="form-group form-primary">
                        <input type="text" value="{{ $phone_number }}" readonly class="form-control" placeholder="Phone Number" autocomplete="off">
                        @error('phone_number')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="form-group form-primary">
                        <input type="text" value="{{ number_format($contract_price,2) }}" readonly class="form-control text-right" placeholder="Package" autocomplete="off">
                        @error('contract_price')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <hr>
                    <div class="form-group form-primary">
                        <input type="text" wire:model.defer="new_username" class="form-control" placeholder="New Username" autocomplete="off">
                        @error('new_username')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="form-group form-primary">
                        <div class="input-group" >
                            <input type="{{ $type }}" wire:model.defer="new_password" class="form-control" placeholder="New Password" autocomplete="off">
                            <div class="input-group-append">
                                <a href="javascript:void(0)" wire:click="showhide" class="input-group-text" id="basic-addon2"><i class="fa {{ $eye }}" aria-hidden="true"></i></a>
                            </div>
                        </div>
                        @error('new_password')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="row m-t-25 text-left">
                        <div class="col-md-12">
                            <div class="checkbox-fade fade-in-primary">
                                <label>
                                    <input type="checkbox" wire:model="agree">
                                    <span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span>
                                    <span class="text-inverse">I read and accept <a href="#">Terms &amp; Conditions.</a></span>
                                </label>
                            </div>
                            @error('agree')
                            <span class="text-danger">Check to accept The Terms & Conditions</span>
                            @enderror
                        </div>
                    </div>
                    <x-honey recaptcha/>
                    <div class="row m-t-30">
                        <div class="col-md-12">
                            <input type="submit" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center m-b-20" value="Activate Now">
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-md-12">
                            <p class="text-inverse text-left m-b-0">Thank you.</p>
                            <p class="text-inverse text-left">
                                <a href="/"><b class="f-w-600">Back to website</b></a>
                            </p>
                        </div>
                    </div>
                    @else
                    <div class="card-block text-center">
                        <h4 class="text-danger">Referral code not found</h4>
                        <hr>
                        <div class="row">
                            <div class="col-md-12">
                                <p class="text-inverse text-left m-b-0">Thank you.</p>
                                <p class="text-inverse text-left">
                                    <a href="/"><b class="f-w-600">Back to website</b></a>
                                </p>
                            </div>
                        </div>
                    </div>
                    @endif
                </form>
            </div>
        </div>
    </div>
</div>
