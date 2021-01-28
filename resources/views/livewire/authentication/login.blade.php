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
                            <div class="card-block">
                                <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-center">{{ config('app.name') }}</h3>
                                    </div>
                                </div>
                                <div class="form-group form-primary">
                                    <input type="text" wire:model.defer="username" class="form-control" placeholder="Username" autocomplete="off">
                                    @error('username')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="form-group form-primary">
                                    <input type="password" wire:model.defer="password" class="form-control" placeholder="Password" autocomplete="off">
                                    @error('password')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                                <div class="row m-t-25 text-left">
                                    <div class="col-12">
                                        <div class="checkbox-fade fade-in-primary">
                                            <label>
                                                <input type="checkbox" wire:model.defer="remember">
                                                <span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span>
                                                <span class="text-inverse">Remember me</span>
                                            </label>
                                        </div>
                                        <div class="forgot-phone text-right f-right">
                                            <a href="auth-reset-password.html" class="text-right f-w-600"> Forgot
                                                Password?</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-t-30">
                                    <div class="col-md-12">
                                        <input type="submit" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center m-b-20" value="Sign In">
                                    </div>
                                </div>
                                <p class="text-inverse text-left">Have a referral code? <a href="javascript.void(0);" data-toggle="modal"
                                    data-target="#default-Modal"> <b class="f-w-600">Click here </b></a></p>
                                @include('includes.notification')
                            </div>
                        </div>
                    </form>
                    <!-- end of form -->
                </div>
                <!-- end of col-sm-12 -->
            </div>
            <!-- end of row -->
        </div>
        <!-- end of container-fluid -->
        <div wire:ignore.self class="modal fade" id="default-Modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <form wire:submit.prevent="referral">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close"
                                data-dismiss="modal"
                                aria-label="Close">
                                <span
                                    aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group form-primary">
                                <input type="text" wire:model="referral_code" class="form-control" placeholder="Referral Code" autocomplete="off">
                                @error('referral_code')
                                <span class="text-danger">{{ $message }}</span>
                                @enderror
                            </div>
                            @include('includes.notification')
                        </div>
                        <div class="modal-footer">
                            <input type="submit" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center m-b-20" value="Submit">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>
