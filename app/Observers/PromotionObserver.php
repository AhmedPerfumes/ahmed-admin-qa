<?php

namespace App\Observers;

use App\Models\Promotion;
use App\Services\NextJsCacheService;

class PromotionObserver
{
    protected $cacheService;

    public function __construct(NextJsCacheService $cacheService)
    {
        $this->cacheService = $cacheService;
    }

    public function saved(Promotion $promotion)
    {
        // Promotions affect prices, so we must refresh products and gift sets
        $this->cacheService->clear(['products', 'categories', 'subCategories', 'giftSets']);
    }

    public function deleted(Promotion $promotion)
    {
        $this->cacheService->clear(['products', 'categories', 'subCategories', 'giftSets']);
    }
}