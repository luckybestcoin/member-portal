<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                @if (auth()->user()->app_key)
                <div class="col-lg-4">
                    <!-- Profile Image -->
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <img class="profile-user-img img-fluid img-circle"
                                    src="/images/user.png"
                                    alt="User profile picture">
                            </div>

                            <h3 class="profile-username text-center">{{ auth()->user()->user_name }}</h3>

                            <p class="text-muted text-center">{{ auth()->user()->user_email }}</p>

                            <ul class="list-group list-group-unbordered mb-3 table-responsive">
                                <li class="list-group-item">
                                    <b>Username</b>&nbsp;<a class="float-right">{{ auth()->user()->username }}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>Address</b>&nbsp;<a class="float-right">{{ bitcoind()->getaccountaddress(auth()->user()->username) }}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>Balance</b>&nbsp;<a class="float-right">{{ bitcoind()->getbalance(auth()->user()->username)[0] }} LBC</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <div class="col-lg-8">
                    <div class="card card-primary">
                        <div class="card-body">
                            <h4>Recent Transactions</h4>
                            <div class="table-responsiv overflow-auto" style="height: 500px">
                                <table class="table">
                                    <tr>
                                        <th>Timestamp</th>
                                        <th>Address</th>
                                        <th>Type</th>
                                        <th>Amount</th>
                                        <th>Confs</th>
                                        <th>Comments</th>
                                        <th>Info</th>
                                    </tr>
                                    @foreach (collect(bitcoind()->listtransactions(auth()->user()->username, 1000)->result())->sortByDesc('time') as $item)
                                    @if ($item['category'] == 'move')
                                    <tr>
                                        <td>{{ date('Y-m-d h:m:s', $item['time']) }}</td>
                                        <td>{{ $item['otheraccount'] }}</td>
                                        <td>{{ $item['category'] }}</td>
                                        <td class="text-right">{{ number_format($item['amount'], 8) }}</td>
                                        <td>-</td>
                                        <td>{{ $item['comment'] }}</td>
                                        <td>-</td>
                                    </tr>
                                    @else
                                    <tr>
                                        <td>{{ date('Y-m-d h:m:s', $item['time']) }}</td>
                                        <td>{{ $item['address'] }}</td>
                                        <td>{{ $item['category'] }}</td>
                                        <td class="text-right">{{ number_format($item['amount'], 8) }}</td>
                                        <td>{{ $item['confirmations'] }}</td>
                                        <td>-</td>
                                        <td><a href="http://explorer.luckybestcoin.com:3001/tx/{{ $item['txid'] }}" target="_blank">Info</a></td>
                                    </tr>
                                    @endif
                                    @endforeach
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                @include('includes.error-validation')
                @include('includes.notification')
                <div wire:ignore.self class="modal fade" id="default-modal" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <form wire:submit.prevent="submit">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLongTitle">Send</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>To Address</label>
                                        <input type="text" class="form-control" wire:model.defer="to_address" autocomplete="off">
                                        @error('to_address')
                                        <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <div class="form-group">
                                        <label>LBC Amount</label>
                                        <input type="number" step="any" class="form-control" wire:model.defer="lbc_amount" autocomplete="off">
                                        @error('lbc_amount')
                                        <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <hr>
                                    <div class="form-group">
                                        <label>Password</label>
                                        <input type="password" class="form-control" wire:model.defer="password" autocomplete="off">
                                        @error('password')
                                        <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    <div class="alert alert-warning">When you click <strong>Accept & Go</strong>, the process cannot be undone!!!</div>
                                </div>
                                <div class="modal-footer justify-content-between">
                                    <button type="submit" class="btn btn-success">Accept & Go</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                @else
                <div class="col-md-12">
                    <form wire:submit.prevent="key">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Wallet Information</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label>Username</label>
                                    <input type="text" class="form-control" wire:model.defer="username" autocomplete="off">
                                    @error('username')
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
                                <div class="form-group">
                                    <label>App Key</label>
                                    <input type="text" class="form-control" wire:model.defer="app_key" autocomplete="off">
                                    @error('app_key')
                                    <span class="text-danger">{{ $message }}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="card-footer clearfix">
                                <input type="submit" value="Submit" class="btn btn-success">
                            </div>
                        </div>
                    </form>
                    @include('includes.notification')
                </div>
                @endif
            </div>
        </div>
    </section>
    @push('scripts')
        <script>
            Livewire.on('show', id => {
                $('#default-modal').modal('toggle');
            });
            Livewire.on('done', id => {
                $('#default-modal').modal('toggle');
            });
        </script>
    @endpush
</div>
