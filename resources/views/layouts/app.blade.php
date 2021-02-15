<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    @include('includes.head')
    @livewireStyles
</head>
<body class="sidebar-mini layout-fixed control-sidebar-slide-open text-sm accent-navy layout-navbar-fixed">
    <div class="wrapper">
        @yield('content')
    </div>

    @include('includes.footer')
    @livewireScripts
    @include('includes.page-js')
</body>
</html>
