<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Botble\Ecommerce\Models\ProductCategory;
use Botble\Ecommerce\Models\ShippingRule;
use Botble\Ecommerce\Models\Tax;
use Botble\Ecommerce\Models\Currency;
use Botble\SimpleSlider\Models\SimpleSliderItem;
use Botble\Media\Models\MediaFile;
use Illuminate\Support\Facades\DB;

class ProductCategoryController extends Controller
{
    public function getProductCategories(Request $request)
    {
        // $customer = Auth::guard('api')->user();

        // if (!$customer) {
        //     return response()->json(['message' => 'Unauthorized'], 401);
        // }
        // $base_url = 'https://phpstack-1403159-5212295.cloudwaysapps.com/public/storage/';
        $base_url = 'http://localhost/ahmed-admin-KSA/public/storage/';
        $productCategories = ProductCategory::select('id', 'name', 'image', 'icon_image', 'menu_image2')->where('status', 'published')->where('parent_id', 0)->get();

        foreach ($productCategories as $category) {
            // $category->image = $base_url.$category->image;
            // $category->icon_image = $base_url.$category->icon_image;
            // $category->menu_image2 = $base_url.$category->menu_image2;
            $category->productSubCategories = ProductCategory::select('id', 'name', 'image')->where('parent_id', $category->id)->where('status', 'published')->get();
        }

        // foreach ($productCategories as $category) {
        //     foreach ($category->productSubCategories as $val) {
        //         $val->image = $base_url.$val->image;
        //     }
        // }
        // $tax = Tax::select('percentage')->where('status', 'published')->first();
        // $shipping_service_charges = ShippingRule::select('price')->get();

        // return response()->json(['productCategories' => $productCategories, 'tax' => $tax, 'shipping_service_charges' => $shipping_service_charges]);
        return response()->json($productCategories);
    }

    public function getProductCategoriesTemp(Request $request)
    {
        // $customer = Auth::guard('api')->user();

        // if (!$customer) {
        //     return response()->json(['message' => 'Unauthorized'], 401);
        // }
        // $base_url = 'https://phpstack-1403159-5212295.cloudwaysapps.com/public/storage/';
        $base_url = 'http://localhost/ahmed-admin-KSA/public/storage/';
        $productCategories = ProductCategory::select('id', 'name', 'image', 'icon_image', 'menu_image2')->where('status', 'published')->where('parent_id', 0)->get();

        foreach ($productCategories as $category) {
            // $category->image = $base_url.$category->image;
            // $category->icon_image = $base_url.$category->icon_image;
            // $category->menu_image2 = $base_url.$category->menu_image2;
            $category->productSubCategories = ProductCategory::select('id', 'name', 'image')->where('parent_id', $category->id)->where('status', 'published')->get();
        }

        // foreach ($productCategories as $category) {
        //     foreach ($category->productSubCategories as $val) {
        //         $val->image = $base_url.$val->image;
        //     }
        // }
        $tax = Tax::select('percentage')->where('status', 'published')->first();
        $shipping_service_charges = ShippingRule::select('price')->get();
        $currency = Currency::select('symbol')->where('is_default', 1)->first();
        $home_sliders = SimpleSliderItem::select('title', 'image', 'link', 'order', 'sub_title', 'season', 'type', 'color')->where('type', 'desktop')->orderBy('order', 'asc')->get();
        $home_mobile_sliders = SimpleSliderItem::select('title', 'image', 'link', 'order', 'sub_title', 'season', 'type', 'color')->where('type', 'mobile')->orderBy('order', 'asc')->get();

        return response()->json(['productCategories' => $productCategories, 'tax' => $tax, 'shipping_service_charges' => $shipping_service_charges, 'currency' => $currency, 'home_sliders' => $home_sliders, 'home_mobile_sliders' => $home_mobile_sliders]);
        // return response()->json($productCategories);
    }

    public function getProductCategorySEO(Request $request)
    {
        $category = $request['category'];
        $subCategory = $request['subCategory'];
        // $product = $request['product'];

        if (!isset($category) || empty($category)) {
            return response()->json([
                'message'       => 'Kindly Provide Category',
            ]);
        }

        if(!isset($subCategory) || empty($subCategory)) {
            $cat =  DB::table('ec_product_categories')
                // ->join ('ec_product_category_product', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                // ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                // ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                // ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                // ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                // ->join ('ec_product_categories', 'ec_product_categories.id', '=', 'ec_product_category_product.category_id', 'left')
                ->join ('meta_boxes', 'meta_boxes.reference_id', '=', 'ec_product_categories.id', 'left')
                // ->select(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, ' &amp; ', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"))
                ->select('meta_value')
                // ->where('ec_products.status', 'published')
                ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_product_categories.name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9]', '')"), '=', implode('', explode(' ', $category)))
                // ->where('ec_product_categories.name', $category)
                ->where('meta_key', 'seo_meta')
                // ->orderBy('ec_products.id', 'desc')
                ->where('reference_type', 'Botble\Ecommerce\Models\ProductCategory')
                ->where('parent_id', 0)
                ->first();
                // print_r($prod);die();
            return response()->json($cat);
        } else {
            $subCat =  DB::table('ec_product_categories')
                // ->join ('ec_product_category_product', 'ec_product_category_product.product_id', '=', 'ec_products.id', 'left')
                // ->join('ec_product_collection_products', 'ec_product_collection_products.product_id', '=', 'ec_products.id', 'left')
                // ->join('ec_product_collections', 'ec_product_collection_products.product_collection_id', '=', 'ec_product_collections.id', 'left')
                // ->join('ec_product_label_products', 'ec_product_label_products.product_id', '=', 'ec_products.id', 'left')
                // ->join('ec_product_labels', 'ec_product_label_products.product_label_id', '=', 'ec_product_labels.id', 'left')
                // ->join ('ec_product_categories', 'ec_product_categories.id', '=', 'ec_product_category_product.category_id', 'left')
                ->join ('meta_boxes', 'meta_boxes.reference_id', '=', 'ec_product_categories.id', 'left')
                // ->select(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_products.name, ' &amp; ', '&'), '&', ' '),'[^a-zA-Z0-9-]', '')"))
                ->select('meta_value')
                // ->where('ec_products.status', 'published')
                ->where(DB::raw("REGEXP_REPLACE(REPLACE(REPLACE(ec_product_categories.name, '&amp;', '&'), '&', ' '),'[^a-zA-Z0-9]', '')"), '=', implode('', explode(' ', $subCategory)))
                // ->where('ec_product_categories.name', $category)
                ->where('meta_key', 'seo_meta')
                // ->orderBy('ec_products.id', 'desc')
                ->where('reference_type', 'Botble\Ecommerce\Models\ProductCategory')
                ->where('parent_id', '!=', 0)
                ->first();
                // print_r($prod);die();
            return response()->json($subCat);
        }
    }
}
