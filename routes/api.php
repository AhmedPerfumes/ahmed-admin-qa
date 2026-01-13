<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProductCategoryController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\BlogController;
use App\Http\Controllers\Api\ContactController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/ 
// Auth Routes
Route::middleware('customLogs')->group(function () {
    Route::post('/signup', [AuthController::class, 'signup']);

    Route::post('/verifyOTP', [AuthController::class, 'verifyOTP']);

    Route::post('/sendOTP', [AuthController::class, 'sendOTP']);

    Route::post('/signin', [AuthController::class, 'signin']);

    Route::get('/signout', [AuthController::class, 'signout']);

    Route::get('/customer', [AuthController::class, 'getCustomer']);

    // Product Category Routes
    Route::withoutMiddleware('customLogs')->post('/productCategories', [ProductCategoryController::class, 'getProductCategories']);
    Route::withoutMiddleware('customLogs')->post('/productCategoriesTemp', [ProductCategoryController::class, 'getProductCategoriesTemp']);
    Route::withoutMiddleware('customLogs')->post('/productCategorySEO', [ProductCategoryController::class, 'getProductCategorySEO']);

    // Product Routes
    Route::withoutMiddleware('customLogs')->post('/products', [ProductController::class, 'getProducts']);
    Route::post('/products/live-status', [ProductController::class, 'getProductsLiveStatus']);

    // All Product Routes
    Route::withoutMiddleware('customLogs')->post('/allProducts', [ProductController::class, 'getAllProducts']);
    Route::withoutMiddleware('customLogs')->post('/exportProducts', [ProductController::class, 'getExportProducts']);
    Route::withoutMiddleware('customLogs')->post('/productSEO', [ProductController::class, 'getProductSEO']);

    // Order Routes
    Route::post('/storeOrder', [OrderController::class, 'storeOrder']);
    Route::post('/cyberSourcePaymentRedirect', [OrderController::class, 'cyberSourcePaymentRedirect']);
    Route::post('/trackOrder', [OrderController::class, 'trackOrder']);
    Route::post('/orderDetails', [OrderController::class, 'orderDetails']);
    Route::post('/validateCoupon', [OrderController::class, 'validateCoupon']);

    // Blog Routes
    Route::withoutMiddleware('customLogs')->post('/blogs', [BlogController::class, 'getBlogs']);
    Route::withoutMiddleware('customLogs')->post('/getBlogDetails', [BlogController::class, 'getBlogDetails']);
    Route::withoutMiddleware('customLogs')->post('/blogSEO', [BlogController::class, 'getBlogSEO']);

    // Contact Route
    Route::post('/contact', [ContactController::class, 'contact']);
    Route::post('/campaign', [ContactController::class, 'campaign']);

    Route::post('/cyberSource', [OrderController::class, 'GenerateUnifiedCheckoutCaptureContext']);
});
