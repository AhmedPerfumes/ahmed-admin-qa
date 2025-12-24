<?php

namespace App\Observers;

use Botble\Ecommerce\Models\Product;
use App\Services\NextJsCacheService;
use Illuminate\Support\Facades\Log;

class ProductObserver
{
    protected $cacheService;

    public function __construct(NextJsCacheService $cacheService)
    {
        $this->cacheService = $cacheService;
    }
    public function updating(Product $product)
    {
        // Check if the name is actually changing
        if ($product->isDirty('name')) {
            // We temporarily store the old name on the object itself
            // getOriginal('name') gives us the name BEFORE the edit
            $product->_temp_old_name = $product->getOriginal('name');
        }
    }

    public function saved(Product $product)
    {
        $this->handleCache($product);
    }

    public function deleted(Product $product)
    {
        $this->handleCache($product);
    }

      // "WARNING: If you change this logic, update the corresponding PHP/JS file."
    protected function generateFrontendSlug($name)
    {
        if (empty($name)) return '';
        $cleaned = str_replace('&amp;', '', $name);
        $cleaned = preg_replace('/[^\w\s-]/', '', $cleaned);
        $cleaned = trim(preg_replace('/\s+/', ' ', $cleaned));
        return strtolower(str_replace(' ', '-', $cleaned));
    }

    protected function handleCache(Product $product)
    {
        $tags = [];

        $newSlug = $this->generateFrontendSlug($product->name);
        
        if ($newSlug) {
            $tags[] = 'product-' . $newSlug;
        }

        if (!empty($product->_temp_old_name)) {
            $oldSlug = $this->generateFrontendSlug($product->_temp_old_name);
            if ($oldSlug && $oldSlug !== $newSlug) {
                $tags[] = 'product-' . $oldSlug;
                Log::info("Detected Name Change: Clearing OLD tag [product-{$oldSlug}] and NEW tag [product-{$newSlug}]");
            }
        }

        if ($product->wasRecentlyCreated || $product->exists === false) { 
             $tags[] = 'products';
        }

        $product->loadMissing('categories');

        foreach ($product->categories as $category) {
            if ($category->parent_id == 0) {
                $tags[] = 'category-' . $category->slug;
            } else {
                $tags[] = 'subcategory-' . $category->slug;
                if ($category->parent) {
                    $tags[] = 'category-' . $category->parent->slug;
                }
            }
        }

        // Debugging Log (Optional: Remove after confirming match)
        Log::info("Clearing Cache for product [{$product->name}]. Related Tags: " . implode(', ', $tags));

        $this->cacheService->clear(array_unique($tags));
    }
}