<?php

namespace Botble\Ecommerce\Models;

use Botble\Base\Models\BaseModel;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class ProductFragranceNote extends BaseModel
{
    protected $table = 'product_fragrance_notes';
    protected $fillable = [
        'itemFamily', 'top_note', 'heart_note', 'base_note', 'top_note_image',
        'heart_note_image', 'base_note_image', 'top_note_description',
        'heart_note_description', 'base_note_description', 'top_note_ar',
        'heart_note_ar', 'base_note_ar', 'top_note_description_ar',
        'heart_note_description_ar', 'base_note_description_ar',
    ];
    
    protected $casts = [
        'status' => \Botble\Base\Enums\BaseStatusEnum::class,
    ];

    public function products(): BelongsToMany
    {
        return $this->belongsToMany(Product::class, 'product_fragrance_map', 'fragrance_note_id', 'product_id');
    }
}