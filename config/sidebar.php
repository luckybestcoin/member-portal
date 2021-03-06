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

    'menu' => [//[
	// 	'icon' => '<i class="nav-icon fa fa-home"></i>',
	// 	'title' => 'Dashboard',
	// 	'url' => '/dashboard'
	// ],[
	// 	'icon' => '<i class="nav-icon fa fa-user"></i>',
	// 	'title' => 'Profile',
	// 	'url' => '/profile'
	// ],[
	// 	'icon' => '<i class="nav-icon fa fa-medal"></i>',
	// 	'title' => 'Achievement',
	// 	'url' => '/achievement'
	// ],[
	// 	'icon' => '<i class="nav-icon fa fa-exchange-alt"></i>',
	// 	'title' => 'Conversion',
	// 	'url' => '/conversion'
	// ],[
	// 	'icon' => '<i class="nav-icon fa fa-network-wired"></i>',
	// 	'title' => 'Member',
	// 	'url' => 'javascript:void(0)',
	// 	'sub_menu' => [[
    //         'url' => '/member',
    //         'title' => 'Downline'
    //     ],[
    //         'url' => '/member/registration',
    //         'title' => 'Registration'
    //     ]]
	// ],[
	// 	'icon' => '<i class="nav-icon fa fa-ticket-alt"></i>',
	// 	'title' => 'Pin',
	// 	'url' => 'javascript:void(0)',
	// 	'sub_menu' => [[
    //         'url' => '/pin/buy',
    //         'title' => 'Buy'
    //     ],[
    //         'url' => '/pin/fee',
    //         'title' => 'Fee'
    //     ],[
    //         'url' => '/pin',
    //         'title' => 'History'
    //     ]]
	// ],[
	// 	'icon' => '<i class="nav-icon fa fa-recycle"></i>',
	// 	'title' => 'Extension',
	// 	'url' => '/extension'
	// ],[
	// 	'icon' => '<i class="nav-icon fa fa-gift"></i>',
	// 	'title' => 'Reward',
	// 	'url' => '/reward'
	// ],
    [
		'icon' => '<img src="/images/lbc.png" class="ml-10" style="margin-left: 13px; margin-right: 5px; height: 25px">',
		'title' => 'Wallet',
		'url' => 'javascript:void(0)',
		'sub_menu' => [[
            'url' => '/wallet',
            'title' => 'Main'
        ],[
            'url' => '/wallet/deposit',
            'title' => 'Deposit'
        ]]
	]]
];
