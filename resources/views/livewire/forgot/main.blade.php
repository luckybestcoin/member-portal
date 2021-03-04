<div>
    <div class="login-box">
        <div class="card card-outline card-primary">
            <div class="card-header text-center">
                <img src="/images/logoatasbawah.png" alt="logo.png" style="height: 150px"><br>
            </div>
            <div class="card-body">
                @if ($success == true)
                @include('includes.notification')
                @else
                @include('includes.notification')
                <form wire:submit.prevent="submit">
                    <div class="form-group form-primary">
                        <input type="email" wire:model.defer="email" class="form-control" placeholder="Email" autocomplete="off">
                        @error('email')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div>
                    <div class="row m-t-30">
                        <div class="col-md-12">
                            <input type="submit" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center m-b-20" value="Send Link Recovery">
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
                </form>
                @endif
            </div>
        </div>
    </div>
</div>