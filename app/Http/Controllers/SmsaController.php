<?php

namespace App\Http\Controllers;

use Botble\Ecommerce\Models\Order;
use Botble\Ecommerce\Models\OrderProduct;
use Botble\Ecommerce\Models\OrderAddress;
use Botble\Ecommerce\Models\StoreLocator;
use Yajra\DataTables\DataTables;
use Illuminate\Http\Request;

class SmsaController extends Controller
{
    public function index()
    {
        return view('smsa');
    }

    public function getData()
    {
        // echo Order::select(['ec_orders.id as id', 'ec_orders.status as statuss', 'ec_orders.code as code', 'ec_customers.name as customer_name', 'ec_orders.created_at as created_at'])->leftJoin('ec_customers', 'ec_customers.id', '=', 'ec_orders.user_id')->orderBy('ec_orders.created_at', 'DESC')->toSql();
        $orders = Order::select(['ec_orders.id as id', 'ec_orders.status as statuss', 'ec_orders.amount as amount', 'ec_order_addresses.awb as awb', 'ec_orders.code as code', 'ec_order_addresses.name as customer_name', 'ec_orders.created_at as created_at', 'payments.payment_channel as payment_method'])
        ->leftJoin('ec_customers', 'ec_customers.id', '=', 'ec_orders.user_id')
        ->leftJoin('ec_order_addresses', 'ec_order_addresses.order_id', '=', 'ec_orders.id')
        ->leftJoin('payments', 'payments.order_id', '=', 'ec_orders.id')
        ->orderBy('ec_orders.created_at', 'DESC')
        ->get();
        // echo $orders;die;
        return DataTables::of($orders)
            ->editColumn('created_at', function ($row) {
                return \Carbon\Carbon::parse($row->created_at)->format('d M, Y'); // Format the date
            })
            ->editColumn('amount', function ($row) {
                return $row->payment_method == 'cod' ? $row->amount : 0;
            })
            ->editColumn('awb', function ($row) {
                return $row->awb ? '<a href="'.route('smsa.track', $row->awb).'" ><i class="fa-solid fa-track"></i> '.$row->awb.'</a>' : '';
            })
            ->addColumn('action', function($row) {
                return !$row->awb ? '<a href="'.route('smsa.edit', $row->id).'" class="btn btn-sm btn-primary"><i class="fa-solid fa-truck-fast"></i> Ship</a>' : '';
            })
            ->addColumn('check', function($row) {
                return '<input type="checkbox" id="'.$row->id.'" value= "'.$row->awb.'" class="row-checkbox">';
            })
            ->rawColumns(['action', 'check', 'awb']) // Allow HTML in the action columns
            ->make(true);
    }

    public function edit(Request $request, $id)
    {
        $order = Order::select('ec_orders.code', 'ec_orders.amount', 'ec_order_addresses.name', 'ec_order_addresses.phone', 'ec_order_addresses.address', 'ec_order_addresses.state', 'ec_order_addresses.city', 'payments.payment_channel as payment_method')
                ->leftJoin('ec_order_addresses', 'ec_orders.id', '=', 'ec_order_addresses.order_id')
                ->leftJoin('payments', 'payments.order_id', '=', 'ec_orders.id')
                ->where('ec_orders.id', $id)
                ->first();
        $products = OrderProduct::select('ec_order_product.options', 'ec_order_product.qty')->where('order_id', $id)->get();
        return view('smsa_edit', compact('id', 'order', 'products'));
    }

    public function bulkEdit(Request $request)
    {
        $ids = $request['ids'];
        return view('smsa_bulk_edit', compact('ids'));
    }

    public function submit(Request $request)
    {

        $location = StoreLocator::select('name', 'phone', 'address', 'country', 'state', 'city')->first();

        $shipper_data = array(
            'ContactName' => $location->name,
            'ContactPhoneNumber' => $location->phone,
            'Coordinates' => '',
            'Country' => $location->country,
            'District' => $location->state,
            'PostalCode' =>'',
            'City' => $location->city,
            'AddressLine1' => $location->address,
            'AddressLine2' => ''
        );

        $consignee_data = array(
            'ContactName' => ucwords($request['name']),
            'ContactPhoneNumber' => $request['phone'],
            'ContactPhoneNumber2' => '',
            'Coordinates' => '',
            'Country' => $request['country_code'], 
            'District' => $request['state'],
            'PostalCode' => '',
            'City' => $request['city'],
            'AddressLine1' => $request['address'],
            'AddressLine2' => '',
            'ConsigneeID' => ''
        );

        $defaultServiceCode = ($location->country === $request['country_code']) ? 'EDDL' : 'EIDL';

        $shipment_data = array(
            'ConsigneeAddress' => $consignee_data,
            'ShipperAddress' => $shipper_data,
            'OrderNumber' => $request['reference'],
            'DeclaredValue' => (float)$request['declared_value'],
            'CODAmount' => (float)$request['amount'],
            'Parcels' => 1,
            'ShipDate' => date('Y-m-d\TH:i:s'),
            'ShipmentCurrency' => $request['currency'],
            'SMSARetailID' => '0',
            'WaybillType' => 'PDF',
            'Weight' => (float)$request['weight'],
            'WeightUnit' => 'KG',
            'ContentDescription' => $request['products'],
            'VatPaid' => $request['vat_paid'] === 'true',
            'DutyPaid' => $request['duty_paid'] === 'true',
            'ServiceCode' => $defaultServiceCode
        );

        // echo "<pre>";print_r($shipment_data);exit();

        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://ecomapis.smsaexpress.com/api/shipment/b2c/new',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode($shipment_data),
            CURLOPT_HTTPHEADER => array(
                'apikey: 3af56f2bd2304769814715a9ed9645fd',
                'Content-Type: application/json'
            ),
        ));

        $response = curl_exec($curl);
        curl_close($curl);

        $resp1 = json_decode($response);

        if (isset($resp1->sawb)) {
            OrderAddress::where('order_id', $request['order_id'])->update(['awb' => $resp1->sawb, 'name' => $request['name'], 'address' => $request['address'], 'customs_declared_value' => $request['declared_value'], 'total_cash_on_delivery' => $request['amount'], 'weight_kg' => $request['weight'], 'vat_payment' => $request['vat_paid'], 'duty_payment' => $request['duty_paid'], 'products' => $request['products']]);
            Order::where('id', $request['order_id'])->update(['status' => 'shipped']);
               

           return redirect('/admin/ecommerce/smsa');
            
        } elseif (isset($resp1->errors)) {
            foreach ($resp1->errors as $key => $value) {
                echo "<div class='alert alert-danger'>";
                echo "<strong>Error!!</strong> Error (" . $request['reference'] . '): ' . $key . ' - ' . $value[0] . '<br>';
                echo "</div>";
            }
        } else {
            echo "<div class='alert alert-danger'>";
            echo "<strong>Error!!</strong> Error: " . $response;
            echo "</div>";
        }
    }

    public function bulkSubmit(Request $request)
    {
        $location = StoreLocator::select('name', 'phone', 'address', 'country', 'state', 'city')->first();

        $shipper_data = array(
            'ContactName' => $location->name,
            'ContactPhoneNumber' => $location->phone,
            'Coordinates' => '',
            'Country' => $location->country,
            'District' => $location->state,
            'PostalCode' =>'',
            'City' => $location->city,
            'AddressLine1' => $location->address,
            'AddressLine2' => ''
        );
        for ($i=0; $i < count($request['order_id']); $i++) {
            $consignee_data = array(
                'ContactName' => ucwords($request['name'][$i]),
                'ContactPhoneNumber' => $request['phone'][$i],
                'ContactPhoneNumber2' => '',
                'Coordinates' => '',
                'Country' => $request['country_code'][$i], 
                'District' => $request['state'][$i],
                'PostalCode' => '',
                'City' => $request['city'][$i],
                'AddressLine1' => $request['address'][$i],
                'AddressLine2' => '',
                'ConsigneeID' => ''
            );

            $defaultServiceCode = ($location->country === $request['country_code'][$i]) ? 'EDDL' : 'EIDL';

            $shipment_data = array(
                'ConsigneeAddress' => $consignee_data,
                'ShipperAddress' => $shipper_data,
                'OrderNumber' => $request['reference'][$i],
                'DeclaredValue' => (float)$request['declared_value'][$i],
                'CODAmount' => (float)$request['amount'][$i],
                'Parcels' => 1,
                'ShipDate' => date('Y-m-d\TH:i:s'),
                'ShipmentCurrency' => $request['currency'][$i],
                'SMSARetailID' => '0',
                'WaybillType' => 'PDF',
                'Weight' => (float)$request['weight'][$i],
                'WeightUnit' => 'KG',
                'ContentDescription' => $request['products'][$i],
                'VatPaid' => $request['vat_paid'] === 'true',
                'DutyPaid' => $request['duty_paid'] === 'true',
                'ServiceCode' => $defaultServiceCode
            );

            // echo "<pre>";print_r($shipment_data);echo "<br>";
            // exit();

            $curl = curl_init();
            curl_setopt_array($curl, array(
                CURLOPT_URL => 'https://ecomapis.smsaexpress.com/api/shipment/b2c/new',
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_POSTFIELDS => json_encode($shipment_data),
                CURLOPT_HTTPHEADER => array(
                    'apikey: 3af56f2bd2304769814715a9ed9645fd',
                    'Content-Type: application/json'
                ),
            ));

            $response = curl_exec($curl);
            curl_close($curl);

            $resp1 = json_decode($response);

            if (isset($resp1->sawb)) {
                OrderAddress::where('order_id', $request['order_id'][$i])->update(['awb' => $resp1->sawb, 'name' => $request['name'][$i], 'address' => $request['address'][$i], 'customs_declared_value' => $request['declared_value'][$i], 'total_cash_on_delivery' => $request['amount'][$i], 'weight_kg' => $request['weight'][$i], 'vat_payment' => $request['vat_paid'][$i], 'duty_payment' => $request['duty_paid'][$i], 'products' => $request['products'][$i]]);
                Order::where('id', $request['order_id'][$i])->update(['status' => 'shipped']);
                

                echo "<div class='alert alert-success'>";
                echo "<strong>Well done!</strong> AWB number generated successfully for order " . $request['reference'][$i];
                echo "</div>";
                
            } elseif (isset($resp1->errors)) {
                foreach ($resp1->errors as $key => $value) {
                    echo "<div class='alert alert-danger'>";
                    echo "<strong>Error!!</strong> Error (" . $request['reference'][$i] . '): ' . $key . ' - ' . $value[0] . '<br>';
                    echo "</div>";
                }
            } else {
                echo "<div class='alert alert-danger'>";
                echo "<strong>Error!!</strong> Error: " . $response;
                echo "</div>";
            }
        }
        // die;
    }

    public function bulkPrint(Request $request)
    {
        $awbs = explode(',', $request['awbs']);
        $html = '<!DOCTYPE html>
        <html>
        <head>
            <title>AWB PDFs</title>
            <style>
                .pdf-container {
                    margin: 20px 0;
                    border: 1px solid #ccc;
                    padding: 10px;
                }
            </style>
        </head>
        <body>';
        foreach ($awbs as $key => $awb) {
            if(!empty($awb)) {
                $curl = curl_init();
                curl_setopt_array($curl, array(
                    CURLOPT_URL => 'https://ecomapis.smsaexpress.com/api/shipment/b2c/query/'.$awb,
                    CURLOPT_RETURNTRANSFER => true,
                    CURLOPT_HTTPHEADER => array(
                        'apikey: 3af56f2bd2304769814715a9ed9645fd',
                        'Content-Type: application/json'
                    ),
                ));

                $response = curl_exec($curl);
                curl_close($curl);

                $resp1 = json_decode($response);

                // echo "<pre>";print_r($resp1->waybills);die;

                if (isset($resp1->waybills) && count($resp1->waybills) > 0) {

                    $pdfData = base64_decode($resp1->waybills[0]->awbFile);

                    $pdfBase64 = base64_encode($pdfData);

                    $html .= '<div class="pdf-container">
                                <iframe src="data:application/pdf;base64,' . $pdfBase64 . '" width="100%" height="700px"></iframe>
                            </div>';
                } elseif (isset($resp1->errors)) {
                    foreach ($resp1->errors as $key => $value) {
                        echo "<div class='alert alert-danger'>";
                        echo "<strong>Error!!</strong> Error (" . $awb . '): ' . '<br>';
                        echo "</div>";
                    }
                } else {
                    echo "<div class='alert alert-danger'>";
                    echo "<strong>Error!!</strong> Error: " . $response;
                    echo "</div>";
                }
            }
        }
        $html .= '</body></html>';
        return response($html)->header('Content-Type', 'text/html');
    }

    public function track($awb)
    {
        if(!empty($awb)) {
            $curl = curl_init();
            curl_setopt_array($curl, array(
                CURLOPT_URL => 'https://ecomapis.smsaexpress.com/api/track/single/'.$awb,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_HTTPHEADER => array(
                    'apikey: 3af56f2bd2304769814715a9ed9645fd',
                    'Content-Type: application/json'
                ),
            ));

            $response = curl_exec($curl);
            curl_close($curl);

            $track = json_decode($response);

            // echo "<pre>";print_r($track);die;
        }
        return view('smsa_track', compact('track'));
    }
}