<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Botble\Ecommerce\Models\Customer;

class CashbackCustomer extends Model
{
    use HasFactory;

    protected $fillable = ['cashback_rule_id', 'customer_id'];

    public function cashbackRule() { return $this->belongsTo(CashbackRule::class, 'cashback_rule_id'); }
    public function customer() { return $this->belongsTo(Customer::class, 'customer_id'); }
}

