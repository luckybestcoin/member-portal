<div>
    <div class="login-box">
        <div class="card card-outline card-primary">
            <div class="card-header text-center">
                <img src="/images/logoatasbawah.png" alt="logo.png" style="height: 150px"><br>
            </div>
            <div class="card-body">
                @if ($member)
                @include('includes.notification')
                <form wire:submit.prevent="submit">
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
                    <div class="row m-t-30">
                        <div class="col-md-12">
                            <input type="submit" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center m-b-20" value="Submit">
                        </div>
                    </div>
                </form>
                @else
                <div class="card-block text-center">
                    <h4 class="text-danger">This page is not found</h4>
                </div>
                @endif
            </div>
        </div>
    </div>
</div>
