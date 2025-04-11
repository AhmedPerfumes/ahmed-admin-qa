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
                        ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
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

                            $vals = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                            $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
                        }
                } elseif($category == 'EXTRAIT DE PARFUM') {
                    $productCategory->products = DB::table('ec_product_category_product')
                        ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
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

                            $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
                        }
                } elseif($category == 'GIFT SETS') {
                    $productCategory->products = DB::table('ec_product_category_product')
                        ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
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

                            $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
                        }
                }
                elseif($category == 'ONLINE EXCLUSIVE') {
                    $productCategory->products = DB::table('ec_product_category_product')
                        ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
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

                            $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
                        }
                }
                else {
                    $productCategory->productSubCategories = ProductCategory::select('id', 'name', 'image', 'mobile_image', 'video')->where('parent_id', $productCategory->id)->where('status', 'published')->get();
                    foreach ($productCategory->productSubCategories as $key => $val) {
                        $val->products = DB::table('ec_product_category_product')
                        ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
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

                            $v->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $v->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
                        }
                    }
                }
            } else {
                $productCategory->products = DB::table('ec_product_category_product')
                ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price')
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

                    $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
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
                // ->select(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, ' &amp; ', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"))
                ->select(DB::raw('CAST(ec_products.price AS DECIMAL(8,2)) as price'), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_products.video_media as video', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price', 'ec_products.sku')
                ->where('ec_products.status', 'published')
                ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9]', '')"), '=', implode('', explode(' ', $product)))
                ->where('ec_product_categories.name', $category)
                ->orderBy('ec_products.id', 'desc')
                ->first();
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

                $prod->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $prod->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                foreach ($prod->related_prods as $key => $val) {
                    $val->subcategory = DB::table('ec_product_categories')
                    ->select('name as subcategory_name')
                    ->join ('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                    ->where('product_id', $val->product_id)
                    ->where('ec_product_categories.parent_id', '!=', 0)
                    ->first();

                    $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                    $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
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

                $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
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

                $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
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

                $val->coupon = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();
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
}
