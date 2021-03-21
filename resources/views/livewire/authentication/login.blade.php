<div>
    <div class="login-box">
        <!-- /.login-logo -->
        <div class="card card-outline card-primary">
            <div class="card-header text-center">
                <img src="/images/logoatasbawah.png" alt="logo.png" style="height: 150px"><br>
            </div>
            <div class="card-body">
                <form wire:submit.prevent="login" class="mb-3">
                    <div class="form-group form-primary">
                        <div class="input-group">
                            <input type="text" wire:model.defer="username" class="form-control" placeholder="Username" autocomplete="off">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-envelope"></span>
                                </div>
                            </div>
                        </div>
                        @error('username')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="form-group form-primary">
                        <div class="input-group">
                            <input type="password" wire:model.defer="password" class="form-control" placeholder="Password" autocomplete="off">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        @error('password')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <x-honey recaptcha/>
                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <input type="checkbox" id="remember">
                                <label for="remember">
                                Remember Me
                                </label>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-4">
                            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                        </div>
                        <!-- /.col -->
                    </div>
                </form>
                @include('includes.notification')
                <p class="mb-1">
                    <a href="/forgot">I forgot my password</a>
                </p>
                <p class="mb-0">
                    Have a referral code? <a href="javascript.void(0);" data-toggle="modal" data-target="#default-Modal"> <b class="f-w-600">Click here </b></a>
                </p>
                <p class="mb-0">
                    <a href="https://docs.google.com/forms/d/e/1FAIpQLSe-60Lwgl8VtqDMl1qGHNLajKOrN5qf1MCL3Ub4aZM5yz07oQ/viewform" class="btn btn-xs w-100 btn-success" target="_blank">Contact Us</a>
                </p>
                <hr>
                <div class="text-center" style="font-size: 0.8rem">
                    <small><strong>Powered by PT. Digital Global Gemilang</strong></small>
                </div>
            </div>
        <!-- /.card-body -->
        </div>
        <!-- /.card -->
    </div>
    <div wire:ignore.self class="modal fade" id="default-Modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <form wire:submit.prevent="referral">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="form-group form-primary">
                            <input type="text" wire:model="referral_token" class="form-control" placeholder="Referral Code" autocomplete="off">
                            @error('referral_token')
                            <span class="text-danger">{{ $message }}</span>
                            @enderror
                        </div>
                        @include('includes.notification')
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
