<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Botble\Ecommerce\Models\Customer;
use Illuminate\Support\Facades\Auth;
use Botble\Ecommerce\Models\Order;
use Botble\Ecommerce\Models\OrderHistory;
use Botble\Ecommerce\Enums\ShippingMethodEnum;
use Botble\Ecommerce\Enums\OrderStatusEnum;
use Botble\Ecommerce\Enums\OrderHistoryActionEnum;
use Botble\Ecommerce\Services\CreatePaymentForOrderService;
use Botble\Ecommerce\Models\OrderAddress;
use Botble\Ecommerce\Models\Address;
use Botble\Ecommerce\Models\Product;
use Botble\Ecommerce\Models\OrderProduct;
use Botble\Ecommerce\Models\Invoice;
// use Botble\Ecommerce\Models\InvoiceItem;
use Botble\Ecommerce\Facades\Discount;
use Botble\Ecommerce\Models\DiscountProduct;
use Botble\Ecommerce\Models\Discount as DiscountModel;
use Botble\Ecommerce\Models\MobileVerification;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

use App\Services\ExternalConfiguration;

class OrderController extends Controller
{
    public function storeOrder(Request $request, CreatePaymentForOrderService $createPaymentForOrderService) {

        $validator = Validator::make($request->all(), [
            'products'      => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        foreach ($request->input('products') as $product) {
            $exisProduct = Product::where('id', $product['product_id'])->first();
            if (!$exisProduct) {
                return response()->json([
                    'notFound' => 'Product not found '.$product['product_name']
                ], 500);
            }

            if($exisProduct->quantity < $product['quantity']) {
                return response()->json([
                    'qtyMessage'          => $product['product_name'].' is Out Of Stock.'
                ]);
            }

            // if(!is_null($product['discount'])) {
                $discountFromDb = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $product['product_id'])->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
                $requestHasDiscount = !is_null($product['discount']);
                $dbHasDiscount = !is_null($discountFromDb);

                if ($requestHasDiscount && !$dbHasDiscount) {
                    // Request says there should be a discount, but none found in DB
                    return response()->json([
                        'discountMessage' => 'One or more Products were removed. Please add them again to continue.'
                    ]);
                }

                if (!$requestHasDiscount && $dbHasDiscount) {
                    // Request says there should be no discount, but one exists in DB
                    return response()->json([
                        'discountMessage' => 'One or more Products were removed. Please add them again to continue.'
                    ]);
                }

                // Optional: if you want to compare actual values of discount too
                if ($requestHasDiscount && $dbHasDiscount) {
                    $match =
                        $product['discount']['value'] == $discountFromDb->value &&
                        $product['discount']['start_date'] == $discountFromDb->start_date &&
                        $product['discount']['end_date'] == $discountFromDb->end_date;

                    if (!$match) {
                        return response()->json([
                            'discountMessage' => 'One or more Products were removed. Please add them again to continue.'
                        ]);
                    }
                }

                // All matched, assign discount
                $exisProduct->discount = $discountFromDb;
            // }
        }

        $coupon_code = $request->input('couponCode');
        if(isset($coupon_code) && !empty($request->input('couponCode'))) {
            $coupon = DiscountModel::where('code', $request->input('couponCode'))->where('start_date', '<=', now())->where('end_date', '>=', now())->first();
            if(!$coupon) {
                return response()->json(['couponMessage' => 'Invalid Coupon Code']);
            }
            $customer = OrderAddress::join('payments', 'payments.order_id', '=', 'ec_order_addresses.order_id')->where('status', 'completed')->where('phone', $request->input('billingAddress.mobile'))->get();
            // echo $order_address;
            if(!$customer->isEmpty()) {
                // if(strtolower($request->input('couponCode')) == 'welcome10') {
                //     return response()->json(['couponMessage' => 'You Have Already Used this Coupon Code']);
                // }
                $customer_discount = DB::table('ec_customer_used_coupons')->where('customer_id', $customer[0]->customer_id)->where('discount_id', $coupon->id)->first();
                if($customer_discount) {
                    return response()->json(['couponMessage' => 'You Have Already Used this Coupon Code']);
                }
            }
        }

        if($request->input('payment_method') == 'cybersourcee') {
            $commonElement = new \App\Services\ExternalConfiguration();
            $config = $commonElement->ConnectionHost();
            $merchantConfig = $commonElement->merchantConfigObject();

            $apiClient = new \CyberSource\ApiClient($config, $merchantConfig);
            $apiInstance = new \CyberSource\Api\TransactionDetailsApi($apiClient);

            try {
                $apiResponse = $apiInstance->getTransaction($request->input('paymentId'));
                // echo "<pre>";print_r($apiResponse[0]['orderInformation']['shipTo']);die;
            } catch (\Cybersource\ApiException $e) {
                // print_r($e->getResponseBody());
                // print_r($e->getMessage());
                return response()->json([
                    'message'          => $e->getMessage(),
                    'data'            => $e->getResponseBody()
                ]);
            }
        }

        $customer_id = $request->input('customer_id');

        if (!$customer_id) {
            $validator = Validator::make($request->all(), [
                'billingAddress.first_name'      => 'required|string|max:255',
                'billingAddress.last_name'      => 'required|string|max:255',
                'billingAddress.email'     => 'required|string|max:255',
                'billingAddress.mobile'     => 'required|numeric',
                'billingAddress.area'     => 'required|string',
                'billingAddress.building'     => 'required|string',
                'billingAddress.city'     => 'required|string',
            ]);
    
            if ($validator->fails()) {
                return response()->json($validator->errors());
            }
            
            $exisCustomer = Customer::where('email', $request->billingAddress['email'])->orWhere('phone', $request->billingAddress['mobile'])->first();
    
            if (!$exisCustomer) {
                $customer = Customer::create([
                    'name'      => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['firstName'].' '.$apiResponse[0]['orderInformation']['billTo']['lastName'] : $request->input('billingAddress.first_name').' '.$request->input('billingAddress.last_name'),
                    'email'     => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['email'] : $request->input('billingAddress.email'),
                    'phone'     => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['phoneNumber'] : $request->input('billingAddress.mobile'),
                    'password'  => $request->input('password') ? Hash::make($request->input('password')) : Hash::make('123456')
                ]);

                Address::create([
                    'name'      => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['firstName'].' '.$apiResponse[0]['orderInformation']['billTo']['lastName'] : $request->input('billingAddress.first_name').' '.$request->input('billingAddress.last_name'),
                    'email'     => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['email'] : $request->input('billingAddress.email'),
                    'phone'     => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['phoneNumber'] : $request->input('billingAddress.mobile'),
                    'state' => $request->input('billingAddress.city'),
                    'city' => $request->input('billingAddress.city'),
                    'country' => $request->input('billingAddress.country'),
                    'address' => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['address1'] : $request->input('billingAddress.area').' '.$request->input('billingAddress.building'),
                    'customer_id' => $customer->id,
                ]);

                // $otp = rand(1111, 9999);

                // $ch = curl_init();

                // $passw = "11F2";
                // $pass = "$";
                // $p = "E89_6C3";
                // $password = $passw.$pass.$p;

                // curl_setopt($ch, CURLOPT_URL, "https://myinboxmedia.in/api/mim/SendSMS?userid=MIM2300278&pwd=".$password."&mobile=974".$request->input('billingAddress.mobile')."&sender=Ahmedper&msg=".$otp."".urlencode(' is your OTP for Registration')."&msgtype=16");
                // curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                // curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");

                // $result = curl_exec($ch);
                // if (curl_errno($ch)) {
                //     echo 'Error:' . curl_error($ch);die;
                // }
                // curl_close ($ch);

                // $customer->otp = $otp;
                // $customer->save();

                $customer_id = $customer->id;
            } else {
                $exisAddress = Address::where('customer_id', $exisCustomer->id)->first();
                if(!$exisAddress) {
                    Address::create([
                        'name'      => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['firstName'].' '.$apiResponse[0]['orderInformation']['billTo']['lastName'] : $request->input('billingAddress.first_name').' '.$request->input('billingAddress.last_name'),
                        'email'     => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['email'] : $request->input('billingAddress.email'),
                        'phone'     => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['phoneNumber'] : $request->input('billingAddress.mobile'),
                        'state' => $request->input('billingAddress.city'),
                        'city' => $request->input('billingAddress.city'),
                        'country' => $request->input('billingAddress.country'),
                        'address' => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['address1'] : $request->input('billingAddress.area').' '.$request->input('billingAddress.building'),
                        'customer_id' => $exisCustomer->id,
                    ]);
                }
                $customer_id = $exisCustomer->id;
            }
        }

        // echo "<pre>";print_r(([
        //     'user_id' => $customer_id,
        //     'shipping_method' => $request->input('shipping_method') ? : ShippingMethodEnum::DEFAULT,
        //     'shipping_option' => $request->input('shipping_option'),
        //     'shipping_amount' => $request->input('shippingPrice') ? : 0,
        //     'tax_amount' => (($request->input('finalPrice') - 3) / 100) * 5 ? : 0,
        //     'sub_total' => $request->input('totalPrice') ? : 0,
        //     'amount' => $request->input('finalPrice') ? : 0,
        //     'coupon_code' => $request->input('coupon_code'),
        //     'discount_amount' => $request->input('discount_amount') ? : 0,
        //     'promotion_amount' => $request->input('promotion_amount') ? : 0,
        //     'discount_description' => $request->input('discount_description'),
        //     'description' => $request->input('note'),
        //     'is_confirmed' => 1,
        //     'is_finished' => 1,
        //     'status' => OrderStatusEnum::PROCESSING,
        //     'lang' => $request->input('locale'),
        // ]));die();
        // echo "<pre>";print_r([
        //     'user_id' => $customer_id,
        //     'shipping_method' => $request->input('shipping_method') ? : ShippingMethodEnum::DEFAULT,
        //     'shipping_option' => $request->input('shipping_option'),
        //     'shipping_amount' => $request->input('shippingPrice') ? : 0,
        //     'tax_amount' => (($request->input('finalPrice') - 3) / 100) * 5 ? : 0,
        //     'sub_total' => $request->input('totalPrice') ? : 0,
        //     'amount' => $request->input('finalPrice') ? : 0,
        //     'coupon_code' => $request->input('coupon_code'),
        //     'discount_amount' => $request->input('discount_amount') ? : 0,
        //     'promotion_amount' => $request->input('promotion_amount') ? : 0,
        //     'discount_description' => $request->input('discount_description'),
        //     'description' => $request->input('note'),
        //     'is_confirmed' => 1,
        //     'is_finished' => 1,
        //     'status' => OrderStatusEnum::PROCESSING,
        //     'order_lang' => $request->input('locale'),
        // ]);die();
        $order = Order::create([
            'user_id' => $customer_id,
            'shipping_method' => $request->input('shipping_method') ? : ShippingMethodEnum::DEFAULT,
            'shipping_option' => $request->input('shipping_option'),
            'shipping_amount' => $request->input('shippingPrice') / (1 + ($request->input('vatTax') / 100)),
            'shipping_amount_vat' => $request->input('shippingPrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100),
            'service_amount' => $request->input('servicePrice') / (1 + ($request->input('vatTax') / 100)),
            'service_amount_vat' => $request->input('servicePrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100),
            'vat' => $request->input('vatTax'),
            'tax_amount' => ($request->input('totalPrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100)) + ($request->input('shippingPrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100)) + ($request->input('servicePrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100)),
            'sub_total' => $request->input('totalPrice') ? : 0,
            'amount' => $request->input('finalPrice') ? : 0,
            'coupon_code' => $request->input('couponCode'),
            'discount_amount' => $request->input('discount_amount') ? : 0,
            'promotion_amount' => $request->input('promotion_amount') ? : 0,
            'discount_description' => $request->input('discount_description'),
            'description' => $request->input('note'),
            'is_confirmed' => 1,
            'is_finished' => 1,
            'status' => OrderStatusEnum::PROCESSING,
            'lang' => $request->input('locale'),
        ]);

        // echo "<pre>";print_r($order);die();

        if($order) {

            if($request->input('customer_id')) {
                $loggedInCustomer = Customer::where('id', $request->input('customer_id'))->first();
                $loggedInCustomerAdd = Address::where('customer_id', $loggedInCustomer->id)->first();
                if(!$loggedInCustomerAdd) {
                    Address::create([
                        'name'      => $loggedInCustomer->name,
                        'email'     => $loggedInCustomer->email,
                        'phone'     => $loggedInCustomer->phone,
                        'state' => $request->input('billingAddress.city'),
                        'city' => $request->input('billingAddress.city'),
                        'country' => $request->input('billingAddress.country'),
                        'address' => $request->input('payment_method') == 'cybersourcee' ? $apiResponse[0]['orderInformation']['billTo']['address1'] : $request->input('billingAddress.area').' '.$request->input('billingAddress.building'),
                        'customer_id' => $loggedInCustomer->id,
                    ]);
                    $loggedInCustomerAdd = Address::where('customer_id', $loggedInCustomer->id)->first();
                }
                if($request->input('payment_method') == 'cybersourcee') {
                    $name = $apiResponse[0]['orderInformation']['shipTo']['firstName'].' '.$apiResponse[0]['orderInformation']['shipTo']['lastName'];
                    $address = $apiResponse[0]['orderInformation']['shipTo']['address1'];
                } elseif($request->input('shippingAddress.first_name')) {
                    $name = $request->input('shippingAddress.first_name').' '.$request->input('shippingAddress.last_name');
                    $address = $request->input('shippingAddress.area').' '.$request->input('shippingAddress.building');
                } else {
                    $name = $loggedInCustomer->name;
                    $address = $loggedInCustomerAdd->address;
                }
                OrderAddress::query()->create([
                    'name' => $name,
                    'phone' => $request->input('shippingAddress.mobile') ? $request->input('shippingAddress.mobile') : $loggedInCustomer->phone,
                    'email' => $request->input('shippingAddress.email') ? $request->input('shippingAddress.email') : $loggedInCustomer->email,
                    'state' => $request->input('shippingAddress.city') ? $request->input('shippingAddress.city') : $loggedInCustomerAdd->state,
                    'city' => $request->input('shippingAddress.city') ? $request->input('shippingAddress.city') : $loggedInCustomerAdd->city,
                    'country' => $request->input('shippingAddress.country') ? $request->input('shippingAddress.country') : $loggedInCustomerAdd->country,
                    'address' => $address,
                    'order_id' => $order->id,
                    'type' => $request->input('shippingAddress.first_name') ? 'shipping_address' : 'billing_address',
                ]);

                // if($request->input('payment_method') == 'cybersourcee') {           
                //     $data = [
                //         "name"=> $request->input('shippingAddress.first_name') ? $request->input('shippingAddress.first_name').' '.$request->input('shippingAddress.last_name') : $loggedInCustomer->name,
                //         "email"=> $request->input('shippingAddress.email') ? $request->input('shippingAddress.email') : $loggedInCustomer->email,
                //         "phone"=> $request->input('shippingAddress.mobile') ? $request->input('shippingAddress.mobile') : $loggedInCustomer->phone,
                //         "street1"=> $request->input('shippingAddress.area') ? $request->input('shippingAddress.area').' '.$request->input('shippingAddress.building') : $loggedInCustomerAdd->address,
                //         "city"=> $request->input('shippingAddress.city') ? $request->input('shippingAddress.city') : $loggedInCustomerAdd->city,
                //         "state"=> $request->input('shippingAddress.city') ? $request->input('shippingAddress.city') : $loggedInCustomerAdd->state,
                //         "country"=> "QA",
                //         // "zip"=> "54321"
                //     ];
                //     // $resp = $this->cyberSourcePayment($request, $data);
                //     // return response()->json([
                //     //     'redirect_url'     => $resp['redirect_url']
                //     // ]);
                // }

            } else {
                if($request->input('payment_method') == 'cybersourcee') {
                    $name = $apiResponse[0]['orderInformation']['shipTo']['firstName'].' '.$apiResponse[0]['orderInformation']['shipTo']['lastName'];
                    $address = $apiResponse[0]['orderInformation']['shipTo']['address1'];
                } elseif($request->input('shippingAddress.first_name')) {
                    $name = $request->input('shippingAddress.first_name').' '.$request->input('shippingAddress.last_name');
                    $address = $request->input('shippingAddress.area').' '.$request->input('shippingAddress.building');
                } else {
                    $name = $request->input('billingAddress.first_name').' '.$request->input('billingAddress.last_name');
                    $address = $request->input('billingAddress.area').' '.$request->input('billingAddress.building');
                }
                OrderAddress::query()->create([
                    'name' => $name,
                    'phone' => $request->input('shippingAddress.mobile') ? $request->input('shippingAddress.mobile') : $request->input('billingAddress.mobile'),
                    'email' => $request->input('shippingAddress.email') ? $request->input('shippingAddress.email') : $request->input('billingAddress.email'),
                    'state' => $request->input('shippingAddress.city') ? $request->input('shippingAddress.city') : $request->input('billingAddress.city'),
                    'city' => $request->input('shippingAddress.city') ? $request->input('shippingAddress.city') : $request->input('billingAddress.city'),
                    // 'zip_code' => $request->input('shippingAddress.zip_code'),
                    'country' => $request->input('shippingAddress.country') ? $request->input('shippingAddress.country') : $request->input('billingAddress.country'),
                    'address' => $address,
                    'order_id' => $order->id,
                    'type' => $request->input('shippingAddress.first_name') ? 'shipping_address' : 'billing_address',
                ]);

                // if($request->input('payment_method') == 'cybersourcee') {
                //     $data = [
                //         "name"=> $request->input('shippingAddress.first_name') ? $request->input('shippingAddress.first_name').' '.$request->input('shippingAddress.last_name') : $request->input('billingAddress.first_name').' '.$request->input('billingAddress.last_name'),
                //         "email"=> $request->input('shippingAddress.email') ? $request->input('shippingAddress.email') : $request->input('billingAddress.email'),
                //         "phone"=> $request->input('shippingAddress.mobile') ? $request->input('shippingAddress.mobile') : $request->input('billingAddress.mobile'),
                //         "street1"=> $request->input('shippingAddress.area') ? $request->input('shippingAddress.area').' '.$request->input('shippingAddress.building') : $request->input('billingAddress.area').' '.$request->input('billingAddress.building'),
                //         "city"=> $request->input('shippingAddress.city') ? $request->input('shippingAddress.city') : $request->input('billingAddress.city'),
                //         "state"=> $request->input('shippingAddress.city') ? $request->input('shippingAddress.city') : $request->input('billingAddress.city'),
                //         "country"=> "QA",
                //         // "zip"=> "54321"
                //     ];
                //     // $resp = $this->cybersourcePayment($request, $data);
                //     // return response()->json([
                //     //     'redirect_url'     => $resp['redirect_url']
                //     // ]);
                // }
            }
            // die();
            OrderHistory::query()->create([
                'action' => OrderHistoryActionEnum::CREATE_ORDER_FROM_WEBSITE,
                'description' => trans('plugins/ecommerce::order.create_order_from_website'),
                'order_id' => $order->getKey(),
            ]);

            OrderHistory::query()->create([
                'action' => OrderHistoryActionEnum::CREATE_ORDER,
                'description' => trans(
                    'plugins/ecommerce::order.new_order',
                    ['order_id' => $order->code]
                ),
                'order_id' => $order->getKey(),
            ]);

            OrderHistory::query()->create([
                'action' => OrderHistoryActionEnum::CONFIRM_ORDER,
                'description' => trans('plugins/ecommerce::order.order_was_verified_by'),
                'order_id' => $order->getKey(),
                'user_id' => $customer_id,
            ]);

            $prod = array();
    
            foreach ($request->input('products') as $product) {
                
                $quantity = $product['quantity'] ? $product['quantity'] : 1;

                $exisProduct = Product::where('ec_products.id', $product['product_id'])
                // ->join('ec_tax_products', 'ec_products.id', '=', 'ec_tax_products.product_id')->join('ec_taxes', 'ec_taxes.id', '=', 'ec_tax_products.tax_id')
                ->first();

                $exisProduct->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $product['product_id'])->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $product['product_id'])->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();

                // Store in a temporary property or a new array
                $couponData = [];
                foreach ($coupons as $coupon) {
                    $couponData[strtolower($coupon->code)] = [
                        'code' => strtolower($coupon->code),
                        'value' => $coupon->value,
                        'start_date' => $coupon->start_date,
                        'end_date' => $coupon->end_date,
                    ];
                }

                $exisProduct->coupon = $couponData;

                $exisProduct->qty = $quantity;

                // print_r($exisProduct);

                // if((isset($product['is_gift']) && $product['is_gift'] == true)) {
                //     $exisProduct->is_gift = 1;
                // }

                array_push($prod, $exisProduct);

                // $discount_price = '';
                // $sale_price = '';
                if(!is_null($exisProduct->discount)) {
                    $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
                    $total_amount = $price * $quantity;
                    $discount_percent = $exisProduct->discount->value;
                    $discount_amount = ($total_amount / 100) * $discount_percent;
                    $net_amount = $total_amount - $discount_amount;
                    $tax_amount = ($net_amount / 100) * $request->input('vatTax');
                    $gross_amount = $net_amount + $tax_amount;
                    $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
                    $orderProduct = [
                        'order_id' => $order->id,
                        'product_id' => $product['product_id'],
                        'product_name' => $exisProduct->name,
                        'product_image' => $exisProduct->image,
                        'qty' => $quantity,
                        'weight' => $exisProduct->weight,
                        'price' => $price,
                        'total_amount' => $total_amount,
                        'discount_percent' => $discount_percent,
                        'discount_amount' => $discount_amount,
                        'net_amount' => $net_amount,
                        'tax_amount' => $tax_amount,
                        'gross_amount' => $gross_amount,
                        'product_options' => [],
                        'options' => json_encode($options),
                        'product_type' => $exisProduct->product_type,
                        'product_category' => $product['category_name'],
                        'product_subcategory' => isset($product['subcategory_name']) ? $product['subcategory_name'] : '',
                        'vat' => $request->input('vatTax'),
                    ];
                } elseif(!empty($product['coupon']) && !is_null($exisProduct->coupon) && !empty($exisProduct->coupon) && isset($exisProduct->coupon) && isset($exisProduct->coupon[strtolower($request->input('couponCode'))]) && $exisProduct->coupon[strtolower($request->input('couponCode'))]['code'] == strtolower($request->input('couponCode'))) {
                    $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
                    $total_amount = $price * $quantity;
                    $discount_percent = $exisProduct->coupon[strtolower($request->input('couponCode'))]['value'];
                    $discount_amount = ($total_amount / 100) * $discount_percent;
                    $net_amount = $total_amount - $discount_amount;
                    $tax_amount = ($net_amount / 100) * $request->input('vatTax');
                    $gross_amount = $net_amount + $tax_amount;
                    $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
                    $orderProduct = [
                        'order_id' => $order->id,
                        'product_id' => $product['product_id'],
                        'product_name' => $exisProduct->name,
                        'product_image' => $exisProduct->image,
                        'qty' => $quantity,
                        'weight' => $exisProduct->weight,
                        'price' => $price,
                        'total_amount' => $total_amount,
                        'discount_percent' => $discount_percent,
                        'discount_amount' => $discount_amount,
                        'net_amount' => $net_amount,
                        'tax_amount' => $tax_amount,
                        'gross_amount' => $gross_amount,
                        'product_options' => [],
                        'options' => json_encode($options),
                        'product_type' => $exisProduct->product_type,
                        'product_category' => $product['category_name'],
                        'product_subcategory' => isset($product['subcategory_name']) ? $product['subcategory_name'] : '',
                        'vat' => $request->input('vatTax'),
                        'campaign' => $request->input('couponCode'),
                    ];
                } elseif(!is_null($exisProduct->sale_price)) {
                    $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
                    $total_amount = $price * $quantity;
                    $sale_price = $exisProduct->sale_price / (1 + ($request->input('vatTax') / 100));
                    $discount_percent = 0;
                    $discount_amount = $total_amount - ($sale_price * $quantity);
                    $net_amount = $total_amount - $discount_amount;
                    $tax_amount = ($net_amount / 100) * $request->input('vatTax');
                    $gross_amount = $net_amount + $tax_amount;
                    $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
                    $orderProduct = [
                        'order_id' => $order->id,
                        'product_id' => $product['product_id'],
                        'product_name' => $exisProduct->name,
                        'product_image' => $exisProduct->image,
                        'qty' => $quantity,
                        'weight' => $exisProduct->weight,
                        'price' => $price,
                        'total_amount' => $total_amount,
                        'discount_percent' => $discount_percent,
                        'discount_amount' => $discount_amount,
                        'net_amount' => $net_amount,
                        'tax_amount' => $tax_amount,
                        'gross_amount' => $gross_amount,
                        'product_options' => [],
                        'options' => json_encode($options),
                        'product_type' => $exisProduct->product_type,
                        'product_category' => $product['category_name'],
                        'product_subcategory' => isset($product['subcategory_name']) ? $product['subcategory_name'] : '',
                        'vat' => $request->input('vatTax'),
                    ];
                }
                // elseif(isset($product['is_gift']) && $product['is_gift'] == true) {
                //     $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
                //     $total_amount = 0.00;
                //     $discount_percent = 100;
                //     $discount_amount = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
                //     $net_amount = 0.00;
                //     $tax_amount = 0.00;
                //     $gross_amount = 0.00;
                //     $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
                //     $orderProduct = [
                //         'order_id' => $order->id,
                //         'product_id' => $product['product_id'],
                //         'product_name' => $exisProduct->name,
                //         'product_image' => $exisProduct->image,
                //         'qty' => $quantity,
                //         'weight' => $exisProduct->weight,
                //         'price' => $price,
                //         'total_amount' => $total_amount,
                //         'discount_percent' => $discount_percent,
                //         'discount_amount' => $discount_amount,
                //         'net_amount' => $net_amount,
                //         'tax_amount' => $tax_amount,
                //         'gross_amount' => $gross_amount,
                //         'product_options' => [],
                //         'options' => json_encode($options),
                //         'product_type' => $exisProduct->product_type,
                //         'product_category' => '',
                //         'product_subcategory' => '',
                //         'vat' => $request->input('vatTax'),
                //         'is_gift' => 1,
                //         'campaign' => 'free_gift_fathers_day_2025_campaign', 
                //     ];
                // }
                 else {
                    $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
                    $total_amount = $price * $quantity;
                    $discount_percent = 0;
                    $discount_amount = 0.00;
                    $net_amount = $total_amount - $discount_amount;
                    $tax_amount = ($net_amount / 100) * $request->input('vatTax');
                    $gross_amount = $net_amount + $tax_amount;
                    $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
                    $orderProduct = [
                        'order_id' => $order->id,
                        'product_id' => $product['product_id'],
                        'product_name' => $exisProduct->name,
                        'product_image' => $exisProduct->image,
                        'qty' => $quantity,
                        'weight' => $exisProduct->weight,
                        'price' => $price,
                        'total_amount' => $total_amount,
                        'discount_percent' => $discount_percent,
                        'discount_amount' => $discount_amount,
                        'net_amount' => $net_amount,
                        'tax_amount' => $tax_amount,
                        'gross_amount' => $gross_amount,
                        'product_options' => [],
                        'options' => json_encode($options),
                        'product_type' => $exisProduct->product_type,
                        'product_category' => $product['category_name'],
                        'product_subcategory' => isset($product['subcategory_name']) ? $product['subcategory_name'] : '',
                        'vat' => $request->input('vatTax'),
                    ];
                }

                OrderProduct::query()->create($orderProduct);

                Product::query()
                    ->where('id', $product['product_id'])
                    ->where('with_storehouse_management', 1)
                    ->where('quantity', '>=', $quantity)
                    ->decrement('quantity', $quantity);

                // $url = "https://c21341-ifservice.cloudiax.com/api/ECommerce/StockStatus?itemCode=123456";
                // // $url = "https://c21341-ifservice.cloudiax.com/api/ECommerce/StockStatus?itemCode=".$exisProduct->barcode;

                // $ch = curl_init();

                // curl_setopt($ch, CURLOPT_URL, $url);
                // curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                // // Set the request method to POST
                // curl_setopt($ch, CURLOPT_POST, true);
                // curl_setopt($ch, CURLOPT_HTTPHEADER, [
                //     "Accept: application/json",
                //     "Company: QAT", 
                //     "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiJhZG1pbiIsIkVtcElEIjoiMTAyNDgiLCJDb21wYW55IjoiIiwiV2hzQ29kZSI6IidDdXN0b20nLCdETV8wMScsJ0ZHXzAxJywnRk9DJywnSUNfVUFFJywnUE1fMDEnLCdTUF8wMDEnLCdTUF8wMDInLCdTUF8wMDMnLCdTUF8wMDQnLCdTUF8wMDUnLCdTUF8wMDYnLCdTUF8wMDcnLCdTUF8wMDgnLCdTUF8wMDknLCdTUF8wMTAnLCdTUF8wMTEnLCdTUF8wMTInLCdTUF8wMTMnLCdTUF8wMTQnLCcwMScsJ0NOMDAxXzAxJywnQ3VzdG9tJywnRE1fMDEnLCdGR18wMScsJ0ZHXzAyJywnRkdfMDMnLCdGT0MnLCdJQ18wMScsJ0lDX1VBRScsJ1BNXzAxJywnU1BfMDAxJywnU1BfMDAxXzEnLCdTUF8wMDInLCdTUF8wMDMnLCdTUF8wMDNfMScsJ1NQXzAwNCcsJ1NQXzAwNScsJ1NQXzAwNicsJ1NQXzAwNycsJ1NQXzAwOCcsJ1NQXzAwOScsJ1NQXzAxMCcsJ1NQXzAxMScsJ1NQXzAxMicsJ1NQXzAxMycsJ1NQXzAxNCcsJ1NQXzAxNScsJ1NQXzAxNicsJ1NQXzAxNycsJ1NQXzAxOScsJ1NQXzAyMCcsJ1NQXzAyMF8xJywnU1BfMDIxJywnU1BfMDIyJywnU1BfMDIzJywnU1BfMDI0JywnU1BfMDI1JywnU1BfMDI2JywnU1BfMDI3JywnU1BfMDI4JywnU1BfMDI4XzEnLCdTUF8wMjhfMicsJ1NQXzAyOScsJ1NQXzAzMCcsJ1NQXzAzMScsJ1ZOXzAwMScsJ0N1c3RvbScsJ0RNXzAxJywnRkdfMDEnLCdGT0MnLCdJQ19VQUUnLCdQTV8wMScsJ1NQXzAwMScsJ1NQXzAwMicsJ1NQXzAwMycsJ1NQXzAwNCcsJ1NQXzAwNScsJ1NQXzAwNicsJ1NQXzAwNycsJ1NQXzAwOCcsJzAxJywnQ3VzdG9tJywnRE1fMDEnLCdGR18wMScsJ0ZPQycsJ0lDXzAxJywnSUNfTW92JywnSUNfT0FQJywnSUNfVUFFJywnUE1fMDEnLCdTUF8wMDEnLCdTUF8wMDInLCdTUF8wMDMnLCdTUF8wMDQnLCdTUF8wMDUnLCdTUF8wMDYnLCdTUF8wMDcnLCdTUF8wMDgnLCdTUF8wMDknLCdTUF8wMTAnLCdTUF8wMTEnLCdTUF8wMTInLCdTUF8wMTMnLCdTUF8wMTQnLCdTUF8wMTUnLCdTUF8wMTYnLCdTUF8wMTcnLCdTUF8wMTgnLCdTUF8wMTknLCdTUF8wMjAnLCdTUF8wMjEnLCdTUF8wMjInLCdTUF8wMjMnLCdTUF8wMjQnLCdTUF8wMjUnLCdTUF8wMjYnLCdTUF8wMjcnLCdTUF8wMjgnLCdTUF8wMjknLCdTUF8wMzAnLCdTUF8wMzEnLCdTUF8wMzInLCdTUF8wMzMnLCdTUF8wMzQnLCdTUF8wMzUnLCdTUF8wMzYnLCdTUF8wMzcnLCdTUF8wMzgnLCdTUF8wMzknLCdTUF8wNDAnLCdTUF8wNDEnLCdTUF8wNDInLCdTUF8wNDMnLCdTUF8wNDQnLCdTUF8wNDUnLCdTUF8wNDYnLCdTUF8wNDcnLCdTUF8wNDgnLCdTUF8wNDknLCdTUF8wNTAnLCdTUF8wNTEnLCdTUF8wNTInLCdTUF8wNTMnLCdTUF8wNTQnLCdTUF8wNTUnLCdTUF8wNTYnLCdTUF8wNTcnLCdTUF8wNTgnLCdTUF8wNTknLCdTUF8wNjAnLCdTUF8wNjEnLCdUWVNfMDEnLCcwMScsJ0NOMDAxXzAxJywnQ04wMDJfMDEnLCdDTjAwM18wMScsJ0NOMDA0XzAxJywnQ04wMDVfMDEnLCdDTjAwNl8wMScsJ0N1c3RvbScsJ0RNXzAxJywnRkdfMDEnLCdGR18wMicsJ0ZPQycsJ0lDX09NTicsJ0lDX1RZUycsJ0lDX1VBRScsJ1BNXzAxJywnU01QXzAxJywnU1BfMDAxJywnU1BfMDAyJywnU1BfMDAzJywnU1BfMDA0JywnU1BfMDA1JywnU1BfMDA2JywnU1BfMDA3JywnU1BfMDA4JywnU1BfMDA5JywnU1BfMDEwJywnU1BfMDExJywnU1BfMDEyJywnU1BfMDEzJywnU1BfMDE1JywnU1BfMDE2JywnU1BfMDE3JywnU1BfMDE4JywnU1BfMDE5JywnU1BfMDIwJywnU1BfMDIxJywnU1BfMDIyJywnMDEnLCdBbWF6b24nLCdBVF8wMScsJ0JLXzAxJywnQlJBTkQnLCdDMDIwMjM1NicsJ0NOMDAxXzAxJywnQ04wMDJfMDEnLCdDTjAwM18wMScsJ0NOMDA0XzAxJywnQ04wMDVfMDEnLCdDTjAwNl8wMScsJ0NOMDA3XzAxJywnQ04wMDhfMDEnLCdDV19TTTAwMCcsJ0NXX1NNMDAxJywnQ1dfU00wMDInLCdDV19TTTAwMycsJ0NXX1NNMDA0JywnQ1dfU00wMDUnLCdDV19TTTAwNicsJ0NXX1NNMDA3JywnQ1dfU00wMDgnLCdDV19TTTAwOScsJ0NXX1NNMDEwJywnRE1fMDEnLCdETV8wMicsJ0RNXzAzJywnRE1fMDQnLCdETV8wNScsJ0RNXzA2JywnRUNfMDEnLCdGR18wMScsJ0ZPQycsJ0dGXzAxJywnSUNfQU1QJywnSUNfQkhSJywnSUNfS1NBJywnSUNfTW92JywnSUNfT01OJywnSUNfUUFUJywnSVQnLCdJVDAyJywnUEtfMDEnLCdQTV8wMScsJ1BNXzAyJywnUUNfMDEnLCdSJkQnLCdTS18wMScsJ1NMXzAxJywnU01QXzAxJywnU1BfMDAxJywnU1BfMDAyJywnU1BfMDAzJywnU1BfMDA0JywnU1BfMDA1JywnU1BfMDA2JywnU1BfMDA3JywnU1BfMDA4JywnU1BfMDA5JywnU1BfMDEwJywnU1BfMDExJywnU1BfMDEyJywnU1BfMDEzJywnU1BfMDE0JywnU1BfMDE1JywnU1BfMDE2JywnU1BfMDE3JywnU1BfMDE4JywnU1BfMDE5JywnU1BfMDIwJywnU1BfMDIxJywnU1BfMDIyJywnU1BfMDIzJywnU1BfMDI0JywnU1BfMDI1JywnU1BfMDI2JywnU1BfMDI3JywnU1BfMDI4JywnU1BfMDI5JywnU1BfMDMwJywnU1BfMDMxJywnU1BfMDMyJywnU1BfMDMyXzEnLCdTUF8wMzMnLCdTUF8wMzQnLCdTUF8wMzUnLCdTUF8wMzYnLCdTUF8wMzcnLCdTUF8wMzgnLCdTUF8wMzknLCdTUF8wNDAnLCdTUF8wNDEnLCdTUF8wNDInLCdTUF8wNDMnLCdTUF8wNDQnLCdTUF8wNDUnLCdTUF8wNDYnLCdTUF8wNDcnLCdTUF8wNDgnLCdTUF8wNDknLCdTUF8wNTAnLCdTUF8wNTEnLCdTUF8wNTInLCdTUF8wNTMnLCdTUF8wNTQnLCdTUF8wNTUnLCdTUF8wNTYnLCdTUF8wNTcnLCdTUF8wNTgnLCdTUF8wNTknLCdTUF8wNjAnLCdTUF8wNjEnLCdTUF8wNjInLCdTUF8wNjMnLCdTUF8wNjQnLCdTUF8wNjUnLCdTUF8wNjYnLCdTUF8wNjcnLCdTUF8wNjgnLCdTUF8wNjknLCdTUF8wNzAnLCdTUF8wNzEnLCdTUF8wNzInLCdTUF8wNzMnLCdTUF8wNzQnLCdTUF8wNzUnLCdTUF8wNzYnLCdTUF8wNzcnLCdTUF8wNzknLCdTUF8wODAnLCdTUF8wODEnLCdTUF8wODInLCdTUF8wODMnLCdTUF8wODQnLCdTUF8wODUnLCdTUF8wODYnLCdTUF8wODgnLCdTUF8wODknLCdTUF8wOTAnLCdTUF8wOTEnLCdTUF8wOTInLCdXSF8wMScsJ1dIXzAyJywnV0hfMDMnLCdXSF8wNCcsJ1dIXzA1JywnV0hfMDYnLCdXSF9EUk0nLCdXSF9WZW5kJyIsIlN0b3JlSUQiOiInJywnSE8nLCdPRkInLCdITycsJ0hPJywnUCZFJywnU01BJywnQktXJywnQkNDJywnQlNUJywnSERMJywnREFNJywnSklEJywnQlVLJywnUkFNJywnQ0NCJywnSE1UJywnTUhSJywnQU1CJywnQlNTJywnJywnSE8nLCdITycsJycsJ0pETycsJ01ETycsJ0hPJywnSE8nLCcnLCdITycsJ1AmRScsJ0tBUycsJ0tBU1MnLCdKUUInLCdEQVQnLCdEQVRTJywnTk9SJywnQVNNJywnVEJBJywnQVpNJywnQktSJywnU0tEJywnVEdNJywnT0JNJywnSlVNJywnUUJBJywnS09TJywnU1NKJywnTU9OJywnU0FGJywnUUJGJywnS01TJywnS01TUycsJ01BRycsJ1lSTScsJ01VRycsJ01SSicsJ1NRSicsJ01ESCcsJ01ERycsJ01DVCcsJ01DVFMnLCdWTUNUJywnUkhCJywnT0JIJywnQkFTJywnS1NWJywnJywnSE8nLCcnLCdITycsJ0hPJywnUCZFJywnS1NNJywnSlJLJywnS01BJywnS09EJywnR0FUJywnQkxWJywnTUdUJywnTUdDJywnJywnSE8nLCdITycsJ09GTycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdQJkUnLCdTTVQnLCdTS0snLCdTRUInLCdCUksnLCdTTEwnLCdTVVInLCdOSVonLCdTV1EnLCdTT00nLCdTQU0nLCdCUk0nLCdFQlInLCdTQlgnLCdCRFknLCdLQlInLCdBTVInLCdTTk0nLCdBVk0nLCdMV00nLCdKTE4nLCdBS00nLCdBS0InLCdNU04nLCdTTlcnLCdSU1QnLCdCUkEnLCdZQU4nLCdTTE4nLCdTTFUnLCdTQUQnLCdNT00nLCdRVVInLCdCSUQnLCdLQU0nLCdLVUQnLCdTTUwnLCdTTlMnLCdDQ00nLCdNT08nLCdDQ1MnLCdKTFMnLCdPQVMnLCdTU1MnLCdETksnLCdCSEwnLCdNQVQnLCdBTlMnLCdBU0snLCdLQlMnLCdTTVMnLCdGTEonLCdEUU0nLCdFQlMnLCdGQU4nLCdCRFMnLCdBTVMnLCdCREQnLCdPT1MnLCdUTUQnLCdTV1MnLCdNVVMnLCdITycsJycsJycsJycsJycsJycsJycsJycsJycsJycsJ09GUScsJ0hPJywnJywnSE8nLCdITycsJ0hPJywnUCZFJywnSE8nLCdBWlknLCdTSEYnLCdOU1InLCdESEYnLCdNUVInLCdBTUonLCdET00nLCdBTUsnLCdMQkInLCdBV1MnLCdNUksnLCdBRlMnLCdXQVEnLCdRT1MnLCdRUk4nLCdJR1cnLCdFWkQnLCdWSUwnLCdOQVMnLCdTSE4nLCdXQVQnLCcnLCdITycsJ0hPJywnSE8nLCcnLCcnLCcnLCcnLCcnLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0FFQycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ1AmRScsJ0hPJywnSE8nLCcnLCcnLCdITycsJ0hPJywnREZNJywnQlNNJywnQk5ZJywnQ1RNJywnRE1LJywnS0hMJywnQUpDJywnTVpNJywnQUZNJywnQUFNJywnQldNJywnQlNHJywnQlNYJywnQUdNJywnQUJNJywnQUJDJywnTUZDJywnRFJDJywnREFGJywnRkpNJywnQUtIJywnS0hLJywnTU5NJywnUkFLJywnU0hNJywnTVJEJywnU1JDJywnU0JTJywnU01NJywnTUFNJywnVUFRJywnSlJOJywnSlJNJywnU1FNJywnUk1aJywnQVNTJywnQkFSJywnS0hNJywnTU9RJywnRExNJywnQVlSJywnVUNKJywnQUdaJywnUkhNJywnVUNBJywnVUNCJywnRkNDJywnR0JWJywnRFJNJywnU0NIJywnSFRUJywnTVNGJywnSk1NJywnWkNDJywnR1lNJywnRkNNJywnTVNNJywnREhEJywnUklGJywnS0JNJywnSE1EJywnUldEJywnS1dTJywnQUFLJywnQlJTJywnRE9TJywnU0xNJywnREVSJywnU0NEJywnS0xGJywnU0JBJywnTURNJywnSlJGJywnTExaJywnRkpTJywnUkZNJywnRE1CJywnTVJCJywnREhNJywnSURXJywnSkNQJywnRFNTJywnTVNLJywnSE1BJywnRElCJywnRFNRJywnVU1CJywnQUtEJywnSFRTJywnWUFTJywnR0JJJywnSE8nLCdITycsJ0hPJywnSE8nLCdITycsJ0hPJywnRFdTJywnJyIsIlRlcm1pbmFsSUQiOiIiLCJzYWxlc1BlcnNvbklkIjoiIiwiem9uZUlkIjoiJyonIiwiZXhwIjoxNzczNTU5MjYyfQ.JZfGnaPSXmCanQfq3OWPRkYqqzy_rM9LLyLLiTLMFOo"
                // ]);

                // $response = curl_exec($ch);

                // if (curl_errno($ch)) {
                //     echo 'Error: ' . curl_error($ch);
                // }

                // curl_close($ch);
            }
            // die(';;;');

            if ($couponCode = $request->input('couponCode')) {
                Discount::getFacadeRoot()->afterOrderPlaced($couponCode, $request->input('customer_id') ? $request->input('customer_id') : $customer_id);
            }

            if($request->input('customer_id')) {
                $loggedInCustomer = Customer::where('id', $request->input('customer_id'))->first();
            } else {
                $loggedInCustomer = null;
            }

            // $invoice = Invoice::query()->create([
            //     'reference_type' => 'Botble\Ecommerce\Models\Order',
            //     'reference_id' => $order->id,
            //     'customer_name' => $loggedInCustomer ? $loggedInCustomer->name : $request->input('billingAddress.first_name').' '.$request->input('billingAddress.last_name'),
            //     'customer_email' => $loggedInCustomer ? $loggedInCustomer->email : $request->input('billingAddress.email'),
            //     'customer_phone' => $loggedInCustomer ? $loggedInCustomer->phone : $request->input('billingAddress.mobile'),
            //     'customer_address' => $request->input('billingAddress.area').' '.$request->input('billingAddress.building'),
            //     'sub_total' => $request->input('totalPrice') ? : 0,
            //     'tax_amount' => ($request->input('totalPrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100)) + ($request->input('shippingPrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100)) + ($request->input('servicePrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100)),
            //     'shipping_amount' => $request->input('shippingPrice') / (1 + ($request->input('vatTax') / 100)),
            //     'shipping_amount_vat' => $request->input('shippingPrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100),
            //     'service_amount' => $request->input('servicePrice') / (1 + ($request->input('vatTax') / 100)),
            //     'service_amount_vat' => $request->input('servicePrice') / (1 + ($request->input('vatTax') / 100)) * ($request->input('vatTax') / 100),
            //     'vat' => $request->input('vatTax'),
            //     'discount_amount' => $request->input('discount_amount') ? : 0,
            //     'shipping_method' => $request->input('shipping_method') ? : ShippingMethodEnum::DEFAULT,
            //     'coupon_code' => $request->input('couponCode'),
            //     'discount_description' => $request->input('discount_description'),
            //     'amount' => $request->input('finalPrice'),
            //     'payment_id' => $order->payment_id,
            //     'status' => $request->input('payment_status'),
            // ]);

            // foreach ($request->input('products') as $product) {
                
            //     $quantity = $product['quantity'] ? $product['quantity'] : 1;

            //     $exisProduct = Product::where('id', $product['product_id'])->first();

            //     $exisProduct->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $product['product_id'])->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

            //     $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $product['product_id'])->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();

            //     // Store in a temporary property or a new array
            //     $couponData = [];
            //     foreach ($coupons as $coupon) {
            //         $couponData[strtolower($coupon->code)] = [
            //             'code' => strtolower($coupon->code),
            //             'value' => $coupon->value,
            //             'start_date' => $coupon->start_date,
            //             'end_date' => $coupon->end_date,
            //         ];
            //     }

            //     $exisProduct->coupon = $couponData;

            //     if(!is_null($exisProduct->discount)) {
            //         $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
            //         $total_amount = $price * $quantity;
            //         $discount_percent = $exisProduct->discount->value;
            //         $discount_amount = ($total_amount / 100) * $discount_percent;
            //         $net_amount = $total_amount - $discount_amount;
            //         $tax_amount = ($net_amount / 100) * $request->input('vatTax');
            //         $gross_amount = $net_amount + $tax_amount;
            //         $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
            //         $orderProduct = [
            //             'invoice_id' => $invoice->id,
            //             'reference_type' => 'Botble\Ecommerce\Models\Product',
            //             'reference_id' => $exisProduct->id,
            //             'name' => $exisProduct->name,
            //             'description' => $exisProduct->description,
            //             'image' => $exisProduct->image,
            //             'qty' => $quantity,
            //             'price' => $price,
            //             'sub_total' => $total_amount,
            //             'discount_percent' => $discount_percent,
            //             'discount_amount' => $discount_amount,
            //             'net_amount' => $net_amount,
            //             'tax_amount' => $tax_amount,
            //             'gross_amount' => $gross_amount,
            //             'amount' => $gross_amount,
            //             'options' => json_encode($options),
            //         ];
            //     } elseif(!empty($product['coupon']) && !is_null($exisProduct->coupon) && !empty($exisProduct->coupon) && isset($exisProduct->coupon) && isset($exisProduct->coupon[strtolower($request->input('couponCode'))]) && $exisProduct->coupon[strtolower($request->input('couponCode'))]['code'] == strtolower($request->input('couponCode'))) {
            //         $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
            //         $total_amount = $price * $quantity;
            //         $discount_percent = $exisProduct->coupon[strtolower($request->input('couponCode'))]['value'];
            //         $discount_amount = ($total_amount / 100) * $discount_percent;
            //         $net_amount = $total_amount - $discount_amount;
            //         $tax_amount = ($net_amount / 100) * $request->input('vatTax');
            //         $gross_amount = $net_amount + $tax_amount;
            //         $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
            //         $orderProduct = [
            //             'invoice_id' => $invoice->id,
            //             'reference_type' => 'Botble\Ecommerce\Models\Product',
            //             'reference_id' => $exisProduct->id,
            //             'name' => $exisProduct->name,
            //             'description' => $exisProduct->description,
            //             'image' => $exisProduct->image,
            //             'qty' => $quantity,
            //             'price' => $price,
            //             'sub_total' => $total_amount,
            //             'discount_percent' => $discount_percent,
            //             'discount_amount' => $discount_amount,
            //             'net_amount' => $net_amount,
            //             'tax_amount' => $tax_amount,
            //             'gross_amount' => $gross_amount,
            //             'amount' => $gross_amount,
            //             'options' => json_encode($options),
            //         ];
            //     } elseif(!is_null($exisProduct->sale_price)) {
            //         $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
            //         $total_amount = $price * $quantity;
            //         $sale_price = $exisProduct->sale_price / (1 + ($request->input('vatTax') / 100));
            //         $discount_percent = 0;
            //         $discount_amount = $total_amount - ($sale_price * $quantity);
            //         $net_amount = $total_amount - $discount_amount;
            //         $tax_amount = ($net_amount / 100) * $request->input('vatTax');
            //         $gross_amount = $net_amount + $tax_amount;
            //         $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
            //         $orderProduct = [
            //              'invoice_id' => $invoice->id,
            //             'reference_type' => 'Botble\Ecommerce\Models\Product',
            //             'reference_id' => $exisProduct->id,
            //             'name' => $exisProduct->name,
            //             'description' => $exisProduct->description,
            //             'image' => $exisProduct->image,
            //             'qty' => $quantity,
            //             'price' => $price,
            //             'sub_total' => $total_amount,
            //             'discount_percent' => $discount_percent,
            //             'discount_amount' => $discount_amount,
            //             'net_amount' => $net_amount,
            //             'tax_amount' => $tax_amount,
            //             'gross_amount' => $gross_amount,
            //             'amount' => $gross_amount,
            //             'options' => json_encode($options),
            //         ];
            //     }
                // elseif(isset($product['is_gift']) && $product['is_gift'] == true) {
                //     $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
                //     $total_amount = 0.00;
                //     $discount_percent = 100;
                //     $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
                //     $net_amount = 0.00;
                //     $tax_amount = 0.00;
                //     $gross_amount = 0.00;
                //     $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
                //     $orderProduct = [
                //         'invoice_id' => $invoice->id,
                //         'reference_type' => 'Botble\Ecommerce\Models\Product',
                //         'reference_id' => $exisProduct->id,
                //         'name' => $exisProduct->name,
                //         'description' => $exisProduct->description,
                //         'image' => $exisProduct->image,
                //         'qty' => $quantity,
                //         'price' => $price,
                //         'sub_total' => $total_amount,
                //         'discount_percent' => $discount_percent,
                //         'discount_amount' => $discount_amount,
                //         'net_amount' => $net_amount,
                //         'tax_amount' => $tax_amount,
                //         'gross_amount' => $gross_amount,
                //         'amount' => $gross_amount,
                //         'options' => json_encode($options)
                //     ];
                // }
            //      else {
            //         $price = $exisProduct->price / (1 + ($request->input('vatTax') / 100));
            //         $total_amount = $price * $quantity;
            //         $discount_percent = 0;
            //         $discount_amount = 0.00;
            //         $net_amount = $total_amount - $discount_amount;
            //         $tax_amount = ($net_amount / 100) * $request->input('vatTax');
            //         $gross_amount = $net_amount + $tax_amount;
            //         $options = array('name' => $exisProduct->name, 'image' => $exisProduct->image, 'attributes' => ' ', 'taxRate' => $exisProduct->percentage, 'options' => [], 'extras' => [], 'sku' => $exisProduct->sku, 'weight' => $exisProduct->weight, 'original_price' => $exisProduct->price, 'product_type' => $exisProduct->product_type);
                
            //         $orderProduct = [
            //             'invoice_id' => $invoice->id,
            //             'reference_type' => 'Botble\Ecommerce\Models\Product',
            //             'reference_id' => $exisProduct->id,
            //             'name' => $exisProduct->name,
            //             'description' => $exisProduct->description,
            //             'image' => $exisProduct->image,
            //             'qty' => $quantity,
            //             'price' => $price,
            //             'sub_total' => $total_amount,
            //             'discount_percent' => $discount_percent,
            //             'discount_amount' => $discount_amount,
            //             'net_amount' => $net_amount,
            //             'tax_amount' => $tax_amount,
            //             'gross_amount' => $gross_amount,
            //             'amount' => $gross_amount,
            //             'options' => json_encode($options),
            //         ];
            //     }

            //     InvoiceItem::query()->create($orderProduct);
            // }

            // if($request->input('payment_method') == 'cybersourcee') {
            //     // $resp = $this->cyberSourcePayment($request, $data);
            //     // if($resp['redirect_url']) {
            //         $uid = uniqid();
            //         $signed_date_time = gmdate("Y-m-d\TH:i:s\Z");
            //         return response()->json([
            //             'message'          => 'Redirecting to Cybersource...',
            //             'order_id'         => $order->code,
            //             'payment_method'   => $request->input('payment_method'),
            //             'total'            => $order->amount,
            //             'sub_total'        => $order->sub_total,
            //             'shipping_amount'  => $order->shipping_amount,
            //             // 'products'         => $prod,
            //             'redirect_url'     => 'https://secureacceptance.cybersource.com/pay',
            //             'transaction_type' => 'sale',
            //             'currency' => 'QAR',
            //             'access_key' => 'a11aaba1a8093442a3588c4b366f92da',
            //             'profile_id' => 'B2AE0C36-2483-4E54-BFC1-BD54754AC559',
            //             'transaction_uuid' => $uid,
            //             'signed_field_names' => 'access_key,profile_id,transaction_uuid,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,amount,currency,bill_to_forename,bill_to_surname,bill_to_email,bill_to_phone,bill_to_address_line1,bill_to_address_city,bill_to_address_state,bill_to_address_country,ship_to_forename,ship_to_surname,ship_to_email,ship_to_phone,ship_to_address_line1,ship_to_address_city,ship_to_address_state,ship_to_address_country',
            //             'unsigned_field_names' => '',
            //             'signed_date_time' => $signed_date_time,
            //             'locale' => 'en',
            //             'bill_to_forename' => '',
            //             'bill_to_surname' => '',
            //             'bill_to_email' => '',
            //             'bill_to_phone' => '',
            //             'bill_to_address_line1'    => '',
            //             'bill_to_address_city'   => '',
            //             'bill_to_address_state'  => '',
            //             'bill_to_address_country' => 'QA',
            //             'ship_to_forename' => '',
            //             'ship_to_surname' => '',
            //             'ship_to_email' => '',
            //             'ship_to_phone' => '',
            //             'ship_to_address_line1'    => '',
            //             'ship_to_address_city'   => '',
            //             'ship_to_address_state'  => '',
            //             'ship_to_address_country' => 'QA',
            //             'signature' => $this->sign([
            //                 'access_key' => 'a11aaba1a8093442a3588c4b366f92da',
            //                 'profile_id' => 'B2AE0C36-2483-4E54-BFC1-BD54754AC559',
            //                 'transaction_uuid' => $uid,
            //                 'signed_field_names' => 'access_key,profile_id,transaction_uuid,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,amount,currency,bill_to_forename,bill_to_surname,bill_to_email,bill_to_phone,bill_to_address_line1,bill_to_address_city,bill_to_address_state,bill_to_address_country,ship_to_forename,ship_to_surname,ship_to_email,ship_to_phone,ship_to_address_line1,ship_to_address_city,ship_to_address_state,ship_to_address_country',
            //                 'unsigned_field_names' => '',
            //                 'signed_date_time' => $signed_date_time,
            //                 'locale' => 'en',
            //                 'transaction_type' => 'sale',
            //                 'reference_number' => $order->code,
            //                 'amount' => $order->amount,
            //                 'currency' => 'QAR',
            //                 'bill_to_forename' => '',
            //                 'bill_to_surname' => '',
            //                 'bill_to_email' => '',
            //                 'bill_to_phone' => '',
            //                 'bill_to_address_line1'    => '',
            //                 'bill_to_address_city'   => '',
            //                 'bill_to_address_state'  => '',
            //                 'bill_to_address_country' => 'QA',
            //                 'ship_to_forename' => '',
            //                 'ship_to_surname' => '',
            //                 'ship_to_email' => '',
            //                 'ship_to_phone' => '',
            //                 'ship_to_address_line1'    => '',
            //                 'ship_to_address_city'   => '',
            //                 'ship_to_address_state'  => '',
            //                 'ship_to_address_country' => 'QA',
            //                 'submit' => 'Submit'
            //             ])
            //         ]);
            //     // }
            //     // $payment_data = [
            //     //     'order_id'         => $order->code,
            //     //     // 'payment_method'   => $request->input('payment_method'),
            //     //     'total'            => $order->amount,
            //     //     // 'sub_total'        => $order->sub_total,
            //     //     // 'shipping_amount'  => $order->shipping_amount,
            //     //     // 'redirect_url'     => 'https://secureacceptance.cybersource.com/pay',
            //     //     // 'transaction_type' => 'sale',
            //     //     // 'currency' => 'QAR',
            //     //     'access_key' => 'a11aaba1a8093442a3588c4b366f92da',
            //     //     'profile_id' => 'B2AE0C36-2483-4E54-BFC1-BD54754AC559',
            //     //     'transaction_uuid' => uniqid(),
            //     //     'signed_field_names' => 'access_key,profile_id,transaction_uuid,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,amount,currency,bill_to_forename,bill_to_surname,bill_to_email,bill_to_phone,bill_to_address_line1,bill_to_address_city,bill_to_address_state,bill_to_address_country,ship_to_forename,ship_to_surname,ship_to_email,ship_to_phone,ship_to_address_line1,ship_to_address_city,ship_to_address_state,ship_to_address_country',
            //     //     'unsigned_field_names' => '',
            //     //     'signed_date_time' => gmdate("Y-m-d\TH:i:s\Z"),
            //     //     'locale' => 'en',
            //     //     'bill_to_forename' => $request->input('billingAddress.first_name'),
            //     //     'bill_to_surname' => $request->input('billingAddress.last_name'),
            //     //     'bill_to_email' => $request->input('billingAddress.email'),
            //     //     'bill_to_phone' => $request->input('billingAddress.mobile'),
            //     //     'bill_to_address_line1'    => $request->input('billingAddress.area').' '.$request->input('billingAddress.building'),
            //     //     'bill_to_address_city'   => $request->input('billingAddress.city'),
            //     //     'bill_to_address_state'  => $request->input('billingAddress.city'),
            //     //     'bill_to_address_country' => 'QA',
            //     //     'ship_to_forename' => $data['name'],
            //     //     'ship_to_surname' => $data['name'],
            //     //     'ship_to_email' => $data['email'],
            //     //     'ship_to_phone' => $data['phone'],
            //     //     'ship_to_address_line1'    => $data['street1'],
            //     //     'ship_to_address_city'   => $data['city'],
            //     //     'ship_to_address_state'  => $data['state'],
            //     //     'ship_to_address_country' => 'QA',
            //     // ];
            //     // return view('qa_payment_form', $payment_data);
            // }

            // $request['payment_status'] = 'completed';
            $createPaymentForOrderService->execute(
                $order,
                $request->input('payment_method'),
                $request->input('payment_method') == 'cybersource' ? $request['status'] : 'completed',
                $customer_id,
                isset($request['paymentId']) ? $request['paymentId'] : null,
                isset($request['message']) ? $request['message'] : null
            );

            return response()->json([
                'message'          => 'Order created successfully',
                'order_id'         => $order->code,
                'payment_method'   => $request->input('payment_method'),
                'total'            => $order->amount,
                'sub_total'        => $order->sub_total,
                'shipping_amount'  => $order->shipping_amount,
                'products'         => $prod
            ]);
        }
    }

    // public function sign ($params) {
    //     // echo $params['profile_id'];
    //     return $this->signData($this->buildDataToSign($params), '32bc90216e4148a3b0b78a40c002875e95df9564d4124cb89e45c5818995ebd85a696b6eed15414e9d19fcf144fde755d8f8b7adf0534729aacaaf7b91036e3fafc19321a81144e78b12f02ca8fde018ca2a0025261742ccba9905333169e8be2f8f233f39c54527a55492bc09b72a5d7a754ceb23fa4b2d962b07d6130a3f20');
    // }

    // public function signData($data, $secretKey) {
    //     // echo "<pre>";print_r($data);
    //     return base64_encode(hash_hmac('sha256', $data, $secretKey, true));
    // }

    // public function buildDataToSign($params) {
    //     $signedFieldNames = explode(",", $params["signed_field_names"]);
    //     foreach ($signedFieldNames as $field) {
    //         $dataToSign[] = $field . "=" . $params[$field];
    //     }
    //     // echo "<pre>";print_r($dataToSign);
    //     return $this->commaSeparate($dataToSign);
    // }



    // public function commaSeparate ($dataToSign) {
    //     return implode(",", $dataToSign);
    // }

    // public function cyberSourcePayment(Request $request, $shippingData) {
    //     $paymentStr = '';
    //     foreach ($request->input('products') as $product) {
    //         $quantity = $product['quantity'] ? $product['quantity'] : 1;
    //         $exisProduct = Product::select('name')->where('ec_products.id', $product['product_id'])->first();
    //         $paymentStr .= $exisProduct->name. ' ('.$quantity.'), ';
    //     }

    //     $data = [
    //         "tran_type"=> "sale",
    //         "tran_class"=> "ecom",
    //         "cart_id"=> (string)rand(11111, 99999),
    //         "cart_currency"=> "QAR",
    //         "cart_amount"=> $request->input('finalPrice'),
    //         "cart_description"=> $paymentStr,
    //         "paypage_lang"=> "en",
    //         "customer_details"=> [
    //             "name"=> $request->input('billingAddress.first_name').' '.$request->input('billingAddress.last_name'),
    //             "email"=> $request->input('billingAddress.email'),
    //             "phone"=> $request->input('billingAddress.mobile'),
    //             "street1"=> $request->input('billingAddress.area').' '.$request->input('billingAddress.building'),
    //             "city"=> $request->input('billingAddress.city'),
    //             "state"=> $request->input('billingAddress.city'),
    //             "country"=> "QA",
    //             // "zip"=> "12345"
    //         ],
    //         "shipping_details"=> [
    //             "name"=> $shippingData['name'],
    //             "email"=> $shippingData['email'],
    //             "phone"=> $shippingData['phone'],
    //             "street1"=> $shippingData['street1'],
    //             "city"=> $shippingData['city'],
    //             "state"=> $shippingData['state'],
    //             "country"=> "QA",
    //             // "zip"=> "54321"
    //         ],
    //         // "callback"=> "https://phpstack-1403159-5212295.cloudwaysapps.com/public/api/payTabsPaymentRedirect",
    //         // "return"=> "https://phpstack-1403159-5212295.cloudwaysapps.com/public/api/payTabsPaymentRedirect"
    //         "callback"=> "https://admin.ahmedalmaghribi.qa/public/api/payTabsPaymentRedirect",
    //         "return"=> "https://admin.ahmedalmaghribi.qa/public/api/payTabsPaymentRedirect"
    //     ];

    //     // $PROFILE_ID = 48012;
    //     $PROFILE_ID = 48353;
    //     // $SERVER_KEY = 'SBJNLMDM92-HZKWN6WW6D-NTDHZ9RBMJ';
    //     $SERVER_KEY = 'S6JNLMDMDL-HZM2DZDHLN-GW2NZ6DKK2';

    //     $BASE_URL = 'https://secure.paytabs.com/payment/request';

    //     $data['profile_id'] = $PROFILE_ID;
    //     $curl = curl_init();
    //     curl_setopt_array($curl, array(
    //         CURLOPT_URL => $BASE_URL,
    //         CURLOPT_RETURNTRANSFER => true,
    //         CURLOPT_ENCODING => '',
    //         CURLOPT_MAXREDIRS => 10,
    //         CURLOPT_TIMEOUT => 0,
    //         CURLOPT_CUSTOMREQUEST => 'POST',
    //         CURLOPT_POSTFIELDS => json_encode($data, true),
    //         CURLOPT_HTTPHEADER => array(
    //             'authorization:' . $SERVER_KEY,
    //             'Content-Type:application/json'
    //         ),
    //     ));

    //     $response = json_decode(curl_exec($curl), true);
    //     curl_close($curl);
    //     // print_r($response);
    //     return $response;
    // }

    // public function cyberSourcePaymentRedirect(Request $request, CreatePaymentForOrderService $createPaymentForOrderService) {
    //     // echo "<pre>";print_r($request->all());die;
    //     // $customer = Customer::where('code', $request->input('req_reference_number'))->first();
    //     $order = Order::where('code', $request->input('req_reference_number'))
    //     // ->orderBy('id', 'desc')
    //     ->first();
    //     // echo "<pre>";print_r($order);
    //     $createPaymentForOrderService->execute(
    //         $order,
    //         'cybersource',
    //         $request['decision'],
    //         $order->user_id,
    //         isset($request['transaction_id']) ? $request['transaction_id'] : $request['req_transaction_uuid'],
    //         $request['message'],
    //     );

    //     header('Location: http://localhost:3000/'.$order->lang.'/shop-order-payment-complete?q='.base64_encode($order->code));exit();
    // }

    public function trackOrder(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_number'      => 'required',
            'billing_email'      => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        $order = Order::select('ec_orders.id', 'ec_orders.code', 'ec_orders.status', 'ec_orders.amount', 'ec_orders.sub_total', 'ec_orders.shipping_amount', 'payments.payment_channel', 'ec_orders.created_at', 'ec_orders.service_amount', 'ec_orders.vat', 'ec_orders.tax_amount', 'payments.status AS payment_status')->join('ec_order_addresses', 'ec_order_addresses.order_id', 'ec_orders.id')->join('payments', 'payments.order_id', 'ec_orders.id')->where('ec_orders.code', $request->input('order_number'))->where('ec_order_addresses.email', $request->input('billing_email'))->first();

        if(!$order) {
            return response()->json(['message' => 'Order not found']);
        }

        $prod = OrderProduct::where('ec_order_product.order_id', $order->id)->get();

        return response()->json([
            'message'          => 'Tracking Details Fetched successfully',
            'order_id'         => $order->code,
            'payment_method'   => $order->payment_channel,
            'total'            => $order->amount,
            'sub_total'        => $order->sub_total,
            'shipping_amount'  => $order->shipping_amount,
            'status'           => $order->status,
            'created_at'       => $order->created_at,
            'service_amount'   => $order->service_amount,
            'vat_amount'       => $order->vat,
            'tax_amount'       => $order->tax_amount,
            'payment_status'   => $order->payment_status,
            'products'         => $prod
        ]);
    }

    public function orderDetails(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_number'      => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        $order = Order::select('ec_orders.id', 'ec_orders.code', 'ec_orders.status', 'ec_orders.amount', 'ec_orders.sub_total', 'ec_orders.shipping_amount', 'payments.payment_channel', 'ec_orders.created_at', 'ec_orders.service_amount', 'ec_orders.vat', 'ec_orders.tax_amount', 'payments.status AS payment_status')->join('ec_order_addresses', 'ec_order_addresses.order_id', 'ec_orders.id', 'left')->join('payments', 'payments.order_id', 'ec_orders.id', 'left')->where('ec_orders.code', $request->input('order_number'))->first();

        if(!$order) {
            return response()->json(['message' => 'Order not found']);
        }

        $prod = OrderProduct::where('ec_order_product.order_id', $order->id)->get();

        return response()->json([
            'message'          => 'Details Fetched successfully',
            'order_id'         => $order->code,
            'payment_method'   => $order->payment_channel,
            'total'            => $order->amount,
            'sub_total'        => $order->sub_total,
            'shipping_amount'  => $order->shipping_amount,
            'status'           => $order->status,
            'created_at'       => $order->created_at,
            'service_amount'   => $order->service_amount,
            'vat_amount'       => $order->vat,
            'tax_amount'       => $order->tax_amount,
            'payment_status'   => $order->payment_status,
            'products'         => $prod
        ]);
    }

    public function validateCoupon(Request $request) {
         $validator = Validator::make($request->all(), [
            'couponCode'      => 'required',
            'mobile_number' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        $coupon = DiscountModel::where('code', $request->input('couponCode'))->where('start_date', '<=', now())->where('end_date', '>=', now())->first();

        if(!$coupon) {
            return response()->json(['message' => 'Invalid Coupon Code']);
        }

        // $mobile_verification = MobileVerification::where('phone', $request->input('mobile_number'))->first();

        // if(!$mobile_verification) {
        //     return response()->json(['message' => 'Verify Mobile Number First']);
        // }

        $order_address = OrderAddress::join('payments', 'payments.order_id', '=', 'ec_order_addresses.order_id')->where('status', 'completed')->where('phone', $request->input('mobile_number'))->get();

        // echo "<pre>";print_r($order_address);die;

        if(!$order_address->isEmpty()) {
            // $order = Order::where('id', $order_address->order_id)->first();
            // if($order) {
                $customer_discount = DB::table('ec_customer_used_coupons')->where('customer_id', $order_address[0]->customer_id)->where('discount_id', $coupon->id)->first();
                if($customer_discount) {
                    return response()->json(['message' => 'You Have Already Used this Coupon Code']);
                }
            // }
        }

        return response()->json([
            'message'          => 'Details Fetched successfully',
            'coupon'            => $coupon
        ]);
    }

    function GenerateUnifiedCheckoutCaptureContext(Request $request)
    {
        // echo "<pre>";print_r($request->all());die;
        $targetOrigins = array();
        $targetOrigins[0] = "https://658kq4qh-3000.inc1.devtunnels.ms";

        $allowedCardNetworks = array();
        $allowedCardNetworks[0] = "VISA";
        $allowedCardNetworks[1] = "MASTERCARD";

        $allowedPaymentTypes = array();
        $allowedPaymentTypes[0] = "CLICKTOPAY";
        
        $captureMandateShipToCountries = array();
        $captureMandateShipToCountries[0] = "QA";
        
        $captureMandateArr = [
            "billingType" => "FULL",
            "requestEmail" => true,
            "requestPhone" => true,
            "requestShipping" => true,
            "shipToCountries" => $captureMandateShipToCountries,
            "showAcceptedNetworkIcons" => true
        ];
        $captureMandate = new \CyberSource\Model\Upv1capturecontextsCaptureMandate($captureMandateArr);

        $completeMandate = [
            "type" => "CAPTURE",
            "decisionManager" => false,
            "consumerAuthentication" => true
        ];
        $completeMandate = new \CyberSource\Model\Upv1capturecontextsCompleteMandate($completeMandate);

        $orderInformationAmountDetailsArr = [
            "totalAmount" => $request['amountDetails']['totalAmount'],
            "currency" => "QAR"
        ];
        $orderInformationAmountDetails = new \CyberSource\Model\Upv1capturecontextsOrderInformationAmountDetails($orderInformationAmountDetailsArr);

        $orderInformationBillToArr = [
            "address1" => $request['billTo']['address1'],
            "buildingNumber" => $request['billTo']['buildingNumber'],
            "country" => "QA",
            "district" => $request['billTo']['district'],
            "locality" => $request['billTo']['locality'],
            "postalCode" => "0000",
            "administrativeArea" => "Ajman",
            "email" => $request['billTo']['email'],
            "firstName" => $request['billTo']['firstName'],
            "lastName" => $request['billTo']['lastName'],
            "phoneNumber" => $request['billTo']['phoneNumber'],
            "phoneType" => "mobile",
        ];
        $orderInformationBillTo = new \CyberSource\Model\Upv1capturecontextsOrderInformationBillTo($orderInformationBillToArr);

        $orderInformationShipToArr = [
            "address1" => $request['shipTo']['address1'],
            "buildingNumber" => $request['shipTo']['buildingNumber'],
            "country" => "QA",
            "district" => $request['shipTo']['district'],
            "locality" => $request['shipTo']['locality'],
            "postalCode" => "0000",
            "administrativeArea" => "Ajman",
            "firstName" => $request['shipTo']['firstName'],
            "lastName" => $request['shipTo']['lastName'],
        ];
        $orderInformationShipTo = new \CyberSource\Model\Upv1capturecontextsOrderInformationShipTo($orderInformationShipToArr);

        $orderInformationArr = [
            "amountDetails" => $orderInformationAmountDetails,
            "billTo" => $orderInformationBillTo,
            "shipTo" => $orderInformationShipTo
        ];
        $orderInformation = new \CyberSource\Model\Upv1capturecontextsOrderInformation($orderInformationArr);

        $requestObjArr = [
            "clientVersion" => "0.26",
            "targetOrigins" => $targetOrigins,
            "allowedCardNetworks" => $allowedCardNetworks,
            "allowedPaymentTypes" => $allowedPaymentTypes,
            "country" => "QA",
            "locale" => "en_US",
            "captureMandate" => $captureMandate,
            "completeMandate" => $completeMandate,
            "orderInformation" => $orderInformation
        ];
        $requestObj = new \CyberSource\Model\GenerateUnifiedCheckoutCaptureContextRequest($requestObjArr);


        $commonElement = new \App\Services\ExternalConfiguration();
        $config = $commonElement->ConnectionHost();
        $merchantConfig = $commonElement->merchantConfigObject();

        $apiClient = new \CyberSource\ApiClient($config, $merchantConfig);
        $apiInstance = new \CyberSource\Api\UnifiedCheckoutCaptureContextApi($apiClient);

        try {
            $apiResponse = $apiInstance->generateUnifiedCheckoutCaptureContext($requestObj);
            // print_r(PHP_EOL);
            // print_r($apiResponse);
            return response()->json([
                'message'          => 'Details Fetched successfully',
                'data'            => $apiResponse
            ]);

            // return $apiResponse;
        } catch (\Cybersource\ApiException $e) {
            // print_r($e->getResponseBody());
            // print_r($e->getMessage());
            return response()->json([
                'message'          => $e->getMessage(),
                'data'            => $e->getResponseBody()
            ]);
        }
    }
}
