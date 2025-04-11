<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Botble\Ecommerce\Models\Customer;
use Botble\Ecommerce\Models\MobileVerification;
use Illuminate\Support\Facades\Auth;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

class ContactController extends Controller
{
    /**
     * Register a new customer
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function contact(Request $request) {

        $validator = Validator::make($request->all(), [
            'name'      => 'required|string',
            'email'     => 'required|string',
            'subject'     => 'required|string',
            'message'  => 'required|string'
            ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        $mail = new PHPMailer(true);
    
        try {
    
            /* Email SMTP Settings */
            $mail->SMTPDebug = 0;
            $mail->isSMTP();
            $mail->Host = env('MAIL_HOST');
            $mail->SMTPAuth = true;
            $mail->Username = env('MAIL_USERNAME');
            $mail->Password = env('MAIL_PASSWORD');
            $mail->SMTPSecure = env('MAIL_ENCRYPTION');
            $mail->Port = env('MAIL_PORT');
    
            $mail->setFrom(env('MAIL_FROM_ADDRESS'), env('MAIL_FROM_NAME'));
            $mail->addAddress('info@ahmedalmaghribi.com');
    
            $mail->isHTML(true);
    
            $mail->Subject = $request->subject;
            $mail->Body    = $request->name.'<br><br>'.$request->email.'<br><br>'.$request->message;
    
            if( !$mail->send() ) {
                return response()->json([
                    'message' => 'Oops... There is an Error'
                ]);
            }
                
            else {
                 return response()->json([
                    'message' => 'Contact Enquiry Submitted Successfully'
                ]);
            }
    
        } catch (Exception $e) {
            return response()->json([
                'message' => 'Oops... There is an Exception'
            ]);
        }
    }
}
