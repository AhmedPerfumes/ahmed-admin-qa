<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

// Models
use Botble\Ecommerce\Models\Product;
use Botble\Ecommerce\Models\ProductCategory;
use Botble\Blog\Models\Post;
use App\Models\Promotion;

// Observers
use App\Observers\ProductObserver;
use App\Observers\ProductCategoryObserver;
use App\Observers\PostObserver;
use App\Observers\PromotionObserver;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Register Product Observer
        if (class_exists(Product::class)) {
            Product::observe(ProductObserver::class);
        }

        // Register Category/Subcategory Observer
        if (class_exists(ProductCategory::class)) {
            ProductCategory::observe(ProductCategoryObserver::class);
        }

        // Register Blog Post Observer
        if (class_exists(Post::class)) {
            Post::observe(PostObserver::class);
        }

        // Register Promotion Observer
        if (class_exists(Promotion::class)) {
            Promotion::observe(PromotionObserver::class);
        }
    }
}