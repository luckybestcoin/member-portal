<?php

return [

    /*
    |--------------------------------------------------------------------------
    | View Storage Paths
    |--------------------------------------------------------------------------
    |
    | Most templating systems load templates from disk. Here you may specify
    | an array of paths that should be checked for your views. Of course
    | the usual Laravel view path has already been registered for you.
    |
    */

    'menu' => [[
		'icon' => '<i class="nav-icon fa fa-home"></i>',
		'title' => 'Dashboard',
		'url' => '/dashboard'
	],[
		'icon' => '<i class="nav-icon fa fa-user"></i>',
		'title' => 'Profile',
		'url' => '/profile'
	],[
		'icon' => '<i class="nav-icon fa fa-medal"></i>',
		'title' => 'Achievement',
		'url' => '/achievement'
	],[
		'icon' => '<i class="nav-icon fa fa-exchange-alt"></i>',
		'title' => 'Exchange',
		'url' => '/exchange'
	],[
		'icon' => '<i class="nav-icon fa fa-network-wired"></i>',
		'title' => 'Member',
		'url' => 'javascript:void(0)',
		'sub_menu' => [[
            'url' => '/member',
            'title' => 'Downline'
        ],[
            'url' => '/member/registration',
            'title' => 'Registration'
        ]]
	],[
		'icon' => '<i class="nav-icon fa fa-ticket-alt"></i>',
		'title' => 'Pin',
		'url' => 'javascript:void(0)',
		'sub_menu' => [[
            'url' => '/pin/buy',
            'title' => 'Buy'
        ],[
            'url' => '/pin/fee',
            'title' => 'Fee'
        ],[
            'url' => '/pin',
            'title' => 'History'
        ]]
	],[
		'icon' => '<i class="nav-icon fa fa-recycle"></i>',
		'title' => 'Restacking',
		'url' => '/restacking'
	],[
		'icon' => '<i class="nav-icon fa fa-gift"></i>',
		'title' => 'Reward',
		'url' => '/reward'
	],[
		'icon' => '<img src="/images/favicon.ico" class="ml-10" style="margin-left: 13px; height: 25px">',
		'title' => '<strong style="margin-left: 3px">Wallet</strong>',
		'url' => '/wallet'
	]]
];
