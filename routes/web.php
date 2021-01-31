<?php

use Illuminate\Support\Facades\Route;
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

Route::get('/referral', \App\Http\Livewire\Authentication\Referral::class)->name('referral');

Route::group(['middleware' => ['auth']], function () {
    Route::get('/', \App\Http\Livewire\Dashboard\Index::class);
    Route::get('/dashboard', \App\Http\Livewire\Dashboard\Index::class)->name('dashboard');

    Route::prefix('member')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Member\Downline::class)->name('member');
        Route::get('/registration', \App\Http\Livewire\Member\Registration::class)->name('member.registration');
    });

    Route::prefix('registrationticket')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Registrationticket\History::class)->name('tiket');
        Route::get('/buy', \App\Http\Livewire\Registrationticket\Buy::class)->name('tiket.beli');
        Route::get('/fee', \App\Http\Livewire\Registrationticket\Fee::class)->name('tiket.fee');
    });

    Route::prefix('balance')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Balance\History::class)->name('saldo');
        Route::get('/topup', \App\Http\Livewire\Balance\Topup::class)->name('saldo.topup');
    });

    Route::prefix('benefit')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Benefit\All::class)->name('bagihasil');
        Route::get('/daily', \App\Http\Livewire\Benefit\Daily::class)->name('bagihasil.harian');
        Route::get('/referral', \App\Http\Livewire\Benefit\Referral::class)->name('bagihasil.referal');
        Route::get('/turnovergrowth', \App\Http\Livewire\Benefit\Turnover::class)->name('bagihasil.omset');
    });

    // Route::prefix('profit')->group(function ()
    // {
    //     Route::get('/', \App\Http\Livewire\Bagihasil\Total\Index::class)->name('bagihasil');
    //     Route::get('/topup', \App\Http\Livewire\Bagihasil\Harian\Index::class)->name('bagihasil.harian');
    //     Route::get('/activation', \App\Http\Livewire\Bagihasil\Aktivasi\Index::class)->name('bagihasil.tiket');
    // });

    Route::prefix('profile')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Member\Profile::class)->name('profile');
    });

    // Route::prefix('reward')->group(function ()
    // {
    //     Route::get('/', \App\Http\Livewire\Reward\Index::class)->name('reward');
    // });

    Route::prefix('wallet')->group(function ()
    {
        Route::get('/deposit', \App\Http\Livewire\Wallet\Deposit::class)->name('deposit');
    });
});
