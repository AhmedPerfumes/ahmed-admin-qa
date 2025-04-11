<?php

namespace Botble\Ecommerce\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MobileVerification extends Model
{
    use HasFactory;

    protected $table = 'ec_mobile_verification';

    protected $fillable = [
        'otp',
        'phone',
    ];
}
