<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class WebhookController extends Controller
{
    //
    private $merchant_id = "afa24bb7e492ace905d9d52d3f5d4365";
    private $ipn_secret = "755hu8yash3y37uheru8tj";
    private $debug_email = "andifajarlah@gmail.com";

    public function index(Request $request)
    {
        $id = $request->get('txn_id');
        $deposit = Payment::findOrFail($id);
        $order_currency = $deposit->to_currency;
        $order_total = $deposit->amount;


        if ($request->get('ipn_mode') == null || $request->get('ipn_mode') != 'hmac') {
            edie("IPN Mode is not HMAC");
        }

        if (!isset($_SERVER['HTTP_HMAC']) || empty($_SERVER['HTTP_HMAC'])) {
            edie("No HMAC Signature Sent.");
        }

        $request = file_get_contents('php://input');
        if ($request === false || empty($request)) {
            edie("Error in reading Post Data");
        }

        if (!isset($_POST['merchant']) || $_POST['merchant'] != trim($merchant_id)) {
            edie("No or incorrect merchant id.");
        }

        $hmac =  hash_hmac("sha512", $request, trim($ipn_secret));
        if (!hash_equals($hmac, $_SERVER['HTTP_HMAC'])) {
            edie("HMAC signature does not match.");
        }

        $amount1 = floatval($request->get('amount1')); //IN USD
        $amount2 = floatval($request->get('amount2')); //IN BTC
        $currency1 = $request->get('currency1'); //USD
        $currency2 = $request->get('currency2'); //BTC
        $status = intval($request->get('status'));

        if ($currency2 != $order_currency) {
            edie("Currency Mismatch");
        }

        if ($amount2 < $order_total) {
            edie("Amount is lesser than order total");
        }

        if ($status >= 100 || $status == 2) {
            // Payment is complete
            $payment->status = "success";
            $payment->save();
        } else if ($status < 0) {
            // Payment Error
            $payment->status = "error";
            $payment->save();
        } else {
            // Payment Pending
            $payment->status = "pending";
            $payment->save();
        }
        die("IPN OK");
    }

    function edie($error_msg)
    {
        die($error_msg);
    }
}
