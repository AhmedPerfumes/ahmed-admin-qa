@extends($layout ?? BaseHelper::getAdminMasterLayoutTemplate())
@section('content')
    <form action='{{ route('smsa.bulk-submit') }}' style="width:100%" method="post">
        @csrf
        @php $ids = explode(',', $ids); @endphp
        @foreach($ids as $k => $id)
            @php
                $order = Botble\Ecommerce\Models\Order::select('ec_orders.code', 'ec_orders.amount', 'ec_order_addresses.name', 'ec_order_addresses.phone', 'ec_order_addresses.address', 'ec_order_addresses.state', 'ec_order_addresses.city', 'payments.payment_channel as payment_method', 'ec_order_addresses.awb as awb')
                    ->leftJoin('ec_order_addresses', 'ec_orders.id', '=', 'ec_order_addresses.order_id')
                    ->leftJoin('payments', 'payments.order_id', '=', 'ec_orders.id')
                    ->where('ec_orders.id', $id)
                    ->first();
                $products = Botble\Ecommerce\Models\OrderProduct::select('ec_order_product.options', 'ec_order_product.qty')->where('order_id', $id)->get();
                $declared_value = ($order->amount - 20) - 19;
                // echo "<pre>";print_r($products);
                $prod_str = '';
                foreach ($products as $key => $value) {
                    $options = $value->options;
                    $decoded_opt = json_decode($options, true);
                    $prod_str .= $decoded_opt['name'] . " ( SKU: " . $decoded_opt['sku'] . ", Qty: " . $value['qty'] . " ), ";
                }
            @endphp
            @if(empty($order->awb))
                <div class="alert alert-secondary text-center">
                    <h3>DELIVERY ADDRESS</h3>
                    <h3>عنوان التوصيل</h3>
                    <h3>Order {{ $order->code }}</h3>
                </div>

                <input type="hidden" name="order_id[]" value="{{ $id }}">
                <input type="hidden" name="order_number[]" value="{{ $order->code }}">
                <input type="hidden" name="reference[]" value="Ref_{{ explode('#', $order->code)[1] }}">
                {{-- <input type="hidden" name="currency[]" value="AED"> --}}
                <div class="row">
                    <div class="col">
                        <label>Name</label>
                        <input type="text" class="form-control" name="name[]" value="{{ $order->name }}" required="">
                    </div>
                    <div class="col">
                        <label>Phone</label>
                        <input type="text" class="form-control" name="phone[]" value="{{ $order->phone }}" required="">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label>Address</label>
                        <input type="text" class="form-control" name="address[]" value="{{ $order->address }}" required="">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label>State</label>
                        <input type="text" class="form-control" name="state[]" value="{{ $order->state }}" required="">
                    </div>
                    <div class="col">
                        <label>City</label>
                        <input type="text" class="form-control" name="city[]" value="{{ $order->city }}" required="">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label>Country Code</label>
                        <input type="text" class="form-control" name="country_code[]" value="AE" required="">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label class="pb-text">Currency</label>
                        <select class="form-control" name="currency[]">
                            <option value="AED">AED</option>
                        </select>
                    </div>
                    <div class="col">
                        <label class="pb-text">Customs Declared Value (AED)</label>
                        <input type="text" class="form-control" name="declared_value[]" value="{{ $declared_value }}" required="">
                    </div>
                    <div class="col">
                        <label class="pb-text">Total Cash on Delivery (AED)</label>
                        <input type="text" class="form-control" name="amount[]" value="{{ $order->payment_method == 'cod' ? $order->amount : 0 }}" required="">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label>Weight(KG)</label>
                        <input type="text" class="form-control" name="weight[]" value="0">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label>Products Description</label>
                        <input type="text" class="form-control" name="products[]" value="{{ $prod_str }}" required="">
                    </div>
                </div>

                <div id="conditional-dropdowns">
                    <div class="row">
                        <div class="col-md-4">
                            <label>Vat Payment</label>
                            <select class="form-control" name="vat_paid[]">
                                <option value="false">Bill Consignee</option>
                                <option value="true">Bill Shipper</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label>Duty Payment</label>
                            <select class="form-control" name="duty_paid[]">
                                <option value="false">Bill Consignee</option>
                                <option value="true">Bill Shipper</option>
                            </select>
                        </div>
                    </div>
                </div><br>
                @endif
        @endforeach
        <hr>
        <button type="submit" class="smsa_action">Create Shipment</button>
    </form>
@endsection