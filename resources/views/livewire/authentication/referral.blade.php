<div>
    <section class="login-block">
        <!-- Container-fluid starts -->
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <!-- Authentication card start -->
                    <form wire:submit.prevent="submit">
                        <div class="text-center">
                            <img src="/assets/images/logo.png" alt="logo.png">
                        </div>
                        <div class="auth-box card">
                            @if ($data)
                            <div class="card-block">
                                <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-center txt-primary">Sign up</h3>
                                    </div>
                                </div>
                                <div class="form-group form-primary">
                                    <input type="text" wire:model.defer="name" readonly class="form-control" placeholder="Name" autocomplete="off">
                                    @error('name')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group form-primary">
                                    <input type="text" wire:model.defer="email" readonly class="form-control" placeholder="Email" autocomplete="off">
                                    @error('email')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group form-primary">
                                    <input type="text" wire:model.defer="phone_number" readonly class="form-control" placeholder="Phone Number" autocomplete="off">
                                    @error('phone_number')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group form-primary">
                                    <input type="text" wire:model.defer="package" readonly class="form-control" placeholder="Package" autocomplete="off">
                                    @error('package')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <hr>
                                <div class="form-group form-primary">
                                    <input type="text" wire:model="new_user_id" class="form-control" placeholder="New User ID" autocomplete="off">
                                    @error('new_user_id')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group form-primary">
                                    <input type="password" wire:model="new_password" class="form-control" placeholder="New Password" autocomplete="off">
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
                                        </div><br>
                                        @error('agree')
                                        <span class="text-danger">Check to accept The Terms & Conditions</span>
                                        @enderror
                                    </div>
                                </div>
                                <div class="row m-t-30">
                                    <div class="col-md-12">
                                        <input type="submit" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center m-b-20" value="Sign Up Now">
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-md-10">
                                        <p class="text-inverse text-left m-b-0">Thank you.</p>
                                        <p class="text-inverse text-left">
                                            <a href="/"><b class="f-w-600">Back to website</b></a>
                                        </p>
                                    </div>
                                    <div class="col-md-2">
                                        <img src="/assets/images/auth/Logo-small-bottom.png"
                                            alt="small-logo.png">
                                    </div>
                                </div>
                                @include('includes.notification')
                            </div>
                            @else
                            <div class="card-block text-center">
                                <h4 class="text-danger">Referral code not found</h4>
                                <hr>
                                <div class="row">
                                    <div class="col-md-10">
                                        <p class="text-inverse text-left m-b-0">Thank you.</p>
                                        <p class="text-inverse text-left">
                                            <a href="/"><b class="f-w-600">Back to website</b></a>
                                        </p>
                                    </div>
                                    <div class="col-md-2">
                                        <img src="/assets/images/auth/Logo-small-bottom.png"
                                            alt="small-logo.png">
                                    </div>
                                </div>
                            </div>
                            @endif
                        </div>
                    </form>
                    <!-- end of form -->
                </div>
                <!-- end of col-sm-12 -->
            </div>
            <!-- end of row -->
        </div>
        <!-- end of container-fluid -->
    </section>
</div>
