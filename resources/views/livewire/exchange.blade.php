<div>
    <section class="content">
        <div class="container-fluid">
            @include('includes.notification')
            <div class="row">
                <div class="col-lg-8">
                    <div class="card card-primary card-outline card-tabs">
                        <div class="card-header p-0 pt-1">
                            <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link {{ $type == 'pinfee'? '': 'active' }}" wire:click="form_reward" id="custom-tabs-one-reward-tab" data-toggle="pill" href="#custom-tabs-one-reward" role="tab" aria-controls="custom-tabs-one-reward" aria-selected="{{ $type == 'pinfee'? 'false': 'true' }}">Reward</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link {{ $type == 'pinfee'? 'active': '' }}" wire:click="form_pinfee" id="custom-tabs-one-pinfee-tab" data-toggle="pill" href="#custom-tabs-one-pinfee" role="tab" aria-controls="custom-tabs-one-pinfee" aria-selected="{{ $type == 'pinfee'? 'true': 'false' }}">Pin Fee</a>
                                </li>
                            </ul>
                        </div>
                        <div class="card-body">
                            <div class="tab-content" id="custom-tabs-one-tabContent">
                                <div class="tab-pane fade {{ $type == 'pinfee'? '': 'show active' }}" id="custom-tabs-one-reward" role="tabpanel" aria-labelledby="custom-tabs-one-reward-tab">
                                    <form wire:submit.prevent="reward">
                                        <div class="form-group">
                                            <label>Amount Reward</label>
                                            <div class="input-group">
                                                <input type="number" step="any" class="form-control" wire:model="amount" autocomplete="off">
                                                <div class="input-group-append">
                                                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
                                                    <div class="dropdown-menu">
                                                        <a class="dropdown-item" href="#" wire:click="set_percent(25)">25%</a>
                                                        <a class="dropdown-item" href="#" wire:click="set_percent(50)">50%</a>
                                                        <a class="dropdown-item" href="#" wire:click="set_percent(75)">75%</a>
                                                        <a class="dropdown-item" href="#" wire:click="set_percent(100)">100%</a>
                                                    </div>
                                                </div>
                                            </div>
                                            @error('amount')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <label>Password</label>
                                            <input type="password" class="form-control" wire:model="password" autocomplete="off">
                                            @error('password')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <h4 class="text-success">You Will Get : {{ number_format($lbc_amount, 8) }} LBC <small class="text-danger">(After Fee $ {{ auth()->user()->contract->contract_reward_exchange_fee }})</small></h4>
                                        <hr>
                                        <div class="alert alert-warning">When you click <strong>Accept & Go</strong>, the process cannot be undone!!!</div>
                                        <button type="submit" class="btn btn-primary">Accept & Go</button>
                                    </form>
                                </div>
                                <div class="tab-pane fade {{ $type == 'pinfee'? 'show active': '' }}" id="custom-tabs-one-pinfee" role="tabpanel" aria-labelledby="custom-tabs-one-pinfee-tab">
                                    <form wire:submit.prevent="pinfee">
                                        <div class="form-group">
                                            <label>Amount Pin Fee</label>
                                            <div class="input-group">
                                                <input type="number" step="any" class="form-control" wire:model="amount" autocomplete="off">
                                                <div class="input-group-append">
                                                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
                                                    <div class="dropdown-menu">
                                                        <a class="dropdown-item" href="#" wire:click="set_percent(25)">25%</a>
                                                        <a class="dropdown-item" href="#" wire:click="set_percent(50)">50%</a>
                                                        <a class="dropdown-item" href="#" wire:click="set_percent(75)">75%</a>
                                                        <a class="dropdown-item" href="#" wire:click="set_percent(100)">100%</a>
                                                    </div>
                                                </div>
                                            </div>
                                            @error('amount')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <label>Password</label>
                                            <input type="password" class="form-control" wire:model="password" autocomplete="off">
                                            @error('password')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <h4 class="text-success">You Will Get : {{ number_format($lbc_amount, 8) }} LBC <small class="text-danger">(After Fee $ {{ auth()->user()->contract->contract_reward_exchange_fee }})</small></h4>
                                        <hr>
                                        <div class="alert alert-warning">When you click <strong>Accept & Go</strong>, the process cannot be undone!!!</div>
                                        <button type="submit" class="btn btn-primary">Accept & Go</button>
                                    </form>
                                </div>
                          </div>
                        </div>
                    </div>
                    <div class="alert alert-info">
                        <ul>
                            <li>
                                1 LBC = $ {{ number_format($lbc_price, 2) }}
                            </li>
                            <hr>
                            <li>Reward Exchange TxFee $ {{ auth()->user()->contract->contract_reward_exchange_fee }}</li>
                            <li>Min. Reward Exchange $ {{ number_format(auth()->user()->contract->contract_reward_exchange_min, 2) }}</li>
                            <li>Max. Reward Exchange $ {{ number_format(auth()->user()->contract->contract_reward_exchange_max, 2) }}</li>
                            <hr>
                            <li>Pin Fee Exchange TxFee $ {{ auth()->user()->contract->contract_pin_reward_exchange_fee }}</li>
                            <li>Min. Pin Fee Exchange $ {{ number_format(auth()->user()->contract->contract_pin_reward_exchange_min, 2) }}</li>
                            <li>Max. Pin Fee Exchange $ {{ number_format(auth()->user()->contract->contract_pin_reward_exchange_max, 2) }}</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="small-box bg-success">
                        <div class="inner">
                            <h3>$ {{ number_format($reward, 2) }}</h3>

                            <p>Reward</p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-gift"></i>
                        </div>
                    </div>
                    <div class="small-box bg-primary">
                        <div class="inner">
                            <h3>$ {{ number_format($fee, 2) }}</h3>

                            <p>Pin Fee</p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-ticket-alt"></i>
                        </div>
                    </div>
                    <hr>
                    @include('includes.information')
                </div>
            </div>
        </div>
    </section>
</div>
