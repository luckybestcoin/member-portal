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
		'icon' => 'fa fa-dollar',
		'title' => 'Balance',
		'url' => 'javascript:void(0)',
		'sub_menu' => [[
            'url' => '/balance',
            'title' => 'History'
        ],[
            'url' => '/balance/topup',
            'title' => 'Top Up'
        ]]
	],[
		'icon' => 'fa fa-share-alt-square',
		'title' => 'Benefit',
		'url' => 'javascript:void(0)',
		'sub_menu' => [[
            'url' => '/benefit',
            'title' => 'All'
        ],[
            'url' => '/benefit/daily',
            'title' => 'Daily'
        ],[
            'url' => '/benefit/referral',
            'title' => 'Referral'
        ],[
            'url' => '/benefit/turnovergrowth',
            'title' => 'Turnover Growth'
        ]]
	],[
		'icon' => 'fa fa-group',
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
		'icon' => 'fa fa-user',
		'title' => 'Profile',
		'url' => '/profile'
	],[
		'icon' => 'fa fa-recycle',
		'title' => 'Reinvest',
		'url' => '/reinvest'
	],[
		'icon' => 'fa fa-ticket',
		'title' => 'Registration Ticket',
		'url' => 'javascript:void(0)',
		'sub_menu' => [[
            'url' => '/registrationticket/buy',
            'title' => 'Buy'
        ],[
            'url' => '/registrationticket/fee',
            'title' => 'Fee'
        ],[
            'url' => '/registrationticket',
            'title' => 'History'
        ]]
	],[
		'icon' => 'fa fa-trophy',
		'title' => 'Reward',
		'url' => '/reward'
	],[
		'icon' => 'zmdi zmdi-balance-wallet',
		'title' => 'Wallet',
		'url' => 'javascript:void(0)',
		'sub_menu' => [[
            'url' => '/wallet',
            'title' => 'History'
        ],[
            'url' => '/wallet/deposit',
            'title' => 'Deposit'
        ],[
            'url' => '/wallet/withdraw',
            'title' => 'Withdraw'
        ]]
	]]
];
