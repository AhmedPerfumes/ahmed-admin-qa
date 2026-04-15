<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Botble\Ecommerce\Models\Product;
use Botble\Ecommerce\Models\Customer;

class CashbackProduct extends Model
{
    use HasFactory;

    protected $fillable = ['cashback_rule_id', 'product_id', 'cashback_customer_id'];

    public function cashbackRule() { return $this->belongsTo(CashbackRule::class, 'cashback_rule_id'); }
    public function product() { return $this->belongsTo(Product::class, 'product_id'); }
    public function customer() { return $this->belongsTo(Customer::class, 'cashback_customer_id'); }
}
