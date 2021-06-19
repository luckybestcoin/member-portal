<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RateController;
use App\Http\Controllers\WalletController;
use App\Http\Controllers\WebhookController;
use App\Http\Controllers\RegistrasiController;
use App\Http\Controllers\AutentikasiController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::get('/weebhook', [WebhookController::class, 'index']);
Route::get('/referral', \App\Http\Livewire\Authentication\Activation::class)->name('referral');
Route::get('/forgot', \App\Http\Livewire\Forgot\Main::class)->name('forgot');
Route::get('/recovery', \App\Http\Livewire\Forgot\Recover::class)->name('recovery');

Route::group(['middleware' => ['auth']], function () {
    Route::get('/', \App\Http\Livewire\Dashboard::class);
    Route::get('/dashboard', \App\Http\Livewire\Dashboard::class)->name('dashboard');
    Route::get('/balance', [WalletController::class, 'balance']);
    Route::get('/pinbalance', [WalletController::class, 'pin']);
    Route::get('/turnoverbalance', [WalletController::class, 'turnover']);

    Route::prefix('member')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Member\Downline::class)->name('member');
        // Route::get('/registration', \App\Http\Livewire\Member\Registration::class)->name('member.registration');
    });

    Route::prefix('pin')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Pin\History::class)->name('pin');
        Route::get('/buy', \App\Http\Livewire\Pin\Buy::class)->name('pin.buy');
        Route::get('/fee', \App\Http\Livewire\Pin\Fee::class)->name('pin.fee');
    });

    Route::prefix('wallet')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Wallet\Main::class)->name('wallet');
        Route::get('/deposit', \App\Http\Livewire\Wallet\Deposit::class)->name('wallet.deposit');
    });

    Route::get('/reward', \App\Http\Livewire\RewardHistory::class)->name('bagihasil');
    Route::get('/profile', \App\Http\Livewire\Profile::class)->name('profile');
    // Route::get('/conversion', \App\Http\Livewire\Conversion::class)->name('conversion');
    // Route::get('/achievement', \App\Http\Livewire\AchievementHistory::class)->name('achievement');
    // Route::get('/extension', \App\Http\Livewire\Extension::class)->name('extension');

    Route::get('/rate', [RateController::class, 'dollar']);

    // Route::prefix('profit')->group(function ()
    // {
    //     Route::get('/', \App\Http\Livewire\Bagihasil\Total\Index::class)->name('bagihasil');
    //     Route::get('/topup', \App\Http\Livewire\Bagihasil\Harian\Index::class)->name('bagihasil.harian');
    //     Route::get('/activation', \App\Http\Livewire\Bagihasil\Aktivasi\Index::class)->name('bagihasil.tiket');
    // });

    // Route::prefix('reward')->group(function ()
    // {
    //     Route::get('/', \App\Http\Livewire\Reward\Index::class)->name('reward');
    // });
});
