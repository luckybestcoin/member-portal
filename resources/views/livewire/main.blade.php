@inject('payment_method', 'App\Models\PaymentMethod')
@extends('layouts.app')

@section('title', ' | '.$title)

@push('css')
<style>
    .marquee {
        height: 25px;
        overflow: hidden;left: 0;
        position: fixed;
        right: 0;
        top: 100;
        z-index: 2;
    }
    .marquee label {
        position: absolute;
        width: 100%;
        height: 100%;
        margin: 0;
        text-align: center;
        /* Starting position */
        -moz-transform:translateX(100%);
        -webkit-transform:translateX(100%);
        transform:translateX(100%);
        /* Apply animation to this element */
        -moz-animation: marquee 35s linear infinite;
        -webkit-animation: marquee 35s linear infinite;
        animation: marquee 35s linear infinite;
    }
    /* Move it (define the animation) */
    @-moz-keyframes marquee {
        0%   { -moz-transform: translateX(100%); }
        100% { -moz-transform: translateX(-100%); }
    }
    @-webkit-keyframes marquee {
        0%   { -webkit-transform: translateX(100%); }
        100% { -webkit-transform: translateX(-100%); }
    }
    @keyframes marquee {
        0%   {
            -moz-transform: translateX(100%); /* Firefox bug fix */
            -webkit-transform: translateX(100%); /* Firefox bug fix */
            transform: translateX(100%);
            }
            100% {
            -moz-transform: translateX(-100%); /* Firefox bug fix */
            -webkit-transform: translateX(-100%); /* Firefox bug fix */
            transform: translateX(-100%);
        }
    }
</style>
@endpush

@section('content')
@include('includes.top-navigation')
@include('includes.sidebar')
<div class="content-wrapper">
    <div class="marquee bg-dark">
        @php
            $color = \Str::random(6)
        @endphp
        <label >
            LBC :
            @foreach ($payment_method->all() as $item)
            <span style="color: {{ sprintf('#%06X', mt_rand(0, 0xFFFFFF)) }}">{{ $item->payment_method_name." (".$item->payment_method_price." ".$item->payment_method_abbrevation.") | " }}</span>
            @endforeach
        </label>
    </div>
    <section class="content-header" style="padding-top: 40px">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>{{ $title }}</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/"><span class="fa fa-home"></span> Dashboard</a></li>
                        @foreach ($breadcrumb as $key => $brd)
                        <li class="breadcrumb-item">
                            {{ $brd }}
                        </li>
                        @endforeach
                    </ol>
                </div>
          </div>
        </div><!-- /.container-fluid -->
    </section>
    @yield('subcontent')
</div>
@endsection

