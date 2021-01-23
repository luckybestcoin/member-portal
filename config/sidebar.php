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
		'url' => '/dashboard',
		'id' => 'dashboard'
	],[
		'icon' => 'fa fa-dollar',
		'title' => 'Balance',
		'url' => 'javascript:void(0)',
		'id' => 'balance',
		'sub_menu' => [[
            'url' => '/balance',
            'id' => 'balancehistory',
            'title' => 'History'
        ],[
            'url' => '/balance/topup',
            'id' => 'balancetopup',
            'title' => 'Top Up'
        ]]
	],[
		'icon' => 'fa fa-group',
		'title' => 'Network',
		'url' => 'javascript:void(0)',
		'id' => 'network',
		'sub_menu' => [[
            'url' => '/network',
            'id' => 'networktree',
            'title' => 'Network Tree'
        ],[
            'url' => '/network/registration',
            'id' => 'networkregistration',
            'title' => 'Registration'
        ]]
	],[
		'icon' => 'fa fa-user',
		'title' => 'Profile',
		'url' => '/profile',
		'id' => 'profile'
	],[
		'icon' => 'fa fa-share-alt-square',
		'title' => 'Profit Sharing',
		'url' => 'javascript:void(0)',
		'id' => 'member',
		'sub_menu' => [[
            'url' => '/profit/daily',
            'id' => 'dailybonus',
            'title' => 'Daily Bonus'
        ],[
            'url' => '/profit/activation',
            'id' => 'activationbonus',
            'title' => 'Activation Bonus'
        ],[
            'url' => '/profit',
            'id' => 'totalbonus',
            'title' => 'Total'
        ]]
	],[
		'icon' => 'fa fa-recycle',
		'title' => 'Reinvest',
		'url' => '/reinvest',
		'id' => 'reinvest'
	],[
		'icon' => 'fa fa-ticket',
		'title' => 'Registration Ticket',
		'url' => 'javascript:void(0)',
		'id' => 'registration',
		'sub_menu' => [[
            'url' => '/registrationticket/buy',
            'id' => 'registrationticketbuy',
            'title' => 'Buy'
        ],[
            'url' => '/registrationticket',
            'id' => 'registrationtickethistory',
            'title' => 'History'
        ]]
	],[
		'icon' => 'fa fa-trophy',
		'title' => 'Reward',
		'url' => '/reward',
		'id' => 'reward'
	],[
		'icon' => 'zmdi zmdi-balance-wallet',
		'title' => 'Wallet',
		'url' => 'javascript:void(0)',
		'id' => 'wallet',
		'sub_menu' => [[
            'url' => '/wallet',
            'id' => 'wallethistory',
            'title' => 'History'
        ],[
            'url' => '/wallet/deposit',
            'id' => 'walletdeposit',
            'title' => 'Deposit'
        ],[
            'url' => '/wallet/withdraw',
            'id' => 'walletwithdraw',
            'title' => 'Withdraw'
        ]]
	]]
];
