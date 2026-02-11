<?php

namespace Botble\Ecommerce\Models;

use Botble\Base\Models\BaseModel;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CollectionItem extends BaseModel
{
    protected $table = 'ec_collection_items';

    public $timestamps = false;

    protected $fillable = [
        'collection_product_id',
        'child_product_id',
        'custom_item_name',
        'quantity',
        'sort_order',
    ];

    public function childProduct(): BelongsTo
    {
        return $this->belongsTo(Product::class, 'child_product_id');
    }
}