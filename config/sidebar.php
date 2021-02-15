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
		'icon' => 'fa fa-home',
		'title' => 'Dashboard',
		'url' => '/dashboard'
	],[
		'icon' => 'fa fa-user',
		'title' => 'Profile',
		'url' => '/profile'
	],[
		'icon' => 'fa fa-medal',
		'title' => 'Achievement',
		'url' => '/achievement'
	],[
		'icon' => 'fa fa-exchange-alt',
		'title' => 'Exchange',
		'url' => '/exchange'
	],[
		'icon' => 'fa fa-network-wired',
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
		'icon' => 'fa fa-ticket-alt',
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
		'icon' => 'fa fa-recycle',
		'title' => 'Restacking',
		'url' => '/restacking'
	],[
		'icon' => 'fa fa-trophy',
		'title' => 'Reward',
		'url' => '/reward'
	],[
		'icon' => 'fa fa-wallet',
		'title' => 'Wallet',
		'url' => '/wallet'
	]]
];
