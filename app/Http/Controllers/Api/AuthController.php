<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Botble\Ecommerce\Models\Customer;
use Botble\Ecommerce\Models\MobileVerification;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    /**
     * Register a new customer
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function signup(Request $request) {

        $validator = Validator::make($request->all(), [
            'name'      => 'required|string|max:255',
            'email'     => 'required|string|max:255',
            'mobile'     => 'required|numeric',
            'password'  => 'required|string'
            ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        $customer = Customer::where('email', $request->email)->orWhere('phone', $request->mobile)->first();

        if ($customer) {
            return response()->json([
                'message'       => 'Duplicate Email Id Or Mobile Number',
            ]);
        }

        $customer = Customer::create([
            'name'      => $request->name,
            'email'     => $request->email,
            'phone'     => $request->mobile,
            'password'  => Hash::make($request->password)
        ]);

        // $token = $customer->createToken('auth_token')->plainTextToken;

        $otp = rand(1111, 9999);

        $ch = curl_init();

        $passw = "11F2";
        $pass = "$";
        $p = "E89_6C3";
        $password = $passw.$pass.$p;

        curl_setopt($ch, CURLOPT_URL, "https://myinboxmedia.in/api/mim/SendSMS?userid=MIM2300278&pwd=".$password."&mobile=974".$request->mobile."&sender=Ahmedper&msg=".$otp."".urlencode(' is your OTP for Registration')."&msgtype=16");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            echo 'Error:' . curl_error($ch);die;
        }
        curl_close ($ch);

        $customer->otp = $otp;
        $customer->save();

        return response()->json([
            'message'          => 'OTP Sent on Above Mobile Number'
        ]);
    }

    /**
     * Verify OTP
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function verifyOTP(Request $request) {

        $validator = Validator::make($request->all(), [
            'mobile'     => 'required|numeric',
            'otp'  => 'required|numeric'
          ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        if($request->flag == 'checkout') {
            $mobile_verification = MobileVerification::where('phone', $request->mobile)->where('otp', $request->otp)->orderBy('id', 'desc')->first();

            if (!$mobile_verification) {
                return response()->json([
                    'message'       => 'Invalid Mobile Number or OTP',
                ]);
            }

            $mobile_verification->otp = 0;
            $mobile_verification->save();

            return response()->json([
                'message'       => 'OTP Verified Successfully'
            ]);
        } else {
            $customer = Customer::select('id', 'name', 'email', 'phone')->where('phone', $request->mobile)->where('otp', $request->otp)->first();

            if (!$customer) {
                return response()->json([
                    'message'       => 'Invalid Mobile Number or OTP',
                ]);
            }

            $customer->otp = 0;
            $customer->save();

            $token = $customer->createToken('auth_token')->plainTextToken;

            return response()->json([
                'message'       => 'Customer Registered Successfully',
                'data'          => $customer,
                'access_token'  => $token,
                'token_type'    => 'Bearer'
            ]);
        }
    }

    /**
     * Sign In
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function signin(Request $request) {

        $validator = Validator::make($request->all(), [
            'mobile'     => 'required|numeric',
            'password'  => 'required|string'
          ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        $customer = Customer::select('id', 'name', 'email', 'password', 'phone')->where('phone', $request->mobile)->where('status', 'activated')->first();

        if (!$customer || !Hash::check($request->password, $customer->password)) {
            return response()->json([
                'message'       => 'Invalid Mobile Number or Password or Inactive Status',
            ]);
        }

        $token = $customer->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message'       => 'Login Successfully',
            'data'          => $customer,
            'access_token'  => $token,
            'token_type'    => 'Bearer'
        ]);
    }

    /**
     * Sign Out
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function signout() {
        $customer = Auth::guard('api')->user();
        if (!$customer) {
            return response()->json(['message' => 'No Active Session'], 401);
        }
        $customer->tokens()->delete();
        return response()->json(['message' => 'Logged Out Successfully']);
    }

    public function getCustomer(Request $request)
    {
        $customer = Auth::guard('api')->user();

        if (!$customer) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        return response()->json($customer);
    }

    public function sendOTP(Request $request) {

        $validator = Validator::make($request->all(), [
            'mobile'     => 'required|numeric',
            ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }        

        $otp = rand(1111, 9999);

        $ch = curl_init();

        $passw = "11F2";
        $pass = "$";
        $p = "E89_6C3";
        $password = $passw.$pass.$p;

        curl_setopt($ch, CURLOPT_URL, "https://myinboxmedia.in/api/mim/SendSMS?userid=MIM2300278&pwd=".$password."&mobile=974".$request->mobile."&sender=Ahmedper&msg=".$otp."".urlencode(' is your OTP for Registration')."&msgtype=16");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            echo 'Error:' . curl_error($ch);die;
        }
        curl_close ($ch);

        $mobile_verification = MobileVerification::where('phone', $request->mobile)->get();

        if ($mobile_verification) {
            foreach ($mobile_verification as $key => $value) {
                MobileVerification::where('phone', $value->phone)->delete();
            }
        }

        $Mobile_verification = MobileVerification::create([
            'otp'     => $otp,
            'phone'     => $request->mobile,
        ]);

        $Mobile_verification->save();

        return response()->json([
            'message'          => 'OTP Sent on Above Mobile Number'
        ]);
    }

}
