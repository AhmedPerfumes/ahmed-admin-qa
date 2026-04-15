@extends($layout ?? BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h1 class="h4 mb-0">{{ isset($promotion) ? 'Edit Promotion' : 'Create Promotion' }}</h1>
                    </div>
                    <div class="card-body">
                        <form id="promotionForm" action="{{ isset($promotion) ? route('promotions.update', $promotion->id) : route('promotions.store') }}" method="POST">
                            @csrf
                            @if (isset($promotion))
                                @method('PUT')
                            @endif

                            <div class="mb-3">
                                <label for="name" class="form-label">Promotion Name</label>
                                <input type="text" name="name" id="name" class="form-control" value="{{ old('name', isset($promotion) ? $promotion->name : '') }}" required>
                            </div>

                            <div class="mb-3">
                                <label for="type" class="form-label">Promotion Type</label>
                                <select name="type" id="type" onchange="toggleFields()" class="form-select" required {{ isset($promotion) ? 'disabled' : '' }}>
                                    <option value="">Select Type</option>
                                    <option value="buy_x_get_y" {{ isset($promotion) && $promotion->type === 'buy_x_get_y' ? 'selected' : '' }}>Buy X Get Y</option>
                                    <option value="discount" {{ isset($promotion) && $promotion->type === 'discount' ? 'selected' : '' }}>Discount</option>
                                    <option value="coupon" {{ isset($promotion) && $promotion->type === 'coupon' ? 'selected' : '' }}>Coupon</option>
                                    <option value="foc" {{ isset($promotion) && $promotion->type === 'foc' ? 'selected' : '' }}>Free of Charge</option>
                                     <option value="cashback" {{ isset($promotion) && $promotion->type === 'cashback' ? 'selected' : '' }}>Cashback</option>
                                </select>
                                @if (isset($promotion))
                                    <input type="hidden" name="type" value="{{ $promotion->type }}">
                                @endif
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea name="description" id="description" class="form-control">{{ old('description', isset($promotion) ? $promotion->description : '') }}</textarea>
                            </div>

                           <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="start_date" class="form-label">Start Date</label>
                                        <input type="date" name="start_date" id="start_date" class="form-control" 
                                            value="{{ old('start_date', isset($promotion) ? $promotion->start_date->format('Y-m-d') : '') }}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="start_time" class="form-label">Start Time <small class="text-muted">(Optional)</small></label>
                                        <input type="time" name="start_time" id="start_time" class="form-control" 
                                            value="{{ old('start_time', isset($promotion) ? $promotion->start_date->format('H:i') : '') }}">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="end_date" class="form-label">End Date</label>
                                        <input type="date" name="end_date" id="end_date" class="form-control" 
                                            value="{{ old('end_date', isset($promotion) ? $promotion->end_date->format('Y-m-d') : '') }}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="end_time" class="form-label">End Time <small class="text-muted">(Optional)</small></label>
                                        <input type="time" name="end_time" id="end_time" class="form-control" 
                                            value="{{ old('end_time', isset($promotion) ? $promotion->end_date->format('H:i') : '') }}">
                                    </div>
                                </div>
                            </div>

                            <!-- BOGO Fields -->
                            <!-- <div id="bogo_fields" style="display: {{ isset($promotion) && $promotion->type === 'bogo' ? 'block' : 'none' }};">
                                <div class="mb-3">
                                    <label for="bogo_product_ids" class="form-label">Buy Product</label>
                                    <select name="bogo_product_ids_temp" id="bogo_product_ids" class="form-select">
                                        @foreach ($products as $product)
                                            <option value="{{ $product['id'] }}"
                                                @if(in_array($product['id'], $discountedProductIds)) disabled @endif>
                                                {{ $product['name'] . (in_array($product['id'], $discountedProductIds) ? ' (already discounted)' : '') }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="bogo_free_product_ids" class="form-label">Free Product</label>
                                    <select name="bogo_free_product_ids_temp" id="bogo_free_product_ids" class="form-select">
                                        @foreach ($products as $product)
                                            <option value="{{ $product['id'] }}"
                                                @if(in_array($product['id'], $discountedProductIds)) disabled @endif>
                                                {{ $product['name'] . (in_array($product['id'], $discountedProductIds) ? ' (already discounted)' : '') }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <button type="button" id="add_bogo_rule" class="btn btn-success">Add More</button>
                                </div>
                                <div class="mb-3">
                                    <div class="row fw-bold border-bottom py-2">
                                        <div class="col">Buy Product</div>
                                        <div class="col">Free Product</div>
                                        <div class="col-2">Action</div>
                                    </div>
                                    <div id="bogo_rules_table">
                                        @if (isset($promotionData['bogo_rules']))
                                            @foreach ($promotionData['bogo_rules'] as $rule)
                                                <div class="row align-items-center border-bottom py-2">
                                                    <div class="col">
                                                        {{ $products[array_search($rule['buy_product_id'], array_column($products, 'id'))]['name'] }}
                                                    </div>
                                                    <div class="col">
                                                        {{ $products[array_search($rule['free_product_id'], array_column($products, 'id'))]['name'] }}
                                                    </div>
                                                    <div class="col-2">
                                                        <button type="button" onclick="this.parentElement.parentElement.remove()" class="btn btn-danger btn-sm">Remove</button>
                                                    </div>
                                                    <input type="hidden" name="conditions[bogo][product_ids][]" value="{{ $rule['buy_product_id'] }}">
                                                    <input type="hidden" name="rewards[bogo][free_product_ids][]" value="{{ $rule['free_product_id'] }}">
                                                </div>
                                            @endforeach
                                        @endif
                                    </div>
                                </div>
                            </div>  -->

                            <!-- Buy X Get Y Fields -->
                            <div id="buy_x_get_y_fields" style="display: {{ isset($promotion) && $promotion->type === 'buy_x_get_y' ? 'block' : 'none' }};">
                                <div class="mb-3">
                                    <label for="buy_quantity" class="form-label">Buy Quantity</label>
                                    <input type="number" name="conditions[buy_x_get_y][buy_quantity]" id="buy_quantity" class="form-control" value="{{ old('conditions.buy_x_get_y.buy_quantity', isset($promotionData['buy_x_get_y_rule']) ? $promotionData['buy_x_get_y_rule']->buy_quantity : '') }}">
                                </div>
                                <div class="mb-3">
                                    <label for="get_quantity" class="form-label">Get Quantity</label>
                                    <input type="number" name="rewards[buy_x_get_y][get_quantity]" id="get_quantity" class="form-control" value="{{ old('rewards.buy_x_get_y.get_quantity', isset($promotionData['buy_x_get_y_rule']) ? $promotionData['buy_x_get_y_rule']->get_quantity : '') }}">
                                </div>
                                <div class="mb-3">
                                    <label for="buy_x_product_ids" class="form-label">Products (Buy)</label>
                                    <select name="conditions[buy_x_get_y][product_ids][]" id="buy_x_product_ids" multiple class="form-select">
                                        @foreach ($products as $product)
                                            <option value="{{ $product['id'] }}"
                                                @if(isset($promotionData['buy_products']) && in_array($product['id'], $promotionData['buy_products'])) selected @endif
                                                @if(in_array($product['id'], $discountedProductIds))  @endif>
                                                {{ $product['name'] . (in_array($product['id'], $discountedProductIds) ? ' (already discounted)' : '') }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="get_y_product_ids" class="form-label">Free Products</label>
                                    <select name="rewards[buy_x_get_y][free_product_ids][]" id="get_y_product_ids" multiple class="form-select">
                                        @foreach ($products as $product)
                                            <option value="{{ $product['id'] }}"
                                                @if(isset($promotionData['free_products']) && in_array($product['id'], $promotionData['free_products'])) selected @endif
                                                @if(in_array($product['id'], $discountedProductIds))  @endif>
                                                {{ $product['name'] . (in_array($product['id'], $discountedProductIds) ? ' (already discounted)' : '') }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>

                            <!-- Discount Fields -->
                            <div id="discount_fields" style="display: {{ isset($promotion) && $promotion->type === 'discount' ? 'block' : 'none' }};">
                                <div class="mb-3">
                                    <label for="discount_apply_to" class="form-label">Apply Discount To</label>
                                    <select name="conditions[discount][apply_to]" id="discount_apply_to" class="form-select">
                                        <option value="all" {{ isset($promotionData['discount_rule']) && $promotionData['discount_rule']->apply_to === 'all' ? 'selected' : '' }}>All Products</option>
                                        <option value="individual" {{ isset($promotionData['discount_rule']) && $promotionData['discount_rule']->apply_to === 'individual' ? 'selected' : '' }}>Individual Product</option>
                                        <option value="group" {{ isset($promotionData['discount_rule']) && $promotionData['discount_rule']->apply_to === 'group' ? 'selected' : '' }}>Group Discount</option>
                                    </select>
                                </div>
                                <!-- All Products Discount -->
                                <div id="discount_all_products_field" style="display: {{ isset($promotionData['discount_rule']) && $promotionData['discount_rule']->apply_to === 'all' ? 'block' : 'none' }};">
                                    <div class="mb-3">
                                        <label for="discount_all" class="form-label">Discount Percent (All Products)</label>
                                        <input type="number" step="0.01" name="rewards[discount][percentage]" id="discount_all" class="form-control" value="{{ old('rewards.discount.percentage', isset($promotionData['discount_rule']) && $promotionData['discount_rule']->apply_to === 'all' ? $promotionData['discount_rule']->percentage : '') }}">
                                    </div>
                                </div>
                                <!-- Individual Product Discount -->
                                <div id="discount_individual_fields" style="display: {{ isset($promotionData['discount_rule']) && $promotionData['discount_rule']->apply_to === 'individual' ? 'block' : 'none' }};">
                                    <div class="mb-3">
                                        <label for="discount_product_ids" class="form-label">Product</label>
                                        <select name="discount_product_ids_temp" id="discount_product_ids" class="form-select">
                                            @foreach ($products as $product)
                                                <option value="{{ $product['id'] }}"
                                                    @if(in_array($product['id'], $discountedProductIds)) disabled @endif>
                                                    {{ $product['name'] . (in_array($product['id'], $discountedProductIds) ? ' (already discounted)' : '') }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discount_type_select" class="form-label">Discount Type</label>
                                        <select name="discount_type_temp" id="discount_type_select" class="form-select">
                                            <option value="percent">Percent</option>
                                            <option value="amount">Amount</option>
                                        </select>
                                    </div>
                                    <div id="discount_percent_fields" style="display: block;">
                                        <div class="mb-3">
                                            <label for="discount_percent" class="form-label">Discount Percentage</label>
                                            <input type="number" step="0.01" name="rewards[discount][percent_temp]" id="discount_percent" class="form-control">
                                        </div>
                                    </div>
                                    <div id="discount_amount_fields" style="display: none;">
                                        <div class="mb-3">
                                            <label for="discount_amount" class="form-label">Discount Amount</label>
                                            <input type="number" step="0.01" name="rewards[discount][amount_temp]" id="discount_amount" class="form-control">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discount_product_price" class="form-label">Product Price</label>
                                        <input type="number" step="0.01" id="discount_product_price" class="form-control" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discount_result" class="form-label">Discount Amount</label>
                                        <input type="number" step="0.01" id="discount_result" class="form-control" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discount_final_price" class="form-label">Final Price After Discount</label>
                                        <input type="number" step="0.01" id="discount_final_price" class="form-control" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <button type="button" id="add_discount_rule" class="btn btn-success">Add More</button>
                                    </div>
                                    <div class="mb-3">
                                        <div class="row fw-bold border-bottom py-2">
                                            <div class="col">Product(s)</div>
                                            <div class="col">Discount Type</div>
                                            <div class="col">Discount Value</div>
                                            <div class="col">Discount Amount</div>
                                            <div class="col">Final Price</div>
                                            <div class="col-2">Action</div>
                                        </div>
                                        <div id="discount_rules_table">
                                            @if (isset($promotionData['individual_rules']))
                                                @foreach ($promotionData['individual_rules'] as $rule)
                                                    <div class="row align-items-center border-bottom py-2">
                                                        <div class="col">
                                                            {{ $products[array_search($rule['product_id'], array_column($products, 'id'))]['name'] }}
                                                        </div>
                                                        <div class="col">{{ $rule['discount_type'] === 'percent' ? 'Percent' : 'Amount' }}</div>
                                                        <div class="col">{{ $rule['discount_type'] === 'percent' ? $rule['value'] . '%' : $rule['value'] }}</div>
                                                        <div class="col">{{ number_format($rule['discount_amount'], 2) }}</div>
                                                        <div class="col">{{ number_format($rule['final_price'], 2) }}</div>
                                                        <div class="col-2">
                                                            <button type="button" onclick="this.parentElement.parentElement.remove()" class="btn btn-danger btn-sm">Remove</button>
                                                        </div>
                                                        <input type="hidden" name="conditions[discount][product_ids][]" value="{{ $rule['product_id'] }}">
                                                        <input type="hidden" name="rewards[discount][discount_type][]" value="{{ $rule['discount_type'] }}">
                                                        <input type="hidden" name="rewards[discount][value][]" value="{{ $rule['value'] }}">
                                                        <input type="hidden" name="rewards[discount][product_price][]" value="{{ $rule['product_price'] }}">
                                                        <input type="hidden" name="rewards[discount][discount_amount][]" value="{{ $rule['discount_amount'] }}">
                                                        <input type="hidden" name="rewards[discount][final_price][]" value="{{ $rule['final_price'] }}">
                                                    </div>
                                                @endforeach
                                            @endif
                                        </div>
                                    </div>
                                </div>
                                <!-- Group Discount -->
                                <div id="discount_group_fields" style="display: {{ isset($promotionData['discount_rule']) && $promotionData['discount_rule']->apply_to === 'group' ? 'block' : 'none' }};">
                                    <div class="mb-3">
                                        <label for="discount_group_product_ids" class="form-label">Products</label>
                                        <select name="conditions[discount][group_product_ids][]" id="discount_group_product_ids" multiple class="form-select">
                                            @foreach ($products as $product)
                                                <option value="{{ $product['id'] }}"
                                                    @if(isset($promotionData['group_products']) && in_array($product['id'], $promotionData['group_products'])) selected @endif
                                                    @if(in_array($product['id'], $discountedProductIds)) disabled @endif>
                                                    {{ $product['name'] . (in_array($product['id'], $discountedProductIds) ? ' (already discounted)' : '') }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discount_group_percent" class="form-label">Discount Percent</label>
                                        <input type="number" step="0.01" name="rewards[discount][group_percentage]" id="discount_group_percent" class="form-control" value="{{ old('rewards.discount.group_percentage', isset($promotionData['discount_rule']) && $promotionData['discount_rule']->apply_to === 'group' ? $promotionData['discount_rule']->percentage : '') }}">
                                    </div>
                                </div>
                            </div>

                            <!-- Coupon Fields -->
                             <div>
                               <div id="coupon_fields" style="display: {{ isset($promotion) && $promotion->type === 'coupon' ? 'block' : 'none' }};">
                                <div class="mb-3">
                                    <label for="coupon_code" class="form-label">Coupon Code</label>
                                    <input type="text" name="coupon_code" id="coupon_code" class="form-control" value="{{ old('coupon_code', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->coupon_code : '') }}">
                                </div>
                                <div class="mb-3">
                                    <label for="coupon_apply_to" class="form-label">Apply Coupon To</label>
                                    <select name="conditions[coupon][apply_to]" id="coupon_apply_to" class="form-select">
                                        <option value="all" {{ isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'all' ? 'selected' : '' }}>All Products</option>
                                        <option value="group" {{ isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'group' ? 'selected' : '' }}>Group Products</option>
                                        <option value="customer" {{ isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'customer' ? 'selected' : '' }}>Customer</option>
                                    </select>
                                </div>
                                <div class="mb-3" id="coupon_customer_ids_field" style="display: {{ isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'customer' ? 'block' : 'none' }};">
                                    <label for="coupon_customer_ids" class="form-label">Customers</label>
                                    <select name="conditions[coupon][customer_ids][]" id="coupon_customer_ids" multiple class="form-select">
                                        @foreach($customers as $customer)
                                            <option value="{{ $customer['id'] }}"
                                                @if(isset($promotionData['customers']) && in_array($customer['id'], $promotionData['customers'])) selected @endif>
                                                {{ $customer['name'].' ('.$customer['email'].')'. ' ('.$customer['phone'].')' }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                                <div id="coupon_all_products_field" style="display: {{ isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'all' ? 'block' : 'none' }};">
                                    <div class="mb-3">
                                        <label for="coupon_all" class="form-label">Coupon Percent (All Products)</label>
                                        <input type="number" step="0.01" name="rewards[coupon][percentage]" id="coupon_all" class="form-control" value="{{ old('rewards.coupon.percentage', isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'all' ? $promotionData['coupon_rule']->percentage : '') }}">
                                    </div>
                                </div>
                                <div id="coupon_group_fields" style="display: {{ isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'group' ? 'block' : 'none' }};">
                                    <div class="mb-3">
                                        <label for="coupon_group_product_ids" class="form-label">Products</label>
                                        <select name="conditions[coupon][group_product_ids][]" id="coupon_group_product_ids" multiple class="form-select">
                                            @foreach ($products as $product)
                                                <option value="{{ $product['id'] }}"
                                                    @if(isset($promotionData['group_products']) && in_array($product['id'], $promotionData['group_products'])) selected @endif
                                                    @if(in_array($product['id'], $discountedProductIds)) disabled @endif>
                                                    {{ $product['name'] . (in_array($product['id'], $discountedProductIds) ? ' (already discounted)' : '') }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="coupon_type" class="form-label">Coupon Type</label>
                                             <select name="rewards[coupon][type]" id="coupon_type" class="form-control">
                                <option value="percentage" 
                                    {{ old('rewards.coupon.type', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->type : '') == 'percentage' ? 'selected' : '' }}>
                                    Percentage
                                </option>
                                <option value="amount" 
                                    {{ old('rewards.coupon.type', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->type : '') == 'amount' ? 'selected' : '' }}>
                                    Amount
                                </option>
                                     </select>
                                        </div>

                                        {{-- Percentage field --}}
                                        <div class="mb-3 coupon-field" id="coupon_percent_field" 
                                            style="{{ old('rewards.coupon.type', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->type : '') == 'percentage' ? '' : 'display:none;' }}">
                                            <label for="coupon_group_percent" class="form-label">Coupon Percent</label>
                                            <input type="number" step="0.01" 
                                                name="rewards[coupon][group_percentage]" 
                                                id="coupon_group_percent" 
                                                class="form-control" 
                                                value="{{ old('rewards.coupon.group_percentage', isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->type === 'percentage' ? $promotionData['coupon_rule']->percentage : '') }}">
                                        </div>

                                        {{-- Amount field --}}
                                        <div class="mb-3 coupon-field" id="coupon_amount_field" 
                                            style="{{ old('rewards.coupon.type', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->type : '') == 'amount' ? '' : 'display:none;' }}">
                                            <label for="coupon_amount" class="form-label">Coupon Amount</label>
                                            <input type="number" step="0.01" 
                                                name="rewards[coupon][amount]" 
                                                id="coupon_amount" 
                                                class="form-control" 
                                                value="{{ old('rewards.coupon.amount', isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->type === 'amount' ? $promotionData['coupon_rule']->amount : '') }}">
                                        </div>

                                                                        </div>
                                                                        <div id="coupon_customer_field" 
                                            style="display: {{ isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'customer' ? 'block' : 'none' }};">

                                        <!-- NEW: Apply Coupon To (inside customer)  -->
    <div class="mb-3">
    <label for="coupon_product_type" class="form-label">Apply Coupon (Product Type)</label>
    <select name="conditions[coupon][product_type]" id="coupon_product_type" class="form-select">
        <option value="all" {{ old('conditions.coupon.product_type', $promotionData['coupon_rule']->product_type ?? '') == 'all' ? 'selected' : '' }}>All Products</option>
        <option value="group" {{ old('conditions.coupon.product_type', $promotionData['coupon_rule']->product_type ?? '') == 'group' ? 'selected' : '' }}>Group Products</option>
    </select>
</div>


    <!-- Group products (only visible if customer_apply_to == group)  -->
  <div class="mb-3" id="coupon_product_group_field" 
    style="{{ old('conditions.coupon.product_type', $promotionData['coupon_rule']->product_type ?? '') == 'group' ? '' : 'display:none;' }}">
    
    <label for="coupon_product_group_ids" class="form-label">Products (for Group)</label>
    <select name="conditions[coupon][group_product_ids][]" id="coupon_product_group_ids" multiple class="form-select">
        @foreach ($products as $product)
            <option value="{{ $product['id'] }}"
                @if(isset($promotionData['group_products']) && in_array($product['id'], $promotionData['group_products'])) selected @endif>
                {{ $product['name'] }}
            </option>
        @endforeach
    </select>
</div>

                                            
                                            
                                             <!-- Coupon Type Dropdown  -->
                                            <div class="mb-3">
                                                <label for="coupon_customer_type" class="form-label">Coupon Type (Customer)</label>
                                                <select name="rewards[coupon][customer_type]" id="coupon_customer_type" class="form-control">
                                                    <option value="percentage"
                                                        {{ old('rewards.coupon.customer_type', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->coupon_type : '') == 'percentage' ? 'selected' : '' }}>
                                                        Percentage
                                                    </option>
                                                    <option value="amount"
                                                        {{ old('rewards.coupon.customer_type', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->coupon_type : '') == 'amount' ? 'selected' : '' }}>
                                                        Amount
                                                    </option>
                                                </select>
                                            </div>

                                            {{-- Percentage field --}}
                                            <div class="mb-3 customer-field" id="coupon_customer_percent_field" 
                                                style="{{ old('rewards.coupon.customer_type', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->coupon_type : '') == 'percentage' ? '' : 'display:none;' }}">
                                                <label for="coupon_customer_percent" class="form-label">Coupon Percent (Customer)</label>
                                                <input type="number" step="0.01" 
                                                    name="rewards[coupon][customer_percentage]" 
                                                    id="coupon_customer_percent" 
                                                    class="form-control" 
                                                    value="{{ old('rewards.coupon.customer_percentage', isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'customer' && $promotionData['coupon_rule']->coupon_type === 'percentage' ? $promotionData['coupon_rule']->percentage : '') }}">
                                            </div>

                                            {{-- Amount field --}}
                                            <div class="mb-3 customer-field" id="coupon_customer_amount_field" 
                                                style="{{ old('rewards.coupon.customer_type', isset($promotionData['coupon_rule']) ? $promotionData['coupon_rule']->coupon_type : '') == 'amount' ? '' : 'display:none;' }}">
                                                <label for="coupon_customer_amount" class="form-label">Coupon Amount (Customer)</label>
                                                <input type="number" step="0.01" 
                                                    name="rewards[coupon][customer_amount]" 
                                                    id="coupon_customer_amount" 
                                                    class="form-control" 
                                                    value="{{ old('rewards.coupon.customer_amount', isset($promotionData['coupon_rule']) && $promotionData['coupon_rule']->apply_to === 'customer' && $promotionData['coupon_rule']->coupon_type === 'amount' ? $promotionData['coupon_rule']->amount : '') }}">
                                            </div>
                                        </div>
                    </div>


                            <!-- FOC Fields -->
                            <div id="foc_fields" style="display: {{ isset($promotion) && $promotion->type === 'foc' ? 'block' : 'none' }};">
                                <div class="mb-3">
                                    <label for="foc_min_threshold" class="form-label">Minimum Threshold (Cart Amount)</label>
                                    <input type="number" step="0.01" name="conditions[foc][min_threshold]" id="foc_min_threshold" class="form-control" value="{{ old('conditions.foc.min_threshold', isset($promotionData['foc_rule']) ? $promotionData['foc_rule']->min_threshold : '') }}">
                                </div>
                                <div class="mb-3">
                                    <label for="foc_max_threshold" class="form-label">Maximum Threshold (Cart Amount)</label>
                                    <input type="number" step="0.01" name="conditions[foc][max_threshold]" id="foc_max_threshold" class="form-control" value="{{ old('conditions.foc.max_threshold', isset($promotionData['foc_rule']) ? $promotionData['foc_rule']->max_threshold : '') }}">
                                </div>
                                <div class="mb-3">
                                    <label for="foc_product_ids" class="form-label">Free Products</label>
                                    <select name="rewards[foc][free_product_ids][]" id="foc_product_ids" multiple class="form-select">
                                        @foreach ($products as $product)
                                            <option value="{{ $product['id'] }}"
                                                @if(isset($promotionData['free_products']) && in_array($product['id'], $promotionData['free_products'])) selected @endif
                                                @if(in_array($product['id'], $discountedProductIds))@endif>
                                                {{ $product['name']}}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>

                            <!-- Cashback Fields -->
                            <div id="cashback_fields" style="display: {{ isset($promotion) && $promotion->type === 'cashback' ? 'block' : 'none' }};">

                                <!-- Product Type Selection -->
                                <div class="mb-3">
                                    <label for="cashback_product_type" class="form-label">Apply Cashback (Product Type)</label>
                                    <select name="conditions[cashback][product_type]" id="cashback_product_type" class="form-select">
                                        <option value="all" {{ old('conditions.cashback.product_type', $promotionData['cashback_rule']->product_type ?? '') == 'all' ? 'selected' : '' }}>All Products</option>
                                        <option value="group" {{ old('conditions.cashback.product_type', $promotionData['cashback_rule']->product_type ?? '') == 'group' ? 'selected' : '' }}>Group Products</option>
                                    </select>
                                </div>

                                <!-- Group Products (only visible if product_type == group) -->
                                <div class="mb-3" id="cashback_product_group_field" style="display: {{ old('conditions.cashback.product_type', $promotionData['cashback_rule']->product_type ?? '') == 'group' ? 'block' : 'none' }};">
                                    <label for="cashback_group_product_ids" class="form-label">Products</label>
                                    <select name="conditions[cashback][group_product_ids][]" id="cashback_group_product_ids" multiple class="form-select">
                                        @foreach ($products as $product)
                                            <option value="{{ $product['id'] }}"
                                                @if(isset($promotionData['group_products']) && in_array($product['id'], $promotionData['group_products'])) selected @endif>
                                                {{ $product['name'] }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>

                                <!-- Cashback Type and Value -->
                                <div class="mb-3">
                                    <label for="cashback_type" class="form-label">Cashback Type</label>
                                    <select name="rewards[cashback][type]" id="cashback_type" class="form-control">
                                        @php
                                            $persistedCashbackType = old('rewards.cashback.type', isset($promotionData['cashback_rule'])
                                                ? (!is_null($promotionData['cashback_rule']->cashback_percentage) ? 'percentage' : 'amount')
                                                : 'percentage');
                                        @endphp
                                        <option value="percentage" {{ $persistedCashbackType === 'percentage' ? 'selected' : '' }}>Percentage</option>
                                        <option value="amount" {{ $persistedCashbackType === 'amount' ? 'selected' : '' }}>Amount</option>
                                    </select>
                                </div>

                                <div class="mb-3 cashback-field" id="cashback_percent_field"
                                     style="{{ (old('rewards.cashback.type', isset($promotionData['cashback_rule']) ? (!is_null($promotionData['cashback_rule']->cashback_percentage) ? 'percentage' : 'amount') : 'percentage') == 'percentage') ? '' : 'display:none;' }}">
                                    <label for="cashback_percentage" class="form-label">Cashback Percent</label>
                                    <input type="number" step="0.01" name="rewards[cashback][percentage]" id="cashback_percentage" class="form-control"
                                           value="{{ old('rewards.cashback.percentage', isset($promotionData['cashback_rule']) && !is_null($promotionData['cashback_rule']->cashback_percentage) ? $promotionData['cashback_rule']->cashback_percentage : '') }}">
                                </div>

                                <div class="mb-3 cashback-field" id="cashback_amount_field"
                                     style="{{ (old('rewards.cashback.type', isset($promotionData['cashback_rule']) ? (!is_null($promotionData['cashback_rule']->cashback_percentage) ? 'percentage' : 'amount') : 'percentage') == 'amount') ? '' : 'display:none;' }}">
                                    <label for="cashback_amount" class="form-label">Cashback Amount</label>
                                    <input type="number" step="0.01" name="rewards[cashback][amount]" id="cashback_amount" class="form-control"
                                           value="{{ old('rewards.cashback.amount', isset($promotionData['cashback_rule']) && is_null($promotionData['cashback_rule']->cashback_percentage) ? ($promotionData['cashback_rule']->cashback_amount ?? '') : '') }}">
                                </div>

                                <!-- Cashback Duration -->
                                <div class="mb-3">
                                    <label for="cashback_duration" class="form-label">Duration (days)</label>
                                    <input type="number" min="1" step="1" name="conditions[cashback][duration]" id="cashback_duration" class="form-control"
                                           value="{{ old('conditions.cashback.duration', isset($promotionData['cashback_rule']) ? ($promotionData['cashback_rule']->duration ?? '') : '') }}">
                                </div>
                            </div>

                            <div class="mt-4">
                                <button type="submit" class="btn btn-primary">{{ isset($promotion) ? 'Update Promotion' : 'Save Promotion' }}</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.css" rel="stylesheet">
    <script>
        // Dynamically create productPrices object from PHP $products array
        const productPrices = @json($products).reduce((acc, product) => {
            acc[product.id] = parseFloat(product.price);
            return acc;
        }, {});

        document.addEventListener('DOMContentLoaded', function () {
            // Initialize TomSelect for all select elements
            const discountSelect = new TomSelect('#discount_product_ids', {
                maxItems: 1,
                onChange: function(values) {
                    updatePriceAndDiscount('discount', values);
                }
            });
const groupDiscountSelect = new TomSelect('#discount_group_product_ids', { 
    maxItems: 10,
    plugins: ['remove_button'], // optional but recommended for UX
    closeAfterSelect: false,    // keeps dropdown open for multi-select
    onItemAdd: function() {
        this.setTextboxValue('');    // clears the typed text
        this.refreshOptions(false);  // ensures dropdown stays ready
    }
});

            const couponGroupSelect = new TomSelect('#coupon_group_product_ids', { maxItems: 10 });
            const coupon_product_group_ids = new TomSelect('#coupon_product_group_ids', { maxItems: 10 });
            const couponCustomerSelect = new TomSelect('#coupon_customer_ids', { maxItems: 10 });
            const cashbackGroupProductSelect = new TomSelect('#cashback_group_product_ids', { maxItems: 10 });
            // const bogoProductSelect = new TomSelect('#bogo_product_ids', { maxItems: 1 });
            // const bogoFreeProductSelect = new TomSelect('#bogo_free_product_ids', { maxItems: 1 });
            const buyXProductSelect = new TomSelect('#buy_x_product_ids', {
                maxItems: 200,
                lock: 'locked',
                onItemRemove: function() {
                    return false;
                }
            });
            const getYProductSelect = new TomSelect('#get_y_product_ids', {
                maxItems: 200,
                lock: 'locked',
                onItemRemove: function() {
                    return false;
                }
            });
            const focProductSelect = new TomSelect('#foc_product_ids', {
                maxItems: 200,
                lock: 'locked',
                onItemRemove: function() {
                    return false;
                }
            });

            toggleFields();
            toggleDiscountFields('discount');
            toggleCouponFields();

            // Add event listeners
            document.getElementById('type').addEventListener('change', function() {
                toggleFields();
                if (this.value === 'discount' && document.getElementById('discount_apply_to').value === 'individual') {
                    discountSelect.setValue(''); // Clear selection
                    updatePriceAndDiscount('discount', '');
                }
            });
            document.getElementById('discount_apply_to').addEventListener('change', function() {
                toggleDiscountFields('discount');
                if (this.value === 'individual') {
                    discountSelect.setValue(''); // Clear selection
                    updatePriceAndDiscount('discount', '');
                }
            });
            document.getElementById('discount_type_select').addEventListener('change', function() {
                toggleDiscountTypeFields();
                calculateDiscount('discount');
            });
            document.getElementById('discount_percent').addEventListener('input', function() {
                calculateDiscount('discount');
            });
            document.getElementById('discount_amount').addEventListener('input', function() {
                calculateDiscount('discount');
            });
            document.getElementById('coupon_apply_to').addEventListener('change', function() {
                toggleCouponFields();
            });
             document.getElementById('coupon_product_type').addEventListener('change', function() {
                toggleCouponFields();
            });
            // Customer selection removed for cashback

            // Cashback type toggle for percentage/amount fields
            const cashbackTypeSelect = document.getElementById('cashback_type');
            if (cashbackTypeSelect) {
                cashbackTypeSelect.addEventListener('change', function () {
                    const percentField = document.getElementById('cashback_percent_field');
                    const amountField = document.getElementById('cashback_amount_field');
                    if (this.value === 'percentage') {
                        percentField.style.display = 'block';
                        amountField.style.display = 'none';
                    } else {
                        percentField.style.display = 'none';
                        amountField.style.display = 'block';
                    }
                });
            }

            // Cashback product type toggle
            const cashbackProductTypeSelect = document.getElementById('cashback_product_type');
            if (cashbackProductTypeSelect) {
                cashbackProductTypeSelect.addEventListener('change', function () {
                    const groupField = document.getElementById('cashback_product_group_field');
                    groupField.style.display = this.value === 'group' ? 'block' : 'none';
                });
            }

            // Add BOGO rule
            // document.getElementById('add_bogo_rule').addEventListener('click', function() {
            //     const buyProduct = document.getElementById('bogo_product_ids').value;
            //     const freeProduct = document.getElementById('bogo_free_product_ids').value;
            //     if (buyProduct && freeProduct) {
            //         addBogoRule(buyProduct, freeProduct);
            //         bogoProductSelect.clear();
            //         bogoFreeProductSelect.clear();
            //     } else {
            //         alert('Please select both a Buy product and a Free product.');
            //     }
            // });

            // Add Individual Discount rule
            document.getElementById('add_discount_rule').addEventListener('click', function() {
                const productId = document.getElementById('discount_product_ids').value;
                const discountType = document.getElementById('discount_type_select').value;
                const discountValue = discountType === 'percent' ? 
                    document.getElementById('discount_percent').value : 
                    document.getElementById('discount_amount').value;
                const productPrice = document.getElementById('discount_product_price').value;
                const discountAmount = document.getElementById('discount_result').value;
                const finalPrice = document.getElementById('discount_final_price').value;
                if (productId && discountValue && productPrice && discountAmount && finalPrice) {
                    console.log('add_discount_rule Click', productPrice, discountAmount, finalPrice);
                    if (discountValue <= 0) {
                        alert('Discount value must be greater than 0.');
                        return;
                    }
                    if (discountAmount < 0) {
                        alert('Discount amount cannot be negative.');
                        return;
                    }
                    // if (finalPrice < 0) {
                    //     alert('Final price cannot be negative.');
                    //     return;
                    // }
                    addDiscountRule(productId, discountType, discountValue, productPrice, discountAmount, finalPrice);
                    discountSelect.clear();
                    document.getElementById('discount_percent').value = '';
                    document.getElementById('discount_amount').value = '';
                    document.getElementById('discount_product_price').value = '';
                    document.getElementById('discount_result').value = '';
                    document.getElementById('discount_final_price').value = '';
                    discountSelect.setValue(''); // Clear selection
                    updatePriceAndDiscount('discount', '');
                } else {
                    alert('Please select a product and enter all discount values.');
                }
            });

            // Form submission validation
            document.getElementById('promotionForm').addEventListener('submit', function(event) {
                const promotionType = document.getElementById('type').value;
                // Validate BOGO
                // if (promotionType === 'bogo') {
                //     const bogoRules = document.querySelectorAll('#bogo_rules_table .row');
                //     if (bogoRules.length === 0) {
                //         event.preventDefault();
                //         alert('Please add at least one BOGO rule with a Buy product and a Free product.');
                //         return;
                //     }
                //     for (let row of bogoRules) {
                //         const buyProduct = row.querySelector('input[name="conditions[bogo][product_ids][]"]').value;
                //         const freeProduct = row.querySelector('input[name="rewards[bogo][free_product_ids][]"]').value;
                //         if (!buyProduct || !freeProduct) {
                //             event.preventDefault();
                //             alert('All BOGO rules must have a valid Buy product and Free product.');
                //             return;
                //         }
                //     }
                // }
                // Validate Buy X Get Y
                if (promotionType === 'buy_x_get_y') {
                    const buyQuantity = parseFloat(document.getElementById('buy_quantity').value);
                    const getQuantity = parseFloat(document.getElementById('get_quantity').value);
                    const buyProductIds = document.getElementById('buy_x_product_ids').tomselect.getValue();
                    const getProductIds = document.getElementById('get_y_product_ids').tomselect.getValue();

                    if (isNaN(buyQuantity) || buyQuantity < 1) {
                        event.preventDefault();
                        alert('Buy Quantity must be a positive number (at least 1).');
                        return;
                    }
                    if (isNaN(getQuantity) || getQuantity < 1) {
                        event.preventDefault();
                        alert('Get Quantity must be a positive number (at least 1).');
                        return;
                    }
                    if (buyProductIds.length === 0) {
                        event.preventDefault();
                        alert('At least one Buy product must be selected.');
                        return;
                    }
                    // if (getProductIds.length === 0) {
                    //     event.preventDefault();
                    //     alert('At least one Free product must be selected.');
                    //     return;
                    // }
                }
                // Validate Discount
                if (promotionType === 'discount') {
                    const applyTo = document.getElementById('discount_apply_to').value;
                    if (applyTo === 'all') {
                        const discountPercent = parseFloat(document.getElementById('discount_all').value);
                        if (isNaN(discountPercent) || discountPercent <= 0) {
                            event.preventDefault();
                            alert('Discount Percent for All Products must be a positive number.');
                            return;
                        }
                    } else if (applyTo === 'group') {
                        const groupProductIds = document.getElementById('discount_group_product_ids').tomselect.getValue();
                        const groupPercent = parseFloat(document.getElementById('discount_group_percent').value);
                        if (groupProductIds.length === 0) {
                            event.preventDefault();
                            alert('At least one product must be selected for Group Discount.');
                            return;
                        }
                        if (isNaN(groupPercent) || groupPercent <= 0) {
                            event.preventDefault();
                            alert('Discount Percent for Group must be a positive number.');
                            return;
                        }
                    } else if (applyTo === 'individual') {
                        const discountRules = document.querySelectorAll('#discount_rules_table .row');
                        if (discountRules.length === 0) {
                            event.preventDefault();
                            alert('Please add at least one discount rule with valid product, discount type, and values.');
                            return;
                        }
                        for (let row of discountRules) {
                            const productId = row.querySelector('input[name="conditions[discount][product_ids][]"]').value;
                            const discountType = row.querySelector('input[name="rewards[discount][discount_type][]"]').value;
                            const discountValue = parseFloat(row.querySelector('input[name="rewards[discount][value][]"]').value);
                            const productPrice = parseFloat(row.querySelector('input[name="rewards[discount][product_price][]"]').value);
                            const discountAmount = parseFloat(row.querySelector('input[name="rewards[discount][discount_amount][]"]').value);
                            const finalPrice = parseFloat(row.querySelector('input[name="rewards[discount][final_price][]"]').value);

                            if (!productId || !discountType || isNaN(discountValue) || isNaN(productPrice) || isNaN(discountAmount) || isNaN(finalPrice)) {
                                event.preventDefault();
                                alert('All discount rules must have a valid product, discount type, discount value, product price, discount amount, and final price.');
                                return;
                            }
                            if (discountType !== 'percent' && discountType !== 'amount') {
                                event.preventDefault();
                                alert('Discount type must be either "percent" or "amount".');
                                return;
                            }
                            if (discountValue <= 0) {
                                event.preventDefault();
                                alert('Discount value must be greater than 0.');
                                return;
                            }
                            if (discountAmount < 0) {
                                event.preventDefault();
                                alert('Discount amount cannot be negative.');
                                return;
                            }
                            // if (finalPrice < 0) {
                            //     event.preventDefault();
                            //     alert('Final price cannot be negative.');
                            //     return;
                            // }
                        }
                    }
                }
                // Validate Coupon
                // Inside the form submission handler
if (promotionType === 'coupon') {
    const couponCode = document.getElementById('coupon_code').value;
    const applyTo = document.getElementById('coupon_apply_to').value;

    if (!couponCode || couponCode === '') {
        event.preventDefault();
        alert('Coupon Code is required.');
        return;
    }

    // New logic to get the coupon type
    let couponType;
    let couponValue;

    if (applyTo === 'customer') {
        couponType = document.getElementById('coupon_customer_type').value;
        if (couponType === 'percentage') {
            couponValue = parseFloat(document.getElementById('coupon_customer_percent').value);
        } else { // 'amount'
            couponValue = parseFloat(document.getElementById('coupon_customer_amount').value);
        }
    } else if (applyTo === 'group') {
        couponType = document.getElementById('coupon_type').value;
        if (couponType === 'percentage') {
            couponValue = parseFloat(document.getElementById('coupon_group_percent').value);
        } else { // 'amount'
            couponValue = parseFloat(document.getElementById('coupon_amount').value);
        }
    } else if (applyTo === 'all') {
        couponType = document.getElementById('coupon_type').value;
        if (couponType === 'percentage') {
            couponValue = parseFloat(document.getElementById('coupon_all').value);
        } else { // 'amount'
            couponValue = parseFloat(document.getElementById('coupon_amount').value);
        }
    }

    // Now, validate the coupon value
    if (isNaN(couponValue) || couponValue <= 0) {
        event.preventDefault();
        alert('Coupon value must be a positive number.');
        return;
    }

    if (applyTo === 'customer') {
        const customerIds = document.getElementById('coupon_customer_ids').tomselect.getValue();
        if (customerIds.length === 0) {
            event.preventDefault();
            alert('At least one customer must be selected for Customer Coupon.');
            return;
        }
    } else if (applyTo === 'group') {
        const groupProductIds = document.getElementById('coupon_group_product_ids').tomselect.getValue();
        if (groupProductIds.length === 0) {
            event.preventDefault();
            alert('At least one product must be selected for Group Coupon.');
            return;
        }
    }
}
                // Validate FOC
                if (promotionType === 'cashback') {
                    // Validate cashback value (percentage or amount)
                    const cashbackType = document.getElementById('cashback_type').value;
                    let cashbackValue;
                    if (cashbackType === 'percentage') {
                        cashbackValue = parseFloat(document.getElementById('cashback_percentage').value);
                    } else {
                        cashbackValue = parseFloat(document.getElementById('cashback_amount').value);
                    }
                    if (isNaN(cashbackValue) || cashbackValue <= 0) {
                        event.preventDefault();
                        alert('Cashback value must be a positive number.');
                        return;
                    }

                    const productType = document.getElementById('cashback_product_type').value;
                    if (productType === 'group') {
                        const productIds = document.getElementById('cashback_group_product_ids').tomselect.getValue();
                        if (productIds.length === 0) {
                            event.preventDefault();
                            alert('At least one product must be selected for Cashback (Group Products).');
                            return;
                        }
                    }

                    // No customer selection for cashback
                }

                if (promotionType === 'foc') {
                    const minThreshold = parseFloat(document.getElementById('foc_min_threshold').value);
                    const maxThreshold = parseFloat(document.getElementById('foc_max_threshold').value);
                    const productIds = document.getElementById('foc_product_ids').tomselect.getValue();

                    if (productIds.length === 0) {
                        event.preventDefault();
                        alert('At least one Free product must be selected for FOC promotion.');
                        return;
                    }
                    if (isNaN(minThreshold) || minThreshold < 0) {
                        event.preventDefault();
                        alert('Minimum Threshold for Cart Amount must be a non-negative number.');
                        return;
                    }
                    if (isNaN(maxThreshold) || maxThreshold < 0) {
                        event.preventDefault();
                        alert('Maximum Threshold for Cart Amount must be a non-negative number.');
                        return;
                    }
                    if (!isNaN(minThreshold) && !isNaN(maxThreshold) && maxThreshold < minThreshold) {
                        event.preventDefault();
                        alert('Maximum Threshold must be greater than or equal to Minimum Threshold.');
                        return;
                    }
                }
            });
        });

        function toggleFields() {
            const type = document.getElementById('type').value;
            // document.getElementById('bogo_fields').style.display = type === 'bogo' ? 'block' : 'none';
            document.getElementById('buy_x_get_y_fields').style.display = type === 'buy_x_get_y' ? 'block' : 'none';
            document.getElementById('discount_fields').style.display = type === 'discount' ? 'block' : 'none';
            document.getElementById('coupon_fields').style.display = type === 'coupon' ? 'block' : 'none';
            document.getElementById('foc_fields').style.display = type === 'foc' ? 'block' : 'none';
            document.getElementById('cashback_fields').style.display = type === 'cashback' ? 'block' : 'none';

            // Ensure cashback product group visibility updates when switching to cashback
            if (type === 'cashback') {
                const cashbackProductTypeSelect = document.getElementById('cashback_product_type');
                const cashbackGroupField = document.getElementById('cashback_product_group_field');
                if (cashbackProductTypeSelect && cashbackGroupField) {
                    cashbackGroupField.style.display = cashbackProductTypeSelect.value === 'group' ? 'block' : 'none';
                }
            }
        }

        function toggleDiscountFields(type) {
            const applyTo = document.getElementById(`${type}_apply_to`).value;
            const individualFields = document.getElementById(`${type}_individual_fields`);
            const groupFields = document.getElementById(`${type}_group_fields`);
            const allProductsField = document.getElementById(`${type}_all_products_field`);
            individualFields.style.display = applyTo === 'individual' ? 'block' : 'none';
            groupFields.style.display = applyTo === 'group' ? 'block' : 'none';
            allProductsField.style.display = applyTo === 'all' ? 'block' : 'none';
            toggleDiscountTypeFields();
        }

        function toggleDiscountTypeFields() {
            const discountType = document.getElementById('discount_type_select').value;
            const percentFields = document.getElementById('discount_percent_fields');
            const amountFields = document.getElementById('discount_amount_fields');
            percentFields.style.display = discountType === 'percent' ? 'block' : 'none';
            amountFields.style.display = discountType === 'amount' ? 'block' : 'none';
        }

        function toggleCouponFields() {
            const applyTo = document.getElementById('coupon_apply_to').value;
            const allProductsField = document.getElementById('coupon_all_products_field');
            const groupFields = document.getElementById('coupon_group_fields');
            const customerField = document.getElementById('coupon_customer_field');
            const customerIdsField = document.getElementById('coupon_customer_ids_field');
            const applyCouponTo = document.getElementById('coupon_product_type').value;

            const groupCouponFields = document.getElementById('coupon_product_group_field');
            allProductsField.style.display = applyTo === 'all' ? 'block' : 'none';
            customerField.style.display = applyTo === 'customer' ? 'block' : 'none';
            customerIdsField.style.display = applyTo === 'customer' ? 'block' : 'none';
            groupFields.style.display = applyTo === 'group' ? 'block' : 'none';
            groupCouponFields.style.display = applyCouponTo === 'group' ? 'block' : 'none';
        }

        function updatePriceAndDiscount(type, productIds) {
            const applyTo = document.getElementById(`${type}_apply_to`).value;
            if (applyTo === 'individual') {
                const priceInput = document.getElementById(`${type}_product_price`);
                let totalPrice = 0;
                if (typeof productIds === 'string') {
                    totalPrice = productPrices[productIds] || 0;
                }
                priceInput.value = totalPrice.toFixed(2);
                calculateDiscount(type);
            }
        }

        function calculateDiscount(type) {
            const applyTo = document.getElementById(`${type}_apply_to`).value;
            if (applyTo === 'individual') {
                const priceInput = document.getElementById(`${type}_product_price`);
                const discountType = document.getElementById('discount_type_select').value;
                const percentInput = document.getElementById('discount_percent');
                const amountInput = document.getElementById('discount_amount');
                const discountResultInput = document.getElementById(`${type}_result`);
                const finalPriceInput = document.getElementById(`${type}_final_price`);
                const price = parseFloat(priceInput.value) || 0;

                if (discountType === 'percent') {
                    const percentage = parseFloat(percentInput.value) || 0;
                    const discountAmount = (price * percentage) / 100;
                    const finalPrice = price - discountAmount;
                    // if (finalPrice < 0) {
                    //     alert('Final price cannot be negative.');
                    //     discountResultInput.value = '';
                    //     finalPriceInput.value = '';
                    //     return;
                    // }
                    discountResultInput.value = discountAmount.toFixed(2);
                    finalPriceInput.value = finalPrice.toFixed(2);
                } else if (discountType === 'amount') {
                    const amount = parseFloat(amountInput.value) || 0;
                    const finalPrice = price - amount;
                    // if (finalPrice < 0) {
                    //     alert('Final price cannot be negative.');
                    //     discountResultInput.value = '';
                    //     finalPriceInput.value = '';
                    //     return;
                    // }
                    discountResultInput.value = amount.toFixed(2);
                    finalPriceInput.value = finalPrice.toFixed(2);
                }
            }
        }
       document.addEventListener("DOMContentLoaded", function () {
    function toggleFields(selectId, percentId, amountId) {
        const typeSelect = document.getElementById(selectId);
        const percentField = document.getElementById(percentId);
        const amountField = document.getElementById(amountId);

        function update() {
            if (typeSelect.value === "percentage") {
                percentField.style.display = "block";
                amountField.style.display = "none";
            } else {
                percentField.style.display = "none";
                amountField.style.display = "block";
            }
        }

        typeSelect.addEventListener("change", update);
        update(); // run on load
    }

    toggleFields("coupon_type", "coupon_percent_field", "coupon_amount_field"); // group
    toggleFields("coupon_customer_type", "coupon_customer_percent_field", "coupon_customer_amount_field"); // customer
    toggleFields("cashback_type", "cashback_percent_field", "cashback_amount_field"); // cashback
});

        // function addBogoRule(buyProduct, freeProduct) {
        //     const table = document.getElementById('bogo_rules_table');
        //     const row = document.createElement('div');
        //     row.className = 'row align-items-center border-bottom py-2';
        //     row.innerHTML = `
        //         <div class="col">${document.querySelector(`#bogo_product_ids option[value="${buyProduct}"]`).text}</div>
        //         <div class="col">${document.querySelector(`#bogo_free_product_ids option[value="${freeProduct}"]`).text}</div>
        //         <div class="col-2">
        //             <button type="button" onclick="this.parentElement.parentElement.remove()" class="btn btn-danger btn-sm">Remove</button>
        //         </div>
        //         <input type="hidden" name="conditions[bogo][product_ids][]" value="${buyProduct}">
        //         <input type="hidden" name="rewards[bogo][free_product_ids][]" value="${freeProduct}">
        //     `;
        //     table.appendChild(row);
        // }

        function addDiscountRule(productId, discountType, discountValue, productPrice, discountAmount, finalPrice) {
            const table = document.getElementById('discount_rules_table');
            const price = parseFloat(productPrice) || 0;
            let displayValue = discountType === 'percent' ? `${discountValue}%` : `${discountValue}`;
            const row = document.createElement('div');
            row.className = 'row align-items-center border-bottom py-2';
            row.innerHTML = `
                <div class="col">${document.querySelector(`#discount_product_ids option[value="${productId}"]`).text}</div>
                <div class="col">${discountType === 'percent' ? 'Percent' : 'Amount'}</div>
                <div class="col">${displayValue}</div>
                <div class="col">${parseFloat(discountAmount).toFixed(2)}</div>
                <div class="col">${parseFloat(finalPrice).toFixed(2)}</div>
                <div class="col-2">
                    <button type="button" onclick="this.parentElement.parentElement.remove()" class="btn btn-danger btn-sm">Remove</button>
                </div>
                <input type="hidden" name="conditions[discount][product_ids][]" value="${productId}">
                <input type="hidden" name="rewards[discount][discount_type][]" value="${discountType}">
                <input type="hidden" name="rewards[discount][value][]" value="${discountValue}">
                <input type="hidden" name="rewards[discount][product_price][]" value="${productPrice}">
                <input type="hidden" name="rewards[discount][discount_amount][]" value="${discountAmount}">
                <input type="hidden" name="rewards[discount][final_price][]" value="${finalPrice}">
            `;
            table.appendChild(row);
        }
    </script>
@endsection

@section('scripts')
@endsection
