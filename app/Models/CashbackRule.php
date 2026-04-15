<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CashbackRule extends Model
{
    use HasFactory;

    protected $fillable = [
        'promotion_id', 'customer_type', 'product_type',
        'cashback_percentage', 'cashback_amount','duration',
    ];

    public function promotion() { return $this->belongsTo(Promotion::class); }
    public function customers() { return $this->hasMany(CashbackCustomer::class, 'cashback_rule_id'); }
    public function products() { return $this->hasMany(CashbackProduct::class, 'cashback_rule_id'); }
}

