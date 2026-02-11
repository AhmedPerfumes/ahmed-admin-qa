<?php

namespace Botble\Ecommerce\Models;

use Botble\Base\Models\BaseModel;

class ProductFragranceMap extends BaseModel
{
    protected $table = 'product_fragrance_map';
    public $timestamps = false;
    protected $fillable = ['product_id', 'fragrance_note_id'];
}