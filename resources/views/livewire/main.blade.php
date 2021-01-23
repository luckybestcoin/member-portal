@extends('layouts.app')

@section('title', ' | '.$title)

@section('content')
    @include('includes.top-navigation')

    <div class="pcoded-main-container">
        <div class="pcoded-wrapper">
            @include('includes.sidebar')
        </div>

        <div class="pcoded-content">
            <div class="pcoded-inner-content">
                <div class="main-body">
                    <div class="page-wrapper">
                        <!-- Page-header start -->
                        <div class="page-header">
                            <div class="row align-items-end">
                                <div class="col-lg-8">
                                    <div class="page-header-title">
                                        <div class="d-inline">
                                            <h4>{{ $title }}</h4>
                                            <span>{{ $description }}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="page-header-breadcrumb">
                                        <ul class="breadcrumb-title">
                                            <li class="breadcrumb-item"  style="float: left;">
                                                <a href="/"> <i class="feather icon-home"></i> </a>
                                            </li>
                                            @foreach ($breadcrumb as $bdc)
                                            <li class="breadcrumb-item"  style="float: left;"><a href="#!">{{ $bdc }}</a>
                                            </li>
                                            @endforeach
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Page-header end -->
                        @yield('subcontent')
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

