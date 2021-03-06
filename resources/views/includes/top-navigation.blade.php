@inject('rate', 'App\Models\Rate')
@php
    $lbc_balance = bitcoind()->getbalance(auth()->user()->username)[0];
    $rate_dollar = $rate->last_dollar;
@endphp
        <nav class="main-header navbar navbar-expand text-sm navbar-dark navbar-lightblue">
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="/" class="nav-link">Home</a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="/contact" class="nav-link">Contact</a>
                </li>
            </ul>

            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a href="#" class="nav-link badge-pill badge badge-warning text-dark"><h6><strong id="lbc-balance"></strong></h6></a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link" data-toggle="dropdown" href="#">
                        <i class="far fa-user-circle"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                        <a href="{{ route('profile') }}" class="dropdown-item">
                            <i class="fas fa-user mr-2"></i> Profile
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="javascript:;" class="dropdown-item" onclick="event.preventDefault(); document.getElementById('logout-form').submit();"><i class="feather icon-log-out"></i><i class="fas fa-sign-out-alt mr-2"></i> {{ __('Log Out') }}</a>
                        <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                            @csrf
                        </form>
                    </div>
                </li>
            </ul>
        </nav>
@push('scripts')
<script>
    $(document).ready(function(){
        setInterval(function() {
            $.get("/balance", function (result){
                $("#lbc-balance").text(result);
            });
        }, 2000);
    });
</script>
@endpush
