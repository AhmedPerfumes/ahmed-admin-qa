<?php

namespace Botble\SimpleSlider\Models;

use Botble\Base\Casts\SafeContent;
use Botble\Base\Models\BaseModel;

class SimpleSliderItem extends BaseModel
{
    protected $table = 'simple_slider_items';

    protected $fillable = [
        'title',
        'description',
        'link',
        'image',
        'order',
        'season',
        'sub_title',
        'simple_slider_id',
        'type',
        'color'
    ];

    protected $casts = [
        'title' => SafeContent::class,
        'description' => SafeContent::class,
        'link' => SafeContent::class,
        'sub_title' => SafeContent::class,
        'season' => SafeContent::class,
    ];

    protected static function booted(): void
    {
        static::deleted(function (SimpleSliderItem $item) {
            $item->metadata()->delete();
        });
    }
}
