<?php

namespace Botble\Ecommerce\Http\Requests;

use Botble\Payment\Enums\PaymentMethodEnum;
use Botble\Payment\Enums\PaymentStatusEnum;
use Botble\Support\Http\Requests\Request;
use Illuminate\Validation\Rule;

class MarkOrderAsCompletedRequest extends Request
{
    public function rules(): array
    {
        return [
            'payment_method' => ['required', 'string', Rule::in(PaymentMethodEnum::values())],
            'payment_status' => ['required', 'string', Rule::in(PaymentStatusEnum::values())],
            'transaction_id' => [Rule::when(
                in_array(
                    $this->input('payment_method'),
                    [PaymentMethodEnum::COD, PaymentMethodEnum::BANK_TRANSFER]
                ),
                'nullable',
                'required'
            )],
        ];
    }
}
