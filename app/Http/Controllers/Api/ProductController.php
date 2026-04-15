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
use Botble\Ecommerce\Models\Currency;
use App\Models\Promotion;

class ProductController extends Controller
{
    public function getProducts(Request $request)
    {
        // $customer = Auth::guard('api')->user();

        // if (!$customer) {
        //     return response()->json(['message' => 'Unauthorized'], 401);
        // }+
        $currency = Currency::select('decimals')->where('is_default', 1)->first();
        $decimals = $currency->decimals ?? 2;

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

                            // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')
                            // ->where('product_id', $val->product_id)
                            // ->whereNull('code')
                            // ->whereDate('start_date', '<=', now())
                            // ->whereDate('end_date', '>=', now())
                            // ->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')
                            // ->first();

                            // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                            // $val->coupon = [];
                            // foreach ($coupons as $coupon) {
                            //     $val->coupon[strtolower($coupon->code)] = [
                            //         'code' => strtolower($coupon->code),
                            //         'value' => $coupon->value,
                            //         'start_date' => $coupon->start_date,
                            //         'end_date' => $coupon->end_date,
                            //     ];
                            // }
                            $val->discount = null;

                            $individualDiscount = Promotion::where('type', 'discount')
                                ->whereDate('start_date', '<=', now())
                                ->whereDate('end_date', '>=', now())
                                ->whereHas('discountRules', function ($query) {
                                    $query->where('apply_to', 'individual');
                                })
                                ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                                    $query->where('product_id', $val->product_id);
                                })
                                ->with(['discountRules' => function ($query) {
                                    $query->where('apply_to', 'individual')
                                        ->select('id', 'promotion_id', 'apply_to');
                                }, 'discountRules.individualRules' => function ($query) use ($val) {
                                    $query->where('product_id', $val->product_id)
                                        ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                                }])
                                ->first();

                            if ($individualDiscount) {
                                $discountRule = $individualDiscount->discountRules->first();
                                $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                                if ($individualRule) {
                                    $val->discount = (object) [
                                        'value' => intval($individualRule->value),
                                        'apply_to' => $discountRule->apply_to,
                                        'discount_type' => $individualRule->discount_type,
                                        'product_price' => $individualRule->product_price,
                                        'discount_amount' => $individualRule->discount_amount,
                                        'final_price' => $individualRule->final_price,
                                        'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                                        'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                                    ];
                                }
                            } else {
                                // If no individual discount, try to fetch discount for group/all products
                                $groupDiscount = Promotion::where('type', 'discount')
                                    ->whereDate('start_date', '<=', now())
                                    ->whereDate('end_date', '>=', now())
                                    ->whereHas('discountRules', function ($query) {
                                        $query->where('apply_to', '!=', 'individual');
                                    })
                                    ->whereHas('discountRules.products', function ($query) use ($val) {
                                        $query->where('product_id', $val->product_id);
                                    })
                                    ->with(['discountRules' => function ($query) {
                                        $query->where('apply_to', '!=', 'individual')
                                            ->select('id', 'promotion_id', 'percentage', 'apply_to');
                                    }])
                                    ->first();

                                if ($groupDiscount) {
                                    $discountRule = $groupDiscount->discountRules->first();
                                    if ($discountRule) {
                                        $val->discount = (object) [
                                            'value' => intval($discountRule->percentage),
                                            'apply_to' => $discountRule->apply_to,
                                            'discount_type' => 'percent',
                                            'product_price' => null,
                                            'discount_amount' => null,
                                            'final_price' => null,
                                            'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                            'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                                        ];
                                    }
                                }
                            }

                            // Fetch active coupons for the product
                            $coupons = Promotion::where('type', 'coupon')
                                ->whereDate('start_date', '<=', now())
                                ->whereDate('end_date', '>=', now())
                                ->whereHas('couponRules.products', function ($query) use ($val) {
                                    $query->where('product_id', $val->product_id);
                                })
                                ->with(['couponRules' => function ($query) use ($val) {
                                    $query->whereNotNull('coupon_code')
                                        ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                                        ->with(['products' => function ($subQuery) use ($val) {
                                            $subQuery->where('product_id', $val->product_id)
                                                    ->select('id', 'coupon_rule_id', 'product_id');
                                        }]);
                                }])
                                ->get();

                            $val->coupon = [];
                            foreach ($coupons as $promotion) {
                                foreach ($promotion->couponRules as $couponRule) {
                                    if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                                        $val->coupon[strtolower($couponRule->coupon_code)] = [
                                            'code' => strtolower($couponRule->coupon_code),
                                            'value' => intval($couponRule->percentage),
                                            'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                            'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                                        ];
                                    }
                                }
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

                            // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                            // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                            // $val->coupon = [];
                            // foreach ($coupons as $coupon) {
                            //     $val->coupon[strtolower($coupon->code)] = [
                            //         'code' => strtolower($coupon->code),
                            //         'value' => $coupon->value,
                            //         'start_date' => $coupon->start_date,
                            //         'end_date' => $coupon->end_date,
                            //     ];
                            // }

                            $val->discount = null;

                            $individualDiscount = Promotion::where('type', 'discount')
                                ->whereDate('start_date', '<=', now())
                                ->whereDate('end_date', '>=', now())
                                ->whereHas('discountRules', function ($query) {
                                    $query->where('apply_to', 'individual');
                                })
                                ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                                    $query->where('product_id', $val->product_id);
                                })
                                ->with(['discountRules' => function ($query) {
                                    $query->where('apply_to', 'individual')
                                        ->select('id', 'promotion_id', 'apply_to');
                                }, 'discountRules.individualRules' => function ($query) use ($val) {
                                    $query->where('product_id', $val->product_id)
                                        ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                                }])
                                ->first();

                            if ($individualDiscount) {
                                $discountRule = $individualDiscount->discountRules->first();
                                $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                                if ($individualRule) {
                                    $val->discount = (object) [
                                        'value' => intval($individualRule->value),
                                        'apply_to' => $discountRule->apply_to,
                                        'discount_type' => $individualRule->discount_type,
                                        'product_price' => $individualRule->product_price,
                                        'discount_amount' => $individualRule->discount_amount,
                                        'final_price' => $individualRule->final_price,
                                        'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                                        'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                                    ];
                                }
                            } else {
                                // If no individual discount, try to fetch discount for group/all products
                                $groupDiscount = Promotion::where('type', 'discount')
                                    ->whereDate('start_date', '<=', now())
                                    ->whereDate('end_date', '>=', now())
                                    ->whereHas('discountRules', function ($query) {
                                        $query->where('apply_to', '!=', 'individual');
                                    })
                                    ->whereHas('discountRules.products', function ($query) use ($val) {
                                        $query->where('product_id', $val->product_id);
                                    })
                                    ->with(['discountRules' => function ($query) {
                                        $query->where('apply_to', '!=', 'individual')
                                            ->select('id', 'promotion_id', 'percentage', 'apply_to');
                                    }])
                                    ->first();

                                if ($groupDiscount) {
                                    $discountRule = $groupDiscount->discountRules->first();
                                    if ($discountRule) {
                                        $val->discount = (object) [
                                            'value' => intval($discountRule->percentage),
                                            'apply_to' => $discountRule->apply_to,
                                            'discount_type' => 'percent',
                                            'product_price' => null,
                                            'discount_amount' => null,
                                            'final_price' => null,
                                            'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                            'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                                        ];
                                    }
                                }
                            }

                            $coupons = Promotion::where('type', 'coupon')
                                ->whereDate('start_date', '<=', now())
                                ->whereDate('end_date', '>=', now())
                                ->whereHas('couponRules.products', function ($query) use ($val) {
                                    $query->where('product_id', $val->product_id);
                                })
                                ->with(['couponRules' => function ($query) use ($val) {
                                    $query->whereNotNull('coupon_code')
                                        ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                                        ->with(['products' => function ($subQuery) use ($val) {
                                            $subQuery->where('product_id', $val->product_id)
                                                    ->select('id', 'coupon_rule_id', 'product_id');
                                        }]);
                                }])
                                ->get();

                            $val->coupon = [];
                            foreach ($coupons as $promotion) {
                                foreach ($promotion->couponRules as $couponRule) {
                                    if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                                        $val->coupon[strtolower($couponRule->coupon_code)] = [
                                            'code' => strtolower($couponRule->coupon_code),
                                            'value' => intval($couponRule->percentage),
                                            'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                            'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                                        ];
                                    }
                                }
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

                        // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                        // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                        // $val->coupon = [];
                        // foreach ($coupons as $coupon) {
                        //     $val->coupon[strtolower($coupon->code)] = [
                        //         'code' => strtolower($coupon->code),
                        //         'value' => $coupon->value,
                        //         'start_date' => $coupon->start_date,
                        //         'end_date' => $coupon->end_date,
                        //     ];
                        // }

                        $val->discount = null;

                        $individualDiscount = Promotion::where('type', 'discount')
                            ->whereDate('start_date', '<=', now())
                            ->whereDate('end_date', '>=', now())
                            ->whereHas('discountRules', function ($query) {
                                $query->where('apply_to', 'individual');
                            })
                            ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                                $query->where('product_id', $val->product_id);
                            })
                            ->with(['discountRules' => function ($query) {
                                $query->where('apply_to', 'individual')
                                    ->select('id', 'promotion_id', 'apply_to');
                            }, 'discountRules.individualRules' => function ($query) use ($val) {
                                $query->where('product_id', $val->product_id)
                                    ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                            }])
                            ->first();

                        if ($individualDiscount) {
                            $discountRule = $individualDiscount->discountRules->first();
                            $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                            if ($individualRule) {
                                $val->discount = (object) [
                                    'value' => intval($individualRule->value),
                                    'apply_to' => $discountRule->apply_to,
                                    'discount_type' => $individualRule->discount_type,
                                    'product_price' => $individualRule->product_price,
                                    'discount_amount' => $individualRule->discount_amount,
                                    'final_price' => $individualRule->final_price,
                                    'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                                    'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                                ];
                            }
                        } else {
                            // If no individual discount, try to fetch discount for group/all products
                            $groupDiscount = Promotion::where('type', 'discount')
                                ->whereDate('start_date', '<=', now())
                                ->whereDate('end_date', '>=', now())
                                ->whereHas('discountRules', function ($query) {
                                    $query->where('apply_to', '!=', 'individual');
                                })
                                ->whereHas('discountRules.products', function ($query) use ($val) {
                                    $query->where('product_id', $val->product_id);
                                })
                                ->with(['discountRules' => function ($query) {
                                    $query->where('apply_to', '!=', 'individual')
                                        ->select('id', 'promotion_id', 'percentage', 'apply_to');
                                }])
                                ->first();

                            if ($groupDiscount) {
                                $discountRule = $groupDiscount->discountRules->first();
                                if ($discountRule) {
                                    $val->discount = (object) [
                                        'value' => intval($discountRule->percentage),
                                        'apply_to' => $discountRule->apply_to,
                                        'discount_type' => 'percent',
                                        'product_price' => null,
                                        'discount_amount' => null,
                                        'final_price' => null,
                                        'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                        'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                                    ];
                                }
                            }
                        }

                        // Fetch active coupons for the product
                        $coupons = Promotion::where('type', 'coupon')
                            ->whereDate('start_date', '<=', now())
                            ->whereDate('end_date', '>=', now())
                            ->whereHas('couponRules.products', function ($query) use ($val) {
                                $query->where('product_id', $val->product_id);
                            })
                            ->with(['couponRules' => function ($query) use ($val) {
                                $query->whereNotNull('coupon_code')
                                    ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                                    ->with(['products' => function ($subQuery) use ($val) {
                                        $subQuery->where('product_id', $val->product_id)
                                                ->select('id', 'coupon_rule_id', 'product_id');
                                    }]);
                            }])
                            ->get();

                        $val->coupon = [];
                        foreach ($coupons as $promotion) {
                            foreach ($promotion->couponRules as $couponRule) {
                                if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                                    $val->coupon[strtolower($couponRule->coupon_code)] = [
                                        'code' => strtolower($couponRule->coupon_code),
                                        'value' => intval($couponRule->percentage),
                                        'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                        'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                                    ];
                                }
                            }
                        }
                    }
                } elseif($category == 'ONLINE EXCLUSIVE') {
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

                        // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                        // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                        // $val->coupon = [];
                        // foreach ($coupons as $coupon) {
                        //     $val->coupon[strtolower($coupon->code)] = [
                        //         'code' => strtolower($coupon->code),
                        //         'value' => $coupon->value,
                        //         'start_date' => $coupon->start_date,
                        //         'end_date' => $coupon->end_date,
                        //     ];
                        // }

                        $val->discount = null;

                        $individualDiscount = Promotion::where('type', 'discount')
                            ->whereDate('start_date', '<=', now())
                            ->whereDate('end_date', '>=', now())
                            ->whereHas('discountRules', function ($query) {
                                $query->where('apply_to', 'individual');
                            })
                            ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                                $query->where('product_id', $val->product_id);
                            })
                            ->with(['discountRules' => function ($query) {
                                $query->where('apply_to', 'individual')
                                    ->select('id', 'promotion_id', 'apply_to');
                            }, 'discountRules.individualRules' => function ($query) use ($val) {
                                $query->where('product_id', $val->product_id)
                                    ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                            }])
                            ->first();
                        
                        if ($individualDiscount) {
                            $discountRule = $individualDiscount->discountRules->first();
                            $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                            if ($individualRule) {
                                $val->discount = (object) [
                                    'value' => intval($individualRule->value),
                                    'apply_to' => $discountRule->apply_to,
                                    'discount_type' => $individualRule->discount_type,
                                    'product_price' => $individualRule->product_price,
                                    'discount_amount' => $individualRule->discount_amount,
                                    'final_price' => $individualRule->final_price,
                                    'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                                    'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                                ];
                            }
                        } else {
                            // If no individual discount, try to fetch discount for group/all products
                            $groupDiscount = Promotion::where('type', 'discount')
                                ->whereDate('start_date', '<=', now())
                                ->whereDate('end_date', '>=', now())
                                ->whereHas('discountRules', function ($query) {
                                    $query->where('apply_to', '!=', 'individual');
                                })
                                ->whereHas('discountRules.products', function ($query) use ($val) {
                                    $query->where('product_id', $val->product_id);
                                })
                                ->with(['discountRules' => function ($query) {
                                    $query->where('apply_to', '!=', 'individual')
                                        ->select('id', 'promotion_id', 'percentage', 'apply_to');
                                }])
                                ->first();

                            if ($groupDiscount) {
                                $discountRule = $groupDiscount->discountRules->first();
                                if ($discountRule) {
                                    $val->discount = (object) [
                                        'value' => intval($discountRule->percentage),
                                        'apply_to' => $discountRule->apply_to,
                                        'discount_type' => 'percent',
                                        'product_price' => null,
                                        'discount_amount' => null,
                                        'final_price' => null,
                                        'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                        'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                                    ];
                                }
                            }
                        }

                        $coupons = Promotion::where('type', 'coupon')
                            ->whereDate('start_date', '<=', now())
                            ->whereDate('end_date', '>=', now())
                            ->whereHas('couponRules.products', function ($query) use ($val) {
                                $query->where('product_id', $val->product_id);
                            })
                            ->with(['couponRules' => function ($query) use ($val) {
                                $query->whereNotNull('coupon_code')
                                    ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                                    ->with(['products' => function ($subQuery) use ($val) {
                                        $subQuery->where('product_id', $val->product_id)
                                                ->select('id', 'coupon_rule_id', 'product_id');
                                    }]);
                            }])
                            ->get();

                        $val->coupon = [];
                        foreach ($coupons as $promotion) {
                            foreach ($promotion->couponRules as $couponRule) {
                                if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                                    $val->coupon[strtolower($couponRule->coupon_code)] = [
                                        'code' => strtolower($couponRule->coupon_code),
                                        'value' => intval($couponRule->percentage),
                                        'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                        'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                                    ];
                                }
                            }
                        }
                    }
                } else {
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

                            // $v->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $v->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                            // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $v->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                            // $v->coupon = [];
                            // foreach ($coupons as $coupon) {
                            //     $v->coupon[strtolower($coupon->code)] = [
                            //         'code' => strtolower($coupon->code),
                            //         'value' => $coupon->value,
                            //         'start_date' => $coupon->start_date,
                            //         'end_date' => $coupon->end_date,
                            //     ];
                            // }

                            $v->discount = null;

                            $individualDiscount = Promotion::where('type', 'discount')
                                ->whereDate('start_date', '<=', now())
                                ->whereDate('end_date', '>=', now())
                                ->whereHas('discountRules', function ($query) {
                                    $query->where('apply_to', 'individual');
                                })
                                ->whereHas('discountRules.individualRules', function ($query) use ($v) {
                                    $query->where('product_id', $v->product_id);
                                })
                                ->with(['discountRules' => function ($query) {
                                    $query->where('apply_to', 'individual')
                                        ->select('id', 'promotion_id', 'apply_to');
                                }, 'discountRules.individualRules' => function ($query) use ($v) {
                                    $query->where('product_id', $v->product_id)
                                        ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                                }])
                                ->first();

                            if ($individualDiscount) {
                                $discountRule = $individualDiscount->discountRules->first();
                                $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                                if ($individualRule) {
                                    $v->discount = (object) [
                                        'value' => intval($individualRule->value),
                                        'apply_to' => $discountRule->apply_to,
                                        'discount_type' => $individualRule->discount_type,
                                        'product_price' => $individualRule->product_price,
                                        'discount_amount' => $individualRule->discount_amount,
                                        'final_price' => $individualRule->final_price,
                                        'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                                        'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                                    ];
                                }
                            } else {
                                // If no individual discount, try to fetch discount for group/all products
                                $groupDiscount = Promotion::where('type', 'discount')
                                    ->whereDate('start_date', '<=', now())
                                    ->whereDate('end_date', '>=', now())
                                    ->whereHas('discountRules', function ($query) {
                                        $query->where('apply_to', '!=', 'individual');
                                    })
                                    ->whereHas('discountRules.products', function ($query) use ($v) {
                                        $query->where('product_id', $v->product_id);
                                    })
                                    ->with(['discountRules' => function ($query) {
                                        $query->where('apply_to', '!=', 'individual')
                                            ->select('id', 'promotion_id', 'percentage', 'apply_to');
                                    }])
                                    ->first();

                                if ($groupDiscount) {
                                    $discountRule = $groupDiscount->discountRules->first();
                                    if ($discountRule) {
                                        $v->discount = (object) [
                                            'value' => intval($discountRule->percentage),
                                            'apply_to' => $discountRule->apply_to,
                                            'discount_type' => 'percent',
                                            'product_price' => null,
                                            'discount_amount' => null,
                                            'final_price' => null,
                                            'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                            'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                                        ];
                                    }
                                }
                            }

                            $coupons = Promotion::where('type', 'coupon')
                                ->whereDate('start_date', '<=', now())
                                ->whereDate('end_date', '>=', now())
                                ->whereHas('couponRules.products', function ($query) use ($v) {
                                    $query->where('product_id', $v->product_id);
                                })
                                ->with(['couponRules' => function ($query) use ($v) {
                                    $query->whereNotNull('coupon_code')
                                        ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                                        ->with(['products' => function ($subQuery) use ($v) {
                                            $subQuery->where('product_id', $v->product_id)
                                                    ->select('id', 'coupon_rule_id', 'product_id');
                                        }]);
                                }])
                                ->get();

                            $v->coupon = [];
                            foreach ($coupons as $promotion) {
                                foreach ($promotion->couponRules as $couponRule) {
                                    if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                                        $v->coupon[strtolower($couponRule->coupon_code)] = [
                                            'code' => strtolower($couponRule->coupon_code),
                                            'value' => intval($couponRule->percentage),
                                            'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                            'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                                        ];
                                    }
                                }
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

                    // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                    // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                    // $val->coupon = [];
                    // foreach ($coupons as $coupon) {
                    //     $val->coupon[strtolower($coupon->code)] = [
                    //         'code' => strtolower($coupon->code),
                    //         'value' => $coupon->value,
                    //         'start_date' => $coupon->start_date,
                    //         'end_date' => $coupon->end_date,
                    //     ];
                    // }

                    $val->discount = null;

                    $individualDiscount = Promotion::where('type', 'discount')
                        ->whereDate('start_date', '<=', now())
                        ->whereDate('end_date', '>=', now())
                        ->whereHas('discountRules', function ($query) {
                            $query->where('apply_to', 'individual');
                        })
                        ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                            $query->where('product_id', $val->product_id);
                        })
                        ->with(['discountRules' => function ($query) {
                            $query->where('apply_to', 'individual')
                                ->select('id', 'promotion_id', 'apply_to');
                        }, 'discountRules.individualRules' => function ($query) use ($val) {
                            $query->where('product_id', $val->product_id)
                                ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                        }])
                        ->first();
                    
                    if ($individualDiscount) {
                        $discountRule = $individualDiscount->discountRules->first();
                        $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                        if ($individualRule) {
                            $val->discount = (object) [
                                'value' => intval($individualRule->value),
                                'apply_to' => $discountRule->apply_to,
                                'discount_type' => $individualRule->discount_type,
                                'product_price' => $individualRule->product_price,
                                'discount_amount' => $individualRule->discount_amount,
                                'final_price' => $individualRule->final_price,
                                'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    } else {
                        // If no individual discount, try to fetch discount for group/all products
                        $groupDiscount = Promotion::where('type', 'discount')
                            ->whereDate('start_date', '<=', now())
                            ->whereDate('end_date', '>=', now())
                            ->whereHas('discountRules', function ($query) {
                                $query->where('apply_to', '!=', 'individual');
                            })
                            ->whereHas('discountRules.products', function ($query) use ($val) {
                                $query->where('product_id', $val->product_id);
                            })
                            ->with(['discountRules' => function ($query) {
                                $query->where('apply_to', '!=', 'individual')
                                    ->select('id', 'promotion_id', 'percentage', 'apply_to');
                            }])
                            ->first();

                        if ($groupDiscount) {
                            $discountRule = $groupDiscount->discountRules->first();
                            if ($discountRule) {
                                $val->discount = (object) [
                                    'value' => intval($discountRule->percentage),
                                    'apply_to' => $discountRule->apply_to,
                                    'discount_type' => 'percent',
                                    'product_price' => null,
                                    'discount_amount' => null,
                                    'final_price' => null,
                                    'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                    'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                                ];
                            }
                        }
                    }

                    $coupons = Promotion::where('type', 'coupon')
                        ->whereDate('start_date', '<=', now())
                        ->whereDate('end_date', '>=', now())
                        ->whereHas('couponRules.products', function ($query) use ($val) {
                            $query->where('product_id', $val->product_id);
                        })
                        ->with(['couponRules' => function ($query) use ($val) {
                            $query->whereNotNull('coupon_code')
                                ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                                ->with(['products' => function ($subQuery) use ($val) {
                                    $subQuery->where('product_id', $val->product_id)
                                            ->select('id', 'coupon_rule_id', 'product_id');
                                }]);
                        }])
                        ->get();

                    $val->coupon = [];
                    foreach ($coupons as $promotion) {
                        foreach ($promotion->couponRules as $couponRule) {
                            if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                                $val->coupon[strtolower($couponRule->coupon_code)] = [
                                    'code' => strtolower($couponRule->coupon_code),
                                    'value' => intval($couponRule->percentage),
                                    'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                    'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                                ];
                            }
                        }
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
                 ->select(DB::raw("CAST(ec_products.price AS DECIMAL(8, $decimals)) as price"), 'ec_product_category_product.product_id', 'ec_products.name as product_name', 'ec_products.image', 'ec_products.images', 'ec_product_collections.name as collection_name', 'ec_products.description', 'ec_products.quantity as product_qty', 'ec_products.video_media as video', 'ec_product_labels.name as label_name', 'ec_product_labels.color as label_color', 'ec_products.sale_price', 'ec_products.sku')
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

                // $prod->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $prod->product_id)->whereNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $prod->product_id)->whereNotNull('code') ->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                // $prod->coupon = [];
                // foreach ($coupons as $coupon) {
                //     $prod->coupon[strtolower($coupon->code)] = [
                //         'code' => strtolower($coupon->code),
                //         'value' => $coupon->value,
                //         'start_date' => $coupon->start_date,
                //         'end_date' => $coupon->end_date,
                //     ];
                // }

                $prod->discount = null;

                $individualDiscount = Promotion::where('type', 'discount')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('discountRules', function ($query) {
                        $query->where('apply_to', 'individual');
                    })
                    ->whereHas('discountRules.individualRules', function ($query) use ($prod) {
                        $query->where('product_id', $prod->product_id);
                    })
                    ->with(['discountRules' => function ($query) {
                        $query->where('apply_to', 'individual')
                            ->select('id', 'promotion_id', 'apply_to');
                    }, 'discountRules.individualRules' => function ($query) use ($prod) {
                        $query->where('product_id', $prod->product_id)
                            ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                    }])
                    ->first();

                if ($individualDiscount) {
                    $discountRule = $individualDiscount->discountRules->first();
                    $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                    if ($individualRule) {
                        $prod->discount = (object) [
                            'value' => intval($individualRule->value),
                            'apply_to' => $discountRule->apply_to,
                            'discount_type' => $individualRule->discount_type,
                            'product_price' => $individualRule->product_price,
                            'discount_amount' => $individualRule->discount_amount,
                            'final_price' => $individualRule->final_price,
                            'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                            'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                        ];
                    }
                } else {
                    // If no individual discount, try to fetch discount for group/all products
                    $groupDiscount = Promotion::where('type', 'discount')
                        ->whereDate('start_date', '<=', now())
                        ->whereDate('end_date', '>=', now())
                        ->whereHas('discountRules', function ($query) {
                            $query->where('apply_to', '!=', 'individual');
                        })
                        ->whereHas('discountRules.products', function ($query) use ($prod) {
                            $query->where('product_id', $prod->product_id);
                        })
                        ->with(['discountRules' => function ($query) {
                            $query->where('apply_to', '!=', 'individual')
                                ->select('id', 'promotion_id', 'percentage', 'apply_to');
                        }])
                        ->first();

                    if ($groupDiscount) {
                        $discountRule = $groupDiscount->discountRules->first();
                        if ($discountRule) {
                            $prod->discount = (object) [
                                'value' => intval($discountRule->percentage),
                                'apply_to' => $discountRule->apply_to,
                                'discount_type' => 'percent',
                                'product_price' => null,
                                'discount_amount' => null,
                                'final_price' => null,
                                'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    }
                }

                $coupons = Promotion::where('type', 'coupon')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('couponRules.products', function ($query) use ($prod) {
                        $query->where('product_id', $prod->product_id);
                    })
                    ->with(['couponRules' => function ($query) use ($prod) {
                        $query->whereNotNull('coupon_code')
                            ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                            ->with(['products' => function ($subQuery) use ($prod) {
                                $subQuery->where('product_id', $prod->product_id)
                                        ->select('id', 'coupon_rule_id', 'product_id');
                            }]);
                    }])
                    ->get();

                $prod->coupon = [];
                foreach ($coupons as $promotion) {
                    foreach ($promotion->couponRules as $couponRule) {
                        if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                            $prod->coupon[strtolower($couponRule->coupon_code)] = [
                                'code' => strtolower($couponRule->coupon_code),
                                'value' => intval($couponRule->percentage),
                                'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    }
                }


                foreach ($prod->related_prods as $key => $val) {
                    $val->subcategory = DB::table('ec_product_categories')
                    ->select('name as subcategory_name')
                    ->join ('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id', 'left')
                    ->where('product_id', $val->product_id)
                    ->where('ec_product_categories.parent_id', '!=', 0)
                    ->first();

                    // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                    // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                    // $val->coupon = [];
                    // foreach ($coupons as $coupon) {
                    //     $val->coupon[strtolower($coupon->code)] = [
                    //         'code' => strtolower($coupon->code),
                    //         'value' => $coupon->value,
                    //         'start_date' => $coupon->start_date,
                    //         'end_date' => $coupon->end_date,
                    //     ];
                    // }

                    $val->discount = null;

                    $individualDiscount = Promotion::where('type', 'discount')
                        ->whereDate('start_date', '<=', now())
                        ->whereDate('end_date', '>=', now())
                        ->whereHas('discountRules', function ($query) {
                            $query->where('apply_to', 'individual');
                        })
                        ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                            $query->where('product_id', $val->product_id);
                        })
                        ->with(['discountRules' => function ($query) {
                            $query->where('apply_to', 'individual')
                                ->select('id', 'promotion_id', 'apply_to');
                        }, 'discountRules.individualRules' => function ($query) use ($val) {
                            $query->where('product_id', $val->product_id)
                                ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                        }])
                        ->first();

                    if ($individualDiscount) {
                        $discountRule = $individualDiscount->discountRules->first();
                        $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                        if ($individualRule) {
                            $val->discount = (object) [
                                'value' => intval($individualRule->value),
                                'apply_to' => $discountRule->apply_to,
                                'discount_type' => $individualRule->discount_type,
                                'product_price' => $individualRule->product_price,
                                'discount_amount' => $individualRule->discount_amount,
                                'final_price' => $individualRule->final_price,
                                'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    } else {
                        // If no individual discount, try to fetch discount for group/all products
                        $groupDiscount = Promotion::where('type', 'discount')
                            ->whereDate('start_date', '<=', now())
                            ->whereDate('end_date', '>=', now())
                            ->whereHas('discountRules', function ($query) {
                                $query->where('apply_to', '!=', 'individual');
                            })
                            ->whereHas('discountRules.products', function ($query) use ($val) {
                                $query->where('product_id', $val->product_id);
                            })
                            ->with(['discountRules' => function ($query) {
                                $query->where('apply_to', '!=', 'individual')
                                    ->select('id', 'promotion_id', 'percentage', 'apply_to');
                            }])
                            ->first();

                        if ($groupDiscount) {
                            $discountRule = $groupDiscount->discountRules->first();
                            if ($discountRule) {
                                $val->discount = (object) [
                                    'value' => intval($discountRule->percentage),
                                    'apply_to' => $discountRule->apply_to,
                                    'discount_type' => 'percent',
                                    'product_price' => null,
                                    'discount_amount' => null,
                                    'final_price' => null,
                                    'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                    'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                                ];
                            }
                        }
                    }

                    // Fetch active coupons for the product
                    $coupons = Promotion::where('type', 'coupon')
                        ->whereDate('start_date', '<=', now())
                        ->whereDate('end_date', '>=', now())
                        ->whereHas('couponRules.products', function ($query) use ($val) {
                            $query->where('product_id', $val->product_id);
                        })
                        ->with(['couponRules' => function ($query) use ($val) {
                            $query->whereNotNull('coupon_code')
                                ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                                ->with(['products' => function ($subQuery) use ($val) {
                                    $subQuery->where('product_id', $val->product_id)
                                            ->select('id', 'coupon_rule_id', 'product_id');
                                }]);
                        }])
                        ->get();

                    $val->coupon = [];
                    foreach ($coupons as $promotion) {
                        foreach ($promotion->couponRules as $couponRule) {
                            if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                                $val->coupon[strtolower($couponRule->coupon_code)] = [
                                    'code' => strtolower($couponRule->coupon_code),
                                    'value' => intval($couponRule->percentage),
                                    'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                    'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                                ];
                            }
                        }
                    }
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

                // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                // $val->coupon = [];
                // foreach ($coupons as $coupon) {
                //     $val->coupon[strtolower($coupon->code)] = [
                //         'code' => strtolower($coupon->code),
                //         'value' => $coupon->value,
                //         'start_date' => $coupon->start_date,
                //         'end_date' => $coupon->end_date,
                //     ];
                // }

                $val->discount = null;

                $individualDiscount = Promotion::where('type', 'discount')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('discountRules', function ($query) {
                        $query->where('apply_to', 'individual');
                    })
                    ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                        $query->where('product_id', $val->product_id);
                    })
                    ->with(['discountRules' => function ($query) {
                        $query->where('apply_to', 'individual')
                            ->select('id', 'promotion_id', 'apply_to');
                    }, 'discountRules.individualRules' => function ($query) use ($val) {
                        $query->where('product_id', $val->product_id)
                            ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                    }])
                    ->first();

                if ($individualDiscount) {
                    $discountRule = $individualDiscount->discountRules->first();
                    $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                    if ($individualRule) {
                        $val->discount = (object) [
                            'value' => intval($individualRule->value),
                            'apply_to' => $discountRule->apply_to,
                            'discount_type' => $individualRule->discount_type,
                            'product_price' => $individualRule->product_price,
                            'discount_amount' => $individualRule->discount_amount,
                            'final_price' => $individualRule->final_price,
                            'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                            'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                        ];
                    }
                } else {
                    // If no individual discount, try to fetch discount for group/all products
                    $groupDiscount = Promotion::where('type', 'discount')
                        ->whereDate('start_date', '<=', now())
                        ->whereDate('end_date', '>=', now())
                        ->whereHas('discountRules', function ($query) {
                            $query->where('apply_to', '!=', 'individual');
                        })
                        ->whereHas('discountRules.products', function ($query) use ($val) {
                            $query->where('product_id', $val->product_id);
                        })
                        ->with(['discountRules' => function ($query) {
                            $query->where('apply_to', '!=', 'individual')
                                ->select('id', 'promotion_id', 'percentage', 'apply_to');
                        }])
                        ->first();

                    if ($groupDiscount) {
                        $discountRule = $groupDiscount->discountRules->first();
                        if ($discountRule) {
                            $val->discount = (object) [
                                'value' => intval($discountRule->percentage),
                                'apply_to' => $discountRule->apply_to,
                                'discount_type' => 'percent',
                                'product_price' => null,
                                'discount_amount' => null,
                                'final_price' => null,
                                'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    }
                }

                // Fetch active coupons for the product
                $coupons = Promotion::where('type', 'coupon')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('couponRules.products', function ($query) use ($val) {
                        $query->where('product_id', $val->product_id);
                    })
                    ->with(['couponRules' => function ($query) use ($val) {
                        $query->whereNotNull('coupon_code')
                            ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                            ->with(['products' => function ($subQuery) use ($val) {
                                $subQuery->where('product_id', $val->product_id)
                                        ->select('id', 'coupon_rule_id', 'product_id');
                            }]);
                    }])
                    ->get();

                $val->coupon = [];
                foreach ($coupons as $promotion) {
                    foreach ($promotion->couponRules as $couponRule) {
                        if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                            $val->coupon[strtolower($couponRule->coupon_code)] = [
                                'code' => strtolower($couponRule->coupon_code),
                                'value' => intval($couponRule->percentage),
                                'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    }
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

                // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->first();

                // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                // $val->coupon = [];
                // foreach ($coupons as $coupon) {
                //     $val->coupon[strtolower($coupon->code)] = [
                //         'code' => strtolower($coupon->code),
                //         'value' => $coupon->value,
                //         'start_date' => $coupon->start_date,
                //         'end_date' => $coupon->end_date,
                //     ];
                // }

                $val->discount = null;

                $individualDiscount = Promotion::where('type', 'discount')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('discountRules', function ($query) {
                        $query->where('apply_to', 'individual');
                    })
                    ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                        $query->where('product_id', $val->product_id);
                    })
                    ->with(['discountRules' => function ($query) {
                        $query->where('apply_to', 'individual')
                            ->select('id', 'promotion_id', 'apply_to');
                    }, 'discountRules.individualRules' => function ($query) use ($val) {
                        $query->where('product_id', $val->product_id)
                            ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                    }])
                    ->first();

                if ($individualDiscount) {
                    $discountRule = $individualDiscount->discountRules->first();
                    $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                    if ($individualRule) {
                        $val->discount = (object) [
                            'value' => intval($individualRule->value),
                            'apply_to' => $discountRule->apply_to,
                            'discount_type' => $individualRule->discount_type,
                            'product_price' => $individualRule->product_price,
                            'discount_amount' => $individualRule->discount_amount,
                            'final_price' => $individualRule->final_price,
                            'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                            'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                        ];
                    }
                } else {
                    // If no individual discount, try to fetch discount for group/all products
                    $groupDiscount = Promotion::where('type', 'discount')
                        ->whereDate('start_date', '<=', now())
                        ->whereDate('end_date', '>=', now())
                        ->whereHas('discountRules', function ($query) {
                            $query->where('apply_to', '!=', 'individual');
                        })
                        ->whereHas('discountRules.products', function ($query) use ($val) {
                            $query->where('product_id', $val->product_id);
                        })
                        ->with(['discountRules' => function ($query) {
                            $query->where('apply_to', '!=', 'individual')
                                ->select('id', 'promotion_id', 'percentage', 'apply_to');
                        }])
                        ->first();

                    if ($groupDiscount) {
                        $discountRule = $groupDiscount->discountRules->first();
                        if ($discountRule) {
                            $val->discount = (object) [
                                'value' => intval($discountRule->percentage),
                                'apply_to' => $discountRule->apply_to,
                                'discount_type' => 'percent',
                                'product_price' => null,
                                'discount_amount' => null,
                                'final_price' => null,
                                'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    }
                }

                // Fetch active coupons for the product
                $coupons = Promotion::where('type', 'coupon')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('couponRules.products', function ($query) use ($val) {
                        $query->where('product_id', $val->product_id);
                    })
                    ->with(['couponRules' => function ($query) use ($val) {
                        $query->whereNotNull('coupon_code')
                            ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                            ->with(['products' => function ($subQuery) use ($val) {
                                $subQuery->where('product_id', $val->product_id)
                                        ->select('id', 'coupon_rule_id', 'product_id');
                            }]);
                    }])
                    ->get();

                $val->coupon = [];
                foreach ($coupons as $promotion) {
                    foreach ($promotion->couponRules as $couponRule) {
                        if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                            $val->coupon[strtolower($couponRule->coupon_code)] = [
                                'code' => strtolower($couponRule->coupon_code),
                                'value' => intval($couponRule->percentage),
                                'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    }
                }
            }
        }

        return response()->json($prod);
    }

    public function getExportProducts(Request $request) {
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
                // $val->discount = DiscountProduct::select('value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left');

                // $coupons = DiscountProduct::select('code', 'value', 'start_date', 'end_date')->where('product_id', $val->product_id)->whereNotNull('code')->whereDate('start_date', '<=', now())->whereDate('end_date', '>=', now())->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')->get();
                // $val->coupon = [];
                // foreach ($coupons as $coupon) {
                //     $val->coupon[strtolower($coupon->code)] = [
                //         'code' => strtolower($coupon->code),
                //         'value' => $coupon->value,
                //         'start_date' => $coupon->start_date,
                //         'end_date' => $coupon->end_date,
                //     ];
                // }

                $val->discount = null;

                $individualDiscount = Promotion::where('type', 'discount')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('discountRules', function ($query) {
                        $query->where('apply_to', 'individual');
                    })
                    ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                        $query->where('product_id', $val->product_id);
                    })
                    ->with(['discountRules' => function ($query) {
                        $query->where('apply_to', 'individual')
                            ->select('id', 'promotion_id', 'apply_to');
                    }, 'discountRules.individualRules' => function ($query) use ($val) {
                        $query->where('product_id', $val->product_id)
                            ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'product_price', 'discount_amount', 'final_price');
                    }])
                    ->first();

                if ($individualDiscount) {
                    $discountRule = $individualDiscount->discountRules->first();
                    $individualRule = $discountRule ? $discountRule->individualRules->first() : null;
                    if ($individualRule) {
                        $val->discount = (object) [
                            'value' => intval($individualRule->value),
                            'apply_to' => $discountRule->apply_to,
                            'discount_type' => $individualRule->discount_type,
                            'product_price' => $individualRule->product_price,
                            'discount_amount' => $individualRule->discount_amount,
                            'final_price' => $individualRule->final_price,
                            'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                            'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                        ];
                    }
                } else {
                    // If no individual discount, try to fetch discount for group/all products
                    $groupDiscount = Promotion::where('type', 'discount')
                        ->whereDate('start_date', '<=', now())
                        ->whereDate('end_date', '>=', now())
                        ->whereHas('discountRules', function ($query) {
                            $query->where('apply_to', '!=', 'individual');
                        })
                        ->whereHas('discountRules.products', function ($query) use ($val) {
                            $query->where('product_id', $val->product_id);
                        })
                        ->with(['discountRules' => function ($query) {
                            $query->where('apply_to', '!=', 'individual')
                                ->select('id', 'promotion_id', 'percentage', 'apply_to');
                        }])
                        ->first();

                    if ($groupDiscount) {
                        $discountRule = $groupDiscount->discountRules->first();
                        if ($discountRule) {
                            $val->discount = (object) [
                                'value' => intval($discountRule->percentage),
                                'apply_to' => $discountRule->apply_to,
                                'discount_type' => 'percent',
                                'product_price' => null,
                                'discount_amount' => null,
                                'final_price' => null,
                                'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    }
                }

                // Fetch active coupons for the product
                $coupons = Promotion::where('type', 'coupon')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('couponRules.products', function ($query) use ($val) {
                        $query->where('product_id', $val->product_id);
                    })
                    ->with(['couponRules' => function ($query) use ($val) {
                        $query->whereNotNull('coupon_code')
                            ->select('id', 'promotion_id', 'coupon_code', 'percentage')
                            ->with(['products' => function ($subQuery) use ($val) {
                                $subQuery->where('product_id', $val->product_id)
                                        ->select('id', 'coupon_rule_id', 'product_id');
                            }]);
                    }])
                    ->get();

                $val->coupon = [];
                foreach ($coupons as $promotion) {
                    foreach ($promotion->couponRules as $couponRule) {
                        if ($couponRule->coupon_code && $couponRule->products->isNotEmpty()) {
                            $val->coupon[strtolower($couponRule->coupon_code)] = [
                                'code' => strtolower($couponRule->coupon_code),
                                'value' => intval($couponRule->percentage),
                                'start_date' => $promotion->start_date->format('Y-m-d H:i:s'),
                                'end_date' => $promotion->end_date->format('Y-m-d H:i:s'),
                            ];
                        }
                    }
                }
            }
        return response()->json($products);
    }

    public function getProductSEO(Request $request) {
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
            // $val->discount = DiscountProduct::select(
            //         'ec_discounts.value', 
            //         'ec_discounts.start_date', 
            //         'ec_discounts.end_date',
            //         'ec_discounts.type_option as discount_type' // Critical for frontend calculation
            //     )
            //     ->where('product_id', $val->product_id)
            //     ->whereNull('code') // Auto-discounts only (no coupons)
            //     ->whereDate('start_date', '<=', now())
            //     ->whereDate('end_date', '>=', now())
            //     ->join('ec_discounts', 'ec_discounts.id', '=', 'ec_discount_products.discount_id', 'left')
            //     ->first();

            // // Normalizing the discount type for the frontend
            // // Botble usually stores 'percentage' or 'amount' in type_option
            // if ($val->discount) {
            //     if ($val->discount->discount_type === 'percentage') {
            //         $val->discount->discount_type = 'percent';
            //     }
                
            //     // Ensure value is an integer/float as expected
            //     $val->discount->value = (float)$val->discount->value;
            // }

            $val->discount = null;

            // A. Check Individual Discount
            $individualDiscount = Promotion::where('type', 'discount')
                ->whereDate('start_date', '<=', now())
                ->whereDate('end_date', '>=', now())
                ->whereHas('discountRules', function ($query) {
                    $query->where('apply_to', 'individual');
                })
                ->whereHas('discountRules.individualRules', function ($query) use ($val) {
                    $query->where('product_id', $val->product_id);
                })
                ->with(['discountRules.individualRules' => function ($query) use ($val) {
                    $query->where('product_id', $val->product_id)
                        ->select('discount_rule_id', 'product_id', 'value', 'discount_type', 'final_price', 'product_price');
                }])
                ->first();

            if ($individualDiscount) {
                $rule = $individualDiscount->discountRules->first()->individualRules->first();
                if ($rule) {
                    $val->discount = (object) [
                        'value' => intval($rule->value),
                        'discount_type' => $rule->discount_type,
                        'final_price' => $rule->final_price,
                        // 'product_price' => $rule->product_price, // Optional if needed by frontend
                        'start_date' => $individualDiscount->start_date->format('Y-m-d H:i:s'),
                        'end_date' => $individualDiscount->end_date->format('Y-m-d H:i:s'),
                    ];
                }
            } else {
                $groupDiscount = Promotion::where('type', 'discount')
                    ->whereDate('start_date', '<=', now())
                    ->whereDate('end_date', '>=', now())
                    ->whereHas('discountRules', function ($query) {
                        $query->where('apply_to', '!=', 'individual');
                    })
                    ->whereHas('discountRules.products', function ($query) use ($val) {
                        $query->where('product_id', $val->product_id);
                    })
                    ->with(['discountRules' => function ($query) {
                        $query->select('id', 'promotion_id', 'percentage', 'apply_to');
                    }])
                    ->first();

                if ($groupDiscount) {
                    $rule = $groupDiscount->discountRules->first();
                    if ($rule) {
                        $val->discount = (object) [
                            'value' => intval($rule->percentage),
                            'discount_type' => 'percent',
                            'start_date' => $groupDiscount->start_date->format('Y-m-d H:i:s'),
                            'end_date' => $groupDiscount->end_date->format('Y-m-d H:i:s'),
                        ];
                    }
                }
            }
        }

        return response()->json($products);
    }

    public function bogoProducts(Request $request) {
        try {
            // Fetch active promotions with type 'buy_x_get_y' and join with rules and products
            $promotions = DB::table('promotions')
                ->select(
                    'promotions.id as promotion_id',
                    'promotions.name',
                    'buy_x_get_y_rules.id as rule_id',
                    'buy_x_get_y_rules.buy_quantity',
                    'buy_x_get_y_rules.get_quantity',
                    'buy_x_get_y_products.id as product_rule_id',
                    'buy_x_get_y_products.product_id',
                    'buy_x_get_y_products.type as product_type',
                    'ec_products.name as product_name',
                    'ec_products.price as product_price',
                    'ec_products.image as product_image'
                )
                ->where('promotions.type', 'buy_x_get_y')
                ->where('promotions.start_date', '<=', now())
                ->where('promotions.end_date', '>=', now())
                ->leftJoin('buy_x_get_y_rules', 'promotions.id', '=', 'buy_x_get_y_rules.promotion_id')
                ->leftJoin('buy_x_get_y_products', 'buy_x_get_y_rules.id', '=', 'buy_x_get_y_products.rule_id')
                ->leftJoin('ec_products', 'buy_x_get_y_products.product_id', '=', 'ec_products.id')
                ->get();

            // Handle empty promotions
            if ($promotions->isEmpty()) {
                // \Log::info('No active BOGO promotions found.');
                return response()->json(['bogoProducts' => []], 200);
            }

            // Group promotions by promotion_id and rule_id
            $groupedPromotions = $promotions->groupBy('promotion_id')->map(function ($promoGroup) {
                $firstPromo = $promoGroup->first();
                // Skip if no valid promotion data
                if (!$firstPromo || !isset($firstPromo->name)) {
                    // \Log::warning('Skipping promotion with missing data', ['promoGroup' => $promoGroup]);
                    return [];
                }

                $rules = $promoGroup->groupBy('rule_id')->map(function ($ruleGroup) use ($firstPromo) {
                    $firstRule = $ruleGroup->first();
                    // Skip if no valid rule data
                    if (!$firstRule || !isset($firstRule->rule_id)) {
                        // \Log::warning('Skipping rule with missing data', ['ruleGroup' => $ruleGroup]);
                        return null;
                    }

                    $buyProducts = $ruleGroup->filter(function ($row) {
                        return $row->product_type === 'buy';
                    })->map(function ($row) {
                        return [
                            'product_id' => $row->product_id,
                            'product_name' => $row->product_name ?? 'Unknown',
                            'price' => $row->product_price ?? 0,
                            'image' => $row->product_image ?? '',
                        ];
                    })->values()->toArray();

                    $freeProducts = $ruleGroup->filter(function ($row) {
                        return $row->product_type === 'free';
                    })->map(function ($row) {
                        return [
                            'product_id' => $row->product_id,
                            'product_name' => $row->product_name ?? 'Unknown',
                            'price' => 0,
                            'image' => $row->product_image ?? '',
                            'is_gift' => true,
                            'discount' => null,
                            'coupon' => [],
                            'type' => 'bogo',
                        ];
                    })->values()->toArray();

                    // Handle empty free_products: Copy all buy_products
                    // if (empty($freeProducts) && !empty($buyProducts)) {
                    //     $freeProducts = collect($buyProducts)->map(function ($product) {
                    //         return [
                    //             'product_id' => $product['product_id'],
                    //             'product_name' => $product['product_name'],
                    //             'price' => 0,
                    //             'image' => $product['image'],
                    //             'is_gift' => true,
                    //             'discount' => null,
                    //             'coupon' => [],
                    //         ];
                    //     })->values()->toArray();
                    // }

                    return [
                        'id' => $firstRule->rule_id,
                        'name' => $firstPromo->name,
                        'buy_quantity' => $firstRule->buy_quantity ?? 1,
                        'get_quantity' => $firstRule->get_quantity ?? 1,
                        'buy_products' => $buyProducts,
                        'free_products' => $freeProducts,
                        'selection_rule' => $this->determineSelectionRule($firstRule, $firstPromo->name, !empty($freeProducts)),
                        'campaign' => $firstPromo->name
                            ? str_replace(' ', '_', strtolower($firstPromo->name)) . '_2025_campaign'
                            : 'default_campaign_' . $firstRule->rule_id,
                    ];
                })->filter()->values()->toArray();

                return $rules;
            })->flatten(1)->toArray();

            return response()->json([
                'bogoProducts' => $groupedPromotions,
            ], 200);
        } catch (\Exception $e) {
            \Log::error('Error fetching BOGO products: ' . $e->getMessage(), ['trace' => $e->getTraceAsString()]);
            return response()->json([
                'error' => 'Failed to fetch BOGO products',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function freeGiftProducts(Request $request) {
        $thresholds = DB::table('foc_rules')->where('type', 'foc')->where('start_date', '<=', now())->where('end_date', '>=', now())->join('promotions', 'promotions.id', '=', 'foc_rules.promotion_id')->select('name', 'foc_rules.id', 'min_threshold AS min', 'max_threshold As max')->orderBy('min', 'asc')->get();

        if($thresholds->isEmpty()) {
            return response()->json(['thresholds' => []])->header('Cache-Control', 'public, max-age=0, s-maxage=0')->setEtag(md5(json_encode(['thresholds' => []])));  // Cache 1 Day in the browser, 2 Days at Cloudflare
        }
        foreach ($thresholds as $threshold) {
            $giftData = [];
            $gifts = DB::table('foc_products')->where('foc_rule_id', $threshold->id)->join('ec_products', 'ec_products.id', '=', 'foc_products.product_id')->select('foc_products.product_id', 'ec_products.name', 'ec_products.price', 'ec_products.images')->get();
            foreach ($gifts as $gift) {
                $decodedOnce = is_string($gift->images) ? json_decode($gift->images, true) : $gift->images;

                if (is_string($decodedOnce)) {
                    $images = json_decode($decodedOnce, true);
                } elseif (is_array($decodedOnce)) {
                    $images = $decodedOnce;
                } else {
                    $images = [];
                }

                $firstImage = $images[0] ?? null;
                
                $giftData[] = [
                    'product_id' => $gift->product_id,
                    'product_name' => $gift->name,
                    'price' => 0,
                    'image' => $firstImage,
                    'is_gift' => true,
                    'discount' => null,
                    'coupon' => [],
                    'campaign' => strtolower(str_replace(' ', '_', $threshold->name)).'_'.now()->year.'_campaign',
                    'type' => 'foc',
                ];
            }
            $threshold->gifts = $giftData;
        }

        $response = response()->json(['thresholds' => $thresholds])->header('Cache-Control', 'public, max-age=0, s-maxage=0')->setEtag(md5(json_encode(['thresholds' => $thresholds])));  // Cache 1 Day in the browser, 2 Days at Cloudflare

        if ($response->isNotModified(request())) {
            return $response;
        }

        return $response;
    }

    private function determineSelectionRule($rule, $promotionName, $hasFreeProducts) {
        $buyQty = $rule->buy_quantity ?? 1;
        $getQty = $rule->get_quantity ?? 1;

        if ($buyQty == 1 && $getQty == 1) {
            return 'same_product';
        } elseif ($buyQty == 2 && $getQty == 2) {
            return 'least_expensive';
        } elseif ($buyQty == 4 && $getQty == 1) {
            return $hasFreeProducts ? 'customer_select' : 'least_expensive';
        } elseif ($buyQty > 1 && $getQty == 1) {
            return 'auto_add';
        }

        return 'least_expensive';
    }
}
