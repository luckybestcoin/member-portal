<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RateController;
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

Route::group(['middleware' => ['auth']], function () {
    Route::get('/', \App\Http\Livewire\Dashboard::class);
    Route::get('/dashboard', \App\Http\Livewire\Dashboard::class)->name('dashboard');

    Route::prefix('member')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Member\Downline::class)->name('member');
        Route::get('/registration', \App\Http\Livewire\Member\Registration::class)->name('member.registration');
    });

    Route::prefix('pin')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Pin\History::class)->name('pin');
        Route::get('/buy', \App\Http\Livewire\Pin\Buy::class)->name('pin.buy');
        Route::get('/fee', \App\Http\Livewire\Pin\Fee::class)->name('pin.fee');
    });

    Route::get('/reward', \App\Http\Livewire\RewardHistory::class)->name('bagihasil');
    Route::get('/profile', \App\Http\Livewire\Profile::class)->name('profile');
    Route::get('/wallet', \App\Http\Livewire\Lbc::class)->name('wallet');
    Route::get('/exchange', \App\Http\Livewire\Exchange::class)->name('exchange');

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
