<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SmsaController;
use App\Http\Controllers\ProductReviewController;

// Define a route group with a prefix
Route::prefix('admin/ecommerce/smsa')->group(function () {
    Route::get('/', [SmsaController::class, 'index'])->name('smsa.index');
    Route::get('/getData', [SmsaController::class, 'getData'])->name('smsa.data');
    Route::get('/edit/{id}', [SmsaController::class, 'edit'])->name('smsa.edit');
    Route::post('/bulkEdit', [SmsaController::class, 'bulkEdit'])->name('smsa.bulk-edit');
    Route::post('/submit', [SmsaController::class, 'submit'])->name('smsa.submit');
    Route::post('/bulkSubmit', [SmsaController::class, 'bulkSubmit'])->name('smsa.bulk-submit');
    Route::post('/bulkPrint', [SmsaController::class, 'bulkPrint'])->name('smsa.bulk-print');
    Route::get('/track/{awb}', [SmsaController::class, 'track'])->name('smsa.track');

    

    
});
Route::get('products/get-for-tag-input', [ProductController::class, 'getForTagInput'])->name('products.get-for-tag-input')->middleware('permission:products.index');

Route::group([ 'prefix' => 'admin', 'middleware' => ['web', 'auth'],], function () {
    Route::resource('product-fragrance-notes', ProductFragranceNoteController::class)->parameters(['product-fragrance-notes' => 'id']);
    Route::delete('product-fragrance-notes/items/destroy', [ProductFragranceNoteController::class, 'destroy'])->name('product-fragrance-notes.deletes');
});

Route::resource('/admin/product-reviews', ProductReviewController::class);
Route::group(['prefix' => 'admin/product-reviews', 'as' => 'product-reviews.', 'middleware' => ['web', 'auth'],], function() {
    Route::get('/', [ProductReviewController::class, 'index'])->name('index');
    Route::get('/{product_review}', [ProductReviewController::class, 'show'])->name('show');
    Route::post('/{product_review}/approve', [ProductReviewController::class, 'approve'])->name('approve');
    Route::delete('/{product_review}', [ProductReviewController::class, 'destroy'])->name('destroy');
});
