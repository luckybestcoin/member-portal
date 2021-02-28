<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WalletController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
$router->post('/create', [WalletController::class, 'create']);
$router->post('/send', [WalletController::class, 'send']);
$router->get('/balance', [WalletController::class, 'balance']);
$router->get('/transaction', [WalletController::class, 'transaction']);
