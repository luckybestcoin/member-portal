<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-8">
                    @if(auth()->user()->due_date)
                    <h3 class="text-danger text-center">You must renew your contract</h3>
                    @else
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
                                    @if ($conversion)
                                    <div class="text-center text-danger">
                                        <h3>You cannot do this action more than once on the same day!!!</h3>
                                    </div>
                                    @else
                                    <form wire:submit.prevent="reward">
                                        <div class="form-group">
                                            <label>Amount Reward to Convert</label>
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
                                            <input type="password" class="form-control" wire:model.defer="password" autocomplete="off">
                                            @error('password')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <h4 class="text-success">You Will Get : {{ number_format($lbc_amount, 8) }} LBC <small class="text-danger">(After Fee $ {{ auth()->user()->contract->contract_reward_exchange_fee }})</small></h4>
                                        <hr>
                                        <div class="alert alert-warning">When you click <strong>Accept & Go</strong>, the process cannot be undone!!!</div>
                                        <button type="submit" class="btn btn-primary">Accept & Go</button>
                                    </form>
                                    @endif
                                </div>
                                <div class="tab-pane fade {{ $type == 'pinfee'? 'show active': '' }}" id="custom-tabs-one-pinfee" role="tabpanel" aria-labelledby="custom-tabs-one-pinfee-tab">
                                    @if ($conversion)
                                    <div class="text-center text-red">
                                        <h3>You cannot do this action more than once on the same day!!!</h3>
                                    </div>
                                    @else
                                    <form wire:submit.prevent="pinfee">
                                        <div class="form-group">
                                            <label>Amount Pin Fee to Convert</label>
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
                                            <input type="password" class="form-control" wire:model.defer="password" autocomplete="off">
                                            @error('password')
                                            <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                        </div>
                                        <h4 class="text-success">You Will Get : {{ number_format($lbc_amount, 8) }} LBC <small class="text-danger">(After Fee $ {{ auth()->user()->contract->contract_reward_exchange_fee }})</small></h4>
                                        <hr>
                                        <div class="alert alert-warning">When you click <strong>Accept & Go</strong>, the process cannot be undone!!!</div>
                                        <button type="submit" class="btn btn-primary">Accept & Go</button>
                                    </form>
                                    @endif
                                </div>
                          </div>
                        </div>
                    </div>
                    @include('includes.error-validation')
                    @include('includes.notification')
                    <div class="alert alert-info">
                        <ul>
                            <li>
                                1 LBC = $ {{ number_format($lbc_price, 2) }}
                            </li>
                            <hr>
                            <li>Reward Conversion TxFee $ {{ auth()->user()->contract->contract_reward_exchange_fee }}</li>
                            <li>Min. Reward Conversion $ {{ number_format(auth()->user()->contract->contract_reward_exchange_min, 2) }}</li>
                            <li>Max. Reward Conversion $ {{ number_format(auth()->user()->contract->contract_reward_exchange_max, 2) }}</li>
                            <hr>
                            <li>Pin Fee Conversion TxFee $ {{ auth()->user()->contract->contract_pin_reward_exchange_fee }}</li>
                            <li>Min. Pin Fee Conversion $ {{ number_format(auth()->user()->contract->contract_pin_reward_exchange_min, 2) }}</li>
                            <li>Max. Pin Fee Conversion $ {{ number_format(auth()->user()->contract->contract_pin_reward_exchange_max, 2) }}</li>
                        </ul>
                    </div>
                    @endif
                </div>
                <div class="col-lg-4">
                    <div class="small-box bg-purple">
                        <div class="inner">
                            <h3>$ {{ number_format($trx_reward->where('member_id', auth()->id())->where('transaction_reward_amount', '>', 0)->get()->sum('transaction_reward_amount') - $trx_exchange->total_reward, 2) }}</h3>
                            <p>Remaining Reward</p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-gift"></i>
                        </div>
                    </div>
                    <div class="small-box bg-maroon">
                        <div class="inner">
                            <h3>$ {{ number_format($fee, 2) }}</h3>

                            <p>Pin Fee Reward</p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-ticket-alt"></i>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <h4 class="ml-2">History</h4>
                            <hr>
                            <table class="w-100">
                                @foreach ($history as $item)
                                <tr>
                                    <td>
                                        {{ $item->created_at }}
                                    </td>
                                    <td class="text-right">
                                        {{ number_format($item->transaction_exchange_amount, 8) }} LBC
                                    </td>
                                </tr>
                                @endforeach
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
