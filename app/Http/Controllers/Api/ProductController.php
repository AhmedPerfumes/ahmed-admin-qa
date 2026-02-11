<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Botble\Ecommerce\Models\ProductCategory;
use Botble\Ecommerce\Models\Product;
use Botble\Slug\Models\Slug;
use Botble\Ecommerce\Models\OrderProduct;
use Botble\Ecommerce\Models\DiscountProduct;
use Botble\Ecommerce\Models\ProductFragranceNote;
use Botble\Ecommerce\Models\ProductFragranceMap;

class ProductController extends Controller
{
    public function getProducts(Request $request)
    {
        // $customer = Auth::guard('api')->user();

        // if (!$customer) {
        //     return response()->json(['message' => 'Unauthorized'], 401);
        // }

        $category = $request['category'];
        $subCategory = $request['subCategory'];
        $product = $request['product'];

        if (!isset($category) || empty($category)) {
            return response()->json([
                'message'       => 'Kindly Provide Category',
            ]);
        }

        if(!$product) {
            $categoryData = ProductCategory::select('id', 'parent_id')->where('status', 'published')->where('parent_id', 0)
            // ->where('name', $category)
            ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"), '=', implode('', explode(' ', $category)))
            ->get()->first();

            if (isset($subCategory)) {      
                $subCategoryData = ProductCategory::select('id')->where('status', 'published')->where('parent_id', $categoryData->id)
                // ->where('name', $subCategory)
                ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"), '=', implode('', explode(' ', $subCategory)))
                ->get()->first();
            }

            if (!isset($subCategory)) {
                $productCategory = ProductCategory::select('id', 'name', 'image', 'mobile_image', 'description')->where('status', 'published')->where('parent_id', 0)->where('id', $categoryData->id)->get()->first();
            } else {
                $productCategory = ProductCategory::select('id', 'name', 'image', 'mobile_image', 'description')->where('status', 'published')->where('parent_id', $categoryData->id)->where('id', $subCategoryData->id)->get()->first();
            }
            
            if (!isset($subCategory)) {
                if($category == 'HAIR MIST') {
                    $productCategory->products = DB::table('ec_product_category_product')
                       ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.name_ar as product_name_ar', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                        ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                        ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                        ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                        ->where('ec_product_category_product.category_id', 6)
                        ->orderBy('ec_product_category_product.product_id', 'desc')
                        ->get();

                        foreach ($productCategory->products as $key => $val) {
                            $val->permalink = Slug::select('key')->where('reference_id', $val->product_id)->first();
                            $total_sales = OrderProduct::select(DB::raw('SUM(qty) as total_sales'))
                            ->join('ec_orders', 'ec_order_product.order_id', '=', 'ec_orders.id')
                            // ->where('ec_orders.status', 'completed') // Optional: filter by order status
                            ->where('product_id', $val->product_id)
                            ->groupBy('product_id')
                            // ->orderBy('total_sales', 'desc')
                            // ->limit(10) // Optional: limit to top 10
                            ->first();

                            $val->sales = $total_sales ? intval($total_sales->total_sales) : 0;

                            $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')
                            ->where('product_id', $val->product_id)
                            ->whereNull('code')
                            ->whereDate('start_date', '<=', now())
                            ->whereDate('end_date', '>=', now())
                            ->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')
                            ->first();

                            $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                            $val->coupon = [];
                            foreach ($coupons as $coupon) {
                                $val->coupon[strtolower($coupon->code)] = [
                                    'code' => strtolower($coupon->code),
                                    'value' => $coupon->value,
                                    'start_date' => $coupon->start_date,
                                    'end_date' => $coupon->end_date,
                                ];
                            }
                        }
                } elseif($category == 'EXTRAIT DE PARFUM') {
                    $productCategory->products = DB::table('ec_product_category_product')
                       ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.name_ar as product_name_ar', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                        ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                        ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                        ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                        ->where('ec_product_category_product.category_id', 22)
                        ->orderBy('ec_product_category_product.product_id', 'desc')
                        ->get();

                        foreach ($productCategory->products as $key => $val) {
                            $val->permalink = Slug::select('key')->where('reference_id', $val->product_id)->first();
                            $total_sales = OrderProduct::select(DB::raw('SUM(qty) as total_sales'))
                            ->join('ec_orders', 'ec_order_product.order_id', '=', 'ec_orders.id')
                            // ->where('ec_orders.status', 'completed') // Optional: filter by order status
                            ->where('product_id', $val->product_id)
                            ->groupBy('product_id')
                            // ->orderBy('total_sales', 'desc')
                            // ->limit(10) // Optional: limit to top 10
                            ->first();

                            $val->sales = $total_sales ? intval($total_sales->total_sales) : 0;

                            $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                            $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                            $val->coupon = [];
                            foreach ($coupons as $coupon) {
                                $val->coupon[strtolower($coupon->code)] = [
                                    'code' => strtolower($coupon->code),
                                    'value' => $coupon->value,
                                    'start_date' => $coupon->start_date,
                                    'end_date' => $coupon->end_date,
                                ];
                            }
                        }
                } elseif($category == 'GIFT SETS') {
                    $productCategory->products = DB::table('ec_product_category_product')
                       ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.name_ar as product_name_ar', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                        ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                        ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                        ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                        ->where('ec_product_category_product.category_id', 4)
                        ->orderBy('ec_product_category_product.product_id', 'desc')
                        ->get();

                        foreach ($productCategory->products as $key => $val) {
                            $val->permalink = Slug::select('key')->where('reference_id', $val->product_id)->first();
                            $total_sales = OrderProduct::select(DB::raw('SUM(qty) as total_sales'))
                            ->join('ec_orders', 'ec_order_product.order_id', '=', 'ec_orders.id')
                            // ->where('ec_orders.status', 'completed') // Optional: filter by order status
                            ->where('product_id', $val->product_id)
                            ->groupBy('product_id')
                            // ->orderBy('total_sales', 'desc')
                            // ->limit(10) // Optional: limit to top 10
                            ->first();

                            $val->sales = $total_sales ? intval($total_sales->total_sales) : 0;

                            $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                            $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                            $val->coupon = [];
                            foreach ($coupons as $coupon) {
                                $val->coupon[strtolower($coupon->code)] = [
                                    'code' => strtolower($coupon->code),
                                    'value' => $coupon->value,
                                    'start_date' => $coupon->start_date,
                                    'end_date' => $coupon->end_date,
                                ];
                            }
                        }
                }
                elseif($category == 'ONLINE EXCLUSIVE') {
                    $productCategory->products = DB::table('ec_product_category_product')
                        ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.name_ar as product_name_ar', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                        ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                        ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                        ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                        ->where('ec_product_category_product.category_id', 19)
                        ->orderBy('ec_product_category_product.product_id', 'desc')
                        ->get();

                        foreach ($productCategory->products as $key => $val) {
                            $val->permalink = Slug::select('key')->where('reference_id', $val->product_id)->first();
                            $total_sales = OrderProduct::select(DB::raw('SUM(qty) as total_sales'))
                            ->join('ec_orders', 'ec_order_product.order_id', '=', 'ec_orders.id')
                            // ->where('ec_orders.status', 'completed') // Optional: filter by order status
                            ->where('product_id', $val->product_id)
                            ->groupBy('product_id')
                            // ->orderBy('total_sales', 'desc')
                            // ->limit(10) // Optional: limit to top 10
                            ->first();

                            $val->sales = $total_sales ? intval($total_sales->total_sales) : 0;

                            $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                            $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                            $val->coupon = [];
                            foreach ($coupons as $coupon) {
                                $val->coupon[strtolower($coupon->code)] = [
                                    'code' => strtolower($coupon->code),
                                    'value' => $coupon->value,
                                    'start_date' => $coupon->start_date,
                                    'end_date' => $coupon->end_date,
                                ];
                            }
                        }
                }
                else {
                    $productCategory->productSubCategories = ProductCategory::select('id', 'name', 'image', 'mobile_image', 'video')->where('parent_id', $productCategory->id)->where('status', 'published')->get();
                    foreach ($productCategory->productSubCategories as $key => $val) {
                        $val->products = DB::table('ec_product_category_product')
                       ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.name_ar as product_name_ar', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                        ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                        ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                        ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                        ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                        ->where('ec_product_category_product.category_id', $val->id)
                        ->orderBy('ec_product_category_product.product_id', 'desc')
                        ->get();

                        foreach ($val->products as $k => $v) {
                            $v->permalink = Slug::select('key')->where('reference_id', $v->product_id)->first();
                            $total_sales = OrderProduct::select(DB::raw('SUM(qty) as total_sales'))
                            ->join('ec_orders', 'ec_order_product.order_id', '=', 'ec_orders.id')
                            // ->where('ec_orders.status', 'completed') // Optional: filter by order status
                            ->where('product_id', $v->product_id)
                            ->groupBy('product_id')
                            // ->orderBy('total_sales', 'desc')
                            // ->limit(10) // Optional: limit to top 10
                            ->first();

                            $v->sales = $total_sales ? intval($total_sales->total_sales) : 0;

                            $v->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $v->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                            $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $v->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                            $v->coupon = [];
                            foreach ($coupons as $coupon) {
                                $v->coupon[strtolower($coupon->code)] = [
                                    'code' => strtolower($coupon->code),
                                    'value' => $coupon->value,
                                    'start_date' => $coupon->start_date,
                                    'end_date' => $coupon->end_date,
                                ];
                            }
                        }
                    }
                }
            } else {
                $productCategory->products = DB::table('ec_product_category_product')
               ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.name_ar as product_name_ar', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                ->where('ec_product_category_product.category_id', $subCategoryData->id)
                ->orderBy('ec_product_category_product.product_id', 'desc')
                ->get();
                
                foreach ($productCategory->products as $key => $val) {
                    $val->permalink = Slug::select('key')->where('reference_id', $val->product_id)->first();
                    $total_sales = OrderProduct::select(DB::raw('SUM(qty) as total_sales'))
                    ->join('ec_orders', 'ec_order_product.order_id', '=', 'ec_orders.id')
                    // ->where('ec_orders.status', 'completed') // Optional: filter by order status
                    ->where('product_id', $val->product_id)
                    ->groupBy('product_id')
                    // ->orderBy('total_sales', 'desc')
                    // ->limit(10) // Optional: limit to top 10
                    ->first();

                    $val->sales = $total_sales ? intval($total_sales->total_sales) : 0;

                    $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                    $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                    $val->coupon = [];
                    foreach ($coupons as $coupon) {
                        $val->coupon[strtolower($coupon->code)] = [
                            'code' => strtolower($coupon->code),
                            'value' => $coupon->value,
                            'start_date' => $coupon->start_date,
                            'end_date' => $coupon->end_date,
                        ];
                    }
                }
            }
            return response()->json($productCategory);
        } else {
            // $prod = DB::table('ec_product_category_product')
            // ->select('ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.price', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color')
            // ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
            // ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
            // ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
            // ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
            // ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
            // ->where('ec_products.name', $product)
            // ->where('ec_products.status', 'published')
            // ->first();
            // $prod = $cleanedData = DB::table(DB::raw("(SELECT TRIM( REGEXP_REPLACE( REGEXP_REPLACE( REGEXP_REPLACE(ec.name, 'amp;', ''), '&' , ' ' , '[^a-zA-Z0-9 -]', ' '), '\\s+', ' ' ) ) AS cleaned_column, ec_products.id, ec_products.name, ec_products.price, ec_products.image, ec_products.images, ec_products.description, ec_products.quantity, ec_products.status FROM ec_products) AS cleaned_data"))
            //     ->join ('ec_product_category_product', 'ec_product_category_product.product_id', '=', 'cleaned_data.id', 'left')
            //     ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'cleaned_data.id', 'left')
            //     ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
            //     ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'cleaned_data.id', 'left')
            //     ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
            //     ->select('ec_product_category_product.product_id', 'cleaned_data.name as product_name', 'cleaned_data.price', 'cleaned_data.image', 'cleaned_data.images', 'ec_product_collections.name as collection_name', 'cleaned_data.description', 'cleaned_data.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color')
            //     ->where('cleaned_column', $product)
            //     ->where('cleaned_data.status', 'published')
            //     // ->groupBy('cleaned_data.id')
            //     ->first();
            // , 'ec_products.content as content'
            // , 'ec_products.fragrance_notes as fragrance_notes'
            $prod =  DB::table('ec_products')
                ->join ('ec_product_category_product', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                ->join ('ec_product_categories', 'ec_product_categories.id', '=', 'ec_product_category_product.category_id', 'left')
                ->join('product_fragrance_map', 'ec_products.id', '=', 'product_fragrance_map.product_id', 'left')
                ->join('product_fragrance_notes', 'product_fragrance_map.fragrance_note_id', '=', 'product_fragrance_notes.id', 'left')
                // ->select(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, ' &amp; ', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"))
                 ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.name_ar as product_name_ar', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.description_ar', 'ec_products.content_ar', 'ec_products.quantity as product_qty', 'ec_products.video_media as video', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price', 'ec_products.sku', 'ec_products.sillage', 'ec_products.longevity', 'ec_products.how_to_use', 'ec_products.occasion', 'ec_products.size', 'ec_products.item_profile', 'ec_products.item_classification', 'ec_products.ingredients', 'ec_products.olfactory_family', 'ec_products.fragrance_type', 'ec_products.fragrance_category', 'ec_products.dispenser_type', 'ec_products.additional_details', 'ec_products.story', 'ec_products.badge', 'ec_products.itemCategory_1', 'ec_products.itemCategory_2', 'ec_products.itemCategory_3', 'ec_products.itemCategory_4', 'ec_products.itemCategory_5', 'ec_products.is_collection', 'ec_products.product_family', 'product_fragrance_notes.itemFamily', 'product_fragrance_notes.top_note', 'product_fragrance_notes.top_note_ar', 'product_fragrance_notes.top_note_image', 'product_fragrance_notes.top_note_description', 'product_fragrance_notes.top_note_description_ar', 'product_fragrance_notes.heart_note', 'product_fragrance_notes.heart_note_ar', 'product_fragrance_notes.heart_note_image', 'product_fragrance_notes.heart_note_description', 'product_fragrance_notes.heart_note_description_ar', 'product_fragrance_notes.base_note', 'product_fragrance_notes.base_note_ar', 'product_fragrance_notes.base_note_image', 'product_fragrance_notes.base_note_description', 'product_fragrance_notes.base_note_description_ar')
                ->where('ec_products.status', 'published')
                ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9]', '')"), '=', implode('', explode(' ', $product)))
                ->where('ec_product_categories.name', $category)
                ->orderBy('ec_products.id', 'desc')
                ->first();
                if ($prod && $prod->is_collection) {
                    $collectionItems = DB::table('ec_collection_items')->where('collection_product_id', $prod->product_id)->orderBy('sort_order', 'asc')->get();
                    
                    $childProductIds = $collectionItems->pluck('child_product_id')->filter()->unique()->all();

                    $childProductsData = [];
                    if (!empty($childProductIds)) {
                        $childProductsData = DB::table('ec_products')->whereIn('id', $childProductIds)->select('id', 'name', 'name_ar', 'price', 'image', 'images' )->get()->keyBy('id');
                    }

                    // Step 4: Combine and Format the data.
                    $prod->collection_items = $collectionItems->map(function ($item) use ($childProductsData) {
                        if ($item->child_product_id && isset($childProductsData[$item->child_product_id])) {
                            $fullProductData = $childProductsData[$item->child_product_id];
                            
                            // Merge the collection pivot data (sort_order, etc) with the actual product data
                            return (object) array_merge((array)$item, (array)$fullProductData);
                        }

                        return $item;
                    });

                } elseif ($prod) {
                    $prod->collection_items = [];
                }
                // print_r($prod);die();
                $dynamicDescriptionKey = preg_replace('/[^a-zA-Z0-9\s]/', '', $prod->product_name).' Description';
                $wordsToRemove = ['&', ' &', '& ', ' & ', 'amp', ' amp', 'amp ', ' amp ', ';', ' ;', '; ', ' ; '];
                $cleanDescriptionString = preg_replace('/\s+/', ' ', str_ireplace($wordsToRemove, '', $dynamicDescriptionKey));
                $prod->$cleanDescriptionString = $cleanDescriptionString;

                $dynamicContentKey = preg_replace('/[^a-zA-Z0-9\s]/', '', $prod->product_name).' Content';
                $cleanContentString = preg_replace('/\s+/', ' ', str_ireplace($wordsToRemove, '', $dynamicContentKey));
                $prod->$cleanContentString = $cleanContentString;

                $dynamicNotesKey = preg_replace('/[^a-zA-Z0-9\s]/', '', $prod->product_name).' Notes';
                $cleanNotesString = preg_replace('/\s+/', ' ', str_ireplace($wordsToRemove, '', $dynamicNotesKey));
                $prod->$cleanNotesString = $cleanNotesString;

                $prod->related_prods = DB::table('ec_product_category_product')
                ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_product_categories.name as category_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                ->join ('ec_product_related_relations', 'ec_product_related_relations.to_product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                ->where('ec_product_categories.status', 'published')
                ->where('ec_product_collections.name', NULL)
                ->where('ec_product_categories.parent_id', 0)
                ->where('ec_product_related_relations.from_product_id', $prod->product_id)
                // ->paginate($limit);
                ->get();

                $prod->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $prod->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $prod->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                $prod->coupon = [];
                foreach ($coupons as $coupon) {
                    $prod->coupon[strtolower($coupon->code)] = [
                        'code' => strtolower($coupon->code),
                        'value' => $coupon->value,
                        'start_date' => $coupon->start_date,
                        'end_date' => $coupon->end_date,
                    ];
                }

                foreach ($prod->related_prods as $key => $val) {
                    $val->subcategory = DB::table('ec_product_categories')
                    ->select('name as subcategory_name')
                    ->join ('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                    ->where('product_id', $val->product_id)
                    ->where('ec_product_categories.parent_id', '!=', 0)
                    ->first();

                    $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                    $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                    $val->coupon = [];
                    foreach ($coupons as $coupon) {
                        $val->coupon[strtolower($coupon->code)] = [
                            'code' => strtolower($coupon->code),
                            'value' => $coupon->value,
                            'start_date' => $coupon->start_date,
                            'end_date' => $coupon->end_date,
                        ];
                    }
                }
                if (isset($prod->product_family) && !empty($prod->product_family)) {
                    $currentProductFamily = $prod->product_family;
                    $productId = $prod->product_id;

                    $results = DB::table('ec_products')
                        ->select(
                            'ec_products.id as product_id',
                            DB::raw('MAX(ec_products.name) as product_name'),
                            DB::raw('MAX(ec_products.image) as image'),
                            DB::raw('MAX(ec_products.images) as images'),
                            DB::raw('MAX(ec_products.description) as description'),
                            DB::raw('MAX(ec_products.quantity) as product_qty'),
                            DB::raw('CAST(MAX(ec_products.price) AS DECIMAL(10,2)) as price'),
                            DB::raw('CAST(MAX(ec_products.sale_price) AS DECIMAL(10,2)) as sale_price'),
                            DB::raw('GROUP_CONCAT(DISTINCT ec_product_collections.name) as collection_name'),
                            DB::raw('GROUP_CONCAT(DISTINCT main_cat.name) as category_name'),
                            DB::raw('GROUP_CONCAT(DISTINCT sub_cat.name) as subcategory_name'),
                            DB::raw("CONCAT('[', GROUP_CONCAT(DISTINCT JSON_OBJECT('name', ec_product_labels.name, 'color', ec_product_labels.color)), ']') as labels")
                        )
                        ->leftJoin('ec_product_category_product as pivot_main', 'pivot_main.product_id', '=', 'ec_products.id')
                        ->leftJoin('ec_product_categories as main_cat', function ($join) {
                            $join->on('pivot_main.category_id', '=', 'main_cat.id')
                                ->where('main_cat.parent_id', 0);
                        })
                        ->leftJoin('ec_product_category_product as pivot_sub', 'pivot_sub.product_id', '=', 'ec_products.id')
                        ->leftJoin('ec_product_categories as sub_cat', function ($join) {
                            $join->on('pivot_sub.category_id', '=', 'sub_cat.id')
                                ->where('sub_cat.parent_id', '!=', 0);
                        })
                        ->leftJoin('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id')
                        ->leftJoin('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id')
                        ->leftJoin('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id')
                        ->leftJoin('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id')
                        
                        ->where('ec_products.product_family', $currentProductFamily)

                        ->where('ec_products.id', '!=', $productId)
                        ->groupBy('ec_products.id')
                        ->get();

                    $prod->item_family = $results->map(function ($item) {
                        $item->subcategory = $item->subcategory_name ? [
                            'subcategory_name' => $item->subcategory_name,
                        ] : null;
                        unset($item->subcategory_name);
                        $item->labels = json_decode($item->labels);
                        $item->images = json_decode($item->images, true) ?? [];
                        return $item;
                    });

                } else {
                    // If the main product has no family, return an empty array for consistency.
                    $prod->item_family = [];
                }
            return response()->json($prod);
        }
    }


    public function getAllProducts(Request $request)
    {
        $limit = (int)$request['limit'];
        $page = (int)$request['page'];
        $search = implode('', explode(' ', $request['search']));

        if($search == '') {
            // echo "if";
            $prod = DB::table('ec_product_category_product')
                ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_categories.id as category_id', 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_product_categories.name as category_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                ->where('ec_product_categories.status', 'published')
                ->where('ec_product_collections.name', NULL)
                ->where('ec_product_categories.parent_id', 0)
                // ->orderBy('ec_product_category_product.product_id', 'desc')
                ->paginate($limit);
                // ->get();

            foreach ($prod as $key => $val) {
                $val->subcategory = DB::table('ec_product_categories')
                ->select('name as subcategory_name')
                ->join ('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                ->where('product_id', $val->product_id)
                ->where('ec_product_categories.parent_id', '!=', 0)
                ->first();

                $total_sales = OrderProduct::select(DB::raw('SUM(qty) as total_sales'))
                ->join('ec_orders', 'ec_order_product.order_id', '=', 'ec_orders.id')
                // ->where('ec_orders.status', 'completed') // Optional: filter by order status
                ->where('product_id', $val->product_id)
                ->groupBy('product_id')
                // ->orderBy('total_sales', 'desc')
                // ->limit(10) // Optional: limit to top 10
                ->first();

                $val->sales = $total_sales ? intval($total_sales->total_sales) : 0;

                $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                $val->coupon = [];
                foreach ($coupons as $coupon) {
                    $val->coupon[strtolower($coupon->code)] = [
                        'code' => strtolower($coupon->code),
                        'value' => $coupon->value,
                        'start_date' => $coupon->start_date,
                        'end_date' => $coupon->end_date,
                    ];
                }
            }
        } else {
            // echo "else";
            $prod = DB::table('ec_product_category_product')
                ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_categories.id as category_id', 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_product_categories.name as category_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
                ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                ->where('ec_product_categories.status', 'published')
                ->where('ec_product_collections.name', NULL)
                ->where('ec_product_categories.parent_id', 0)
                // ->where('ec_products.name', 'LIKE', '%'.$search.'%')
                ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"), 'LIKE', '%'.$search.'%')
                ->paginate($limit);
            // ->get();

            foreach ($prod as $key => $val) {
                $val->subcategory = DB::table('ec_product_categories')
                ->select('name as subcategory_name')
                ->join ('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                ->where('product_id', $val->product_id)
                ->where('ec_product_categories.parent_id', '!=', 0)
                ->first();

                $total_sales = OrderProduct::select(DB::raw('SUM(qty) as total_sales'))
                ->join('ec_orders', 'ec_order_product.order_id', '=', 'ec_orders.id')
                // ->where('ec_orders.status', 'completed') // Optional: filter by order status
                ->where('product_id', $val->product_id)
                ->groupBy('product_id')
                // ->orderBy('total_sales', 'desc')
                // ->limit(10) // Optional: limit to top 10
                ->first();

                $val->sales = $total_sales ? intval($total_sales->total_sales) : 0;

                $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                $val->coupon = [];
                foreach ($coupons as $coupon) {
                    $val->coupon[strtolower($coupon->code)] = [
                        'code' => strtolower($coupon->code),
                        'value' => $coupon->value,
                        'start_date' => $coupon->start_date,
                        'end_date' => $coupon->end_date,
                    ];
                }
            }
        }

        return response()->json($prod);
    }

    public function getExportProducts(Request $request)
    {
        $category_id = $request['category_id'];
        if (!isset($category_id) || empty($category_id)) {
            return response()->json([
                'message'       => 'Kindly Provide Category',
            ]);
        }
        $products = DB::table('ec_product_category_product')
            ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
            ->join ('ec_product_categories', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
            ->join ('ec_products', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
            ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
            ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
            ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
            ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
            ->where('ec_product_category_product.category_id', $category_id)
            ->where('ec_product_collections.name', NULL)
            ->orderBy('ec_product_category_product.product_id', 'desc')
            ->get();

            foreach ($products as $key => $val) {
                $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left');

                $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                $val->coupon = [];
                foreach ($coupons as $coupon) {
                    $val->coupon[strtolower($coupon->code)] = [
                        'code' => strtolower($coupon->code),
                        'value' => $coupon->value,
                        'start_date' => $coupon->start_date,
                        'end_date' => $coupon->end_date,
                    ];
                }
            }
        return response()->json($products);
    }

    public function getProductSEO(Request $request)
    {
        $category = $request['category'];
        $subCategory = $request['subCategory'];
        $product = $request['product'];

        if (!isset($category) || empty($category)) {
            return response()->json([
                'message'       => 'Kindly Provide Category',
            ]);
        }

        $prod =  DB::table('ec_products')
            // ->join ('ec_product_category_product', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
            // ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
            // ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
            // ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
            // ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
            // ->join ('ec_product_categories', 'ec_product_categories.id', '=', 'ec_product_category_product.category_id', 'left')
            ->join ('meta_boxes', 'meta_boxes.reference_id', '=', 'ec_products.id', 'left')
            // ->select(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, ' &amp; ', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"))
            ->select('meta_value')
            ->where('ec_products.status', 'published')
            ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9]', '')"), '=', implode('', explode(' ', $product)))
            // ->where('ec_product_categories.name', $category)
            ->where('meta_key', 'seo_meta')
            // ->orderBy('ec_products.id', 'desc')
            ->where('reference_type', 'Botble\Ecommerce\Models\Product')
            ->first();
            // print_r($prod);die();
        return response()->json($prod);
    }

    public function getProductsLiveStatus(Request $request) {
        $productIds = $request->input('product_ids');

        if (empty($productIds)) {
            $content = $request->getContent(); // Get the raw string body
            $json = json_decode($content, true); // Turn JSON string into Array
            $productIds = $json['product_ids'] ?? null;
        }

        if (empty($productIds) || !is_array($productIds)) {
            return response()->json([], 200);
        }

        // $currency = Currency::select('decimals')->where('is_default', 1)->first();
        // $decimals = $currency->decimals ?? 3;

        $products = DB::table('ec_products')
        ->select('id as product_id', 'quantity as product_qty', DB::raw('CAST(price AS DECIMAL(8,2)) as price'), 'sale_price', 'maximum_order_quantity')
        ->whereIn('id', $productIds)
        ->where('status', 'published')
        ->get();

        foreach ($products as $val) {
            
            // Replicating your controller's logic, but adding 'type_option' 
            // so the frontend knows if it is 'percentage' or 'amount'.
            $val->discount = DiscountProduct::select(
                    'ec_discounts.value', 
                    'ec_discounts.start_date', 
                    'ec_discounts.end_date',
                    'ec_discounts.type_option as discount_type' // Critical for frontend calculation
                )
                ->where('product_id', $val->product_id)
                ->whereNull('code') // Auto-discounts only (no coupons)
                ->whereDate('start_date', '<=', now())
                ->whereDate('end_date', '>=', now())
                ->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')
                ->first();

            // Normalizing the discount type for the frontend
            // Botble usually stores 'percentage' or 'amount' in type_option
            if ($val->discount) {
                if ($val->discount->discount_type === 'percentage') {
                    $val->discount->discount_type = 'percent';
                }
                
                // Ensure value is an integer/float as expected
                $val->discount->value = (float)$val->discount->value;
            }
        }

        return response()->json($products);
    }
}
