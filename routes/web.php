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

    Route::prefix('network')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Network\Pohon\Index::class)->name('network');
        Route::get('/registration', \App\Http\Livewire\Network\Registrasi\Form::class)->name('network.registration');
    });

    Route::prefix('registrationticket')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Pin\History\Index::class)->name('tiket');
        Route::get('/buy', \App\Http\Livewire\Pin\Beli\Form::class)->name('tiket.beli');
    });

    Route::prefix('balance')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Saldo\History\Index::class)->name('saldo');
        Route::get('/topup', \App\Http\Livewire\Saldo\Topup\Form::class)->name('saldo.topup');
    });

    Route::prefix('profile')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Profil\Form::class)->name('profil');
    });

    Route::prefix('profit')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Bagihasil\Total\Index::class)->name('bagihasil');
        Route::get('/topup', \App\Http\Livewire\Bagihasil\Harian\Index::class)->name('bagihasil.harian');
        Route::get('/activation', \App\Http\Livewire\Bagihasil\Aktivasi\Index::class)->name('bagihasil.tiket');
    });

    Route::prefix('reinvest')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Reinvest\Form::class)->name('reinvest');
    });

    Route::prefix('reward')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Reward\Index::class)->name('reward');
    });

    Route::prefix('wallet')->group(function ()
    {
        Route::get('/', \App\Http\Livewire\Wallet\History\Index::class)->name('wallet');
    });
});
