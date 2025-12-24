<?php

namespace App\Observers;

// Verify this namespace matches your actual file in platform/plugins/ecommerce/src/Models/
use Botble\Ecommerce\Models\ProductCategory;
use App\Services\NextJsCacheService;

class ProductCategoryObserver
{
    protected $cacheService;

    public function __construct(NextJsCacheService $cacheService)
    {
        $this->cacheService = $cacheService;
    }

    public function saved(ProductCategory $category)
    {
        $this->handleCache($category);
    }

    public function deleted(ProductCategory $category)
    {
        $this->handleCache($category);
    }

    protected function handleCache(ProductCategory $category)
    {
        $tags = [];

        // LOGIC UPDATE:
        // parent_id == 0  -> Main Category
        // parent_id != 0  -> Sub Category
        
        if ($category->parent_id == 0) {
            // Top-level Category
            $tags = ['categories', 'categorySEO'];
        } else {
            // Subcategory
            $tags = ['subCategories', 'subcategorySEO'];
        }

        $this->cacheService->clear($tags);
    }
}