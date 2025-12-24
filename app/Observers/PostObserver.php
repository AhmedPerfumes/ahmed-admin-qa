<?php

namespace App\Observers;

// Adjust namespace if your file uses a different one
use Botble\Blog\Models\Post;
use App\Services\NextJsCacheService;

class PostObserver
{
    protected $cacheService;

    public function __construct(NextJsCacheService $cacheService)
    {
        $this->cacheService = $cacheService;
    }

    public function saved(Post $post)
    {
        $this->cacheService->clear(['blogs', 'blogSEO']);
    }

    public function deleted(Post $post)
    {
        $this->cacheService->clear(['blogs', 'blogSEO']);
    }
}