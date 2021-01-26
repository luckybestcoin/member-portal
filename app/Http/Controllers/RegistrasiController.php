<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class RegistrasiController extends Controller
{
    //
    public function email()
    {
        Mail::to("andifajarlah@gmail.com")->send(new MailableClass);
        return 'berhasil mengirim email';
    }
}
