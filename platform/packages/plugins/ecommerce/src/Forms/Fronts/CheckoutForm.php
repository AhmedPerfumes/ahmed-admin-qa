<?php

namespace Botble\Ecommerce\Forms\Fronts;

use Botble\Base\Facades\BaseHelper;
use Botble\Base\Facades\Html;
use Botble\Base\Forms\FieldOptions\CheckboxFieldOption;
use Botble\Base\Forms\FieldOptions\HtmlFieldOption;
use Botble\Base\Forms\FieldOptions\TextareaFieldOption;
use Botble\Base\Forms\FieldOptions\TextFieldOption;
use Botble\Base\Forms\Fields\CheckboxField;
use Botble\Base\Forms\Fields\HtmlField;
use Botble\Base\Forms\Fields\TextareaField;
use Botble\Base\Forms\FormAbstract;
use Botble\Ecommerce\Facades\Cart;
use Botble\Ecommerce\Facades\EcommerceHelper;
use Botble\Ecommerce\Http\Requests\SaveCheckoutInformationRequest;
use Closure;
use Illuminate\Support\Arr;

class CheckoutForm extends FormAbstract
{
    public function setup(): void
    {
        $model = $this->getModel();
        $token = $model['token'];

        $this
            ->contentOnly()
            ->setUrl(route('public.checkout.process', $token))
            ->setValidatorClass(SaveCheckoutInformationRequest::class)
            ->formClass('checkout-form payment-checkout-form')
            ->setFormOptions([
                'id' => 'checkout-form',
                'data-update-url' => route('public.ajax.checkout.update'),
            ])
            ->add('checkout-token', 'hidden', TextFieldOption::make()->value($token)->maxLength(0))
            ->addWrapper(
                'main_checkout_product_info',
                '<div class="row" id="main-checkout-product-info">',
                '</div>',
                function (CheckoutForm $form) use ($token, $model) {
                    $form
                        ->addWrapper(
                            'right_column_wrapper',
                            '<div class="col-lg-5 col-md-6 order-1 order-md-2">',
                            '</div>',
                            function (CheckoutForm $form) use ($model) {
                                $form
                                    ->addWrapper(
                                        'right_column_logo_wrapper',
                                        '<div class="d-block d-sm-none">',
                                        '</div>',
                                        fn (CheckoutForm $form) => $form->add(
                                            'right_column_logo',
                                            HtmlField::class,
                                            HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.logo'))
                                        )
                                    )
                                    ->addWrapper(
                                        'right_column_cart_item_wrapper',
                                        '<div class="my-3 bg-light"><div class="position-relative p-3" id="cart-item">',
                                        '</div></div>',
                                        fn (CheckoutForm $form) => $form->add(
                                            'right_column_cart_item',
                                            HtmlField::class,
                                            HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.amount', $model))
                                        )
                                    )
                                    ->addWrapper(
                                        'right_column_discount_wrapper',
                                        '<div class="mt-3 mb-5">',
                                        '</div>',
                                        fn (CheckoutForm $form) => $form->add(
                                            'right_column_discount',
                                            HtmlField::class,
                                            HtmlFieldOption::make()->content(view(EcommerceHelper::viewPath('discounts.partials.form'), ['discounts' => $model['discounts']]))
                                        )
                                    );
                            }
                        )
                        ->addWrapper(
                            'left_column_wrapper',
                            '<div class="form-checkout col-lg-7 col-md-6">',
                            '</div>',
                            function (CheckoutForm $form) use ($token, $model) {
                                $form
                                    ->addWrapper(
                                        'left_column_logo_wrapper',
                                        '<div class="d-none d-sm-block">',
                                        '</div>',
                                        fn (CheckoutForm $form) => $form->add(
                                            'left_column_logo',
                                            HtmlField::class,
                                            HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.logo'))
                                        )
                                    )
                                    ->add(
                                        'filters_ecommerce_checkout_form_before',
                                        HtmlField::class,
                                        HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_before', null, $model['products']))
                                    )
                                    ->when($model['isShowAddressForm'], function (CheckoutForm $form) use ($model, $token) {
                                        $form
                                            ->addWrapper(
                                                'shipping_information_wrapper',
                                                '<div class="mb-4">',
                                                '</div>',
                                                function (CheckoutForm $form) use ($model, $token) {
                                                    $form
                                                        ->add(
                                                            'shipping_information_title',
                                                            HtmlField::class,
                                                            HtmlFieldOption::make()->content('<h5 class="checkout-shipping-information-title">' . __('Shipping information') . '</h5>')
                                                        )
                                                        ->add(
                                                            'save-shipping-information-url',
                                                            'hidden',
                                                            TextFieldOption::make()->attributes(['id' => 'save-shipping-information-url'])->value(route('public.checkout.save-information', $token)),
                                                        )
                                                        ->add(
                                                            'shipping_address_form',
                                                            HtmlField::class,
                                                            HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.address-form', $model))
                                                        );
                                                },
                                            )
                                            ->add(
                                                'filters_ecommerce_checkout_form_after_shipping_address_form',
                                                HtmlField::class,
                                                HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_after_shipping_address_form', null, $model['products']))
                                            );
                                    })
                                    ->when(EcommerceHelper::isBillingAddressEnabled(), function (CheckoutForm $form) use ($model) {
                                        $form
                                            ->addWrapper(
                                                'billing_information_wrapper',
                                                '<div class="mb-4">',
                                                '</div>',
                                                function (CheckoutForm $form) use ($model) {
                                                    $form
                                                        ->add(
                                                            'billing_information_title',
                                                            HtmlField::class,
                                                            HtmlFieldOption::make()->content('<h5 class="checkout-billing-information-title">' . __('Billing information') . '</h5>')
                                                        )
                                                        ->add(
                                                            'billing_address_form',
                                                            HtmlField::class,
                                                            HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.billing-address-form', $model))
                                                        );
                                                }
                                            )
                                            ->add(
                                                'filters_ecommerce_checkout_form_after_billing_address_form',
                                                HtmlField::class,
                                                HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_after_billing_address_form', null, $model['products']))
                                            );
                                    })
                                    ->when(! is_plugin_active('marketplace') && Arr::get($model, 'sessionCheckoutData.is_available_shipping', true), function (CheckoutForm $form) use ($model) {
                                        $form
                                            ->addWrapper(
                                                'shipping_method_wrapper',
                                                '<div class="shipping-method-wrapper mb-4">',
                                                '</div>',
                                                function (CheckoutForm $form) use ($model) {
                                                    $form
                                                        ->add(
                                                            'shipping_method_title',
                                                            HtmlField::class,
                                                            HtmlFieldOption::make()->content('<h5 class="checkout-payment-title">' . __('Shipping method') . '</h5>')
                                                        )
                                                        ->add(
                                                            'shipping_method_loading',
                                                            HtmlField::class,
                                                            HtmlFieldOption::make()->content('<div class="shipping-info-loading loading-spinner" style="display: none;"></div>')
                                                        )
                                                        ->addWrapper(
                                                            'shipping_methods_area_wrapper',
                                                            '<div data-bb-toggle="checkout-shipping-methods-area">',
                                                            '</div>',
                                                            function (CheckoutForm $form) use ($model) {
                                                                $form->add(
                                                                    'shipping_methods',
                                                                    HtmlField::class,
                                                                    HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.shipping-methods', $model))
                                                                );
                                                            }
                                                        );
                                                }
                                            )
                                            ->add(
                                                'filters_ecommerce_checkout_form_after_shipping_method_form',
                                                HtmlField::class,
                                                HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_after_shipping_address_form', null, $model['products']))
                                            );
                                    })
                                    ->add(
                                        'filters_ecommerce_checkout_form_before_payment_form',
                                        HtmlField::class,
                                        HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_before_payment_form', null, $model['products']))
                                    )
                                    ->add(
                                        'amount',
                                        'hidden',
                                        TextFieldOption::make()->value(format_price($model['orderAmount'], null, true)),
                                    )
                                    ->addWrapper(
                                        'payment_methods_wrapper',
                                        '<div data-bb-toggle="checkout-payment-methods-area">',
                                        '</div>',
                                        function (CheckoutForm $form) use ($model) {
                                            $form->add(
                                                'payment_methods',
                                                HtmlField::class,
                                                HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.payment-methods', $model))
                                            );
                                        }
                                    )
                                    ->add(
                                        'filters_ecommerce_checkout_form_after_payment_form',
                                        HtmlField::class,
                                        HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_after_payment_form', null, $model['products']))
                                    )
                                    ->add(
                                        'description',
                                        TextareaField::class,
                                        TextareaFieldOption::make()
                                            ->wrapperAttributes(['class' => 'form-group mb-3'])
                                            ->rows(3)
                                            ->label(__('Order notes'))
                                            ->placeholder(__('Notes about your order, e.g. special notes for delivery.'))
                                    )
                                    ->when(EcommerceHelper::getMinimumOrderAmount() > $model['rawTotal'], function (CheckoutForm $form) {
                                        $form->add(
                                            'minimum_order_amount_alert',
                                            HtmlField::class,
                                            HtmlFieldOption::make()->content('<div role="alert" class="alert alert-warning">' . __('Minimum order amount is :amount, you need to buy more :more to place an order!', ['amount' => format_price(EcommerceHelper::getMinimumOrderAmount()), 'more' => format_price(EcommerceHelper::getMinimumOrderAmount() - Cart::instance('cart')->rawSubTotal())]) . '</div>')
                                        );
                                    })
                                    ->when(EcommerceHelper::isDisplayTaxFieldsAtCheckoutPage(), function (CheckoutForm $form) use ($model) {
                                        $form->add(
                                            'tax_information',
                                            HtmlField::class,
                                            HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.tax-information', $model))
                                        );
                                    })
                                    ->add(
                                        'filters_ecommerce_checkout_form_after_tax_information_form',
                                        HtmlField::class,
                                        HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_after_tax_information_form', null, $model['products']))
                                    )
                                    ->when(theme_option('ecommerce_term_and_privacy_policy_url') ?: theme_option('term_and_privacy_policy_url'), function (CheckoutForm $form, string $privacyPolicyUrl) {
                                        $form->add(
                                            'agree_terms_and_policy',
                                            CheckboxField::class,
                                            CheckboxFieldOption::make()->label(BaseHelper::clean(__(
                                                'I agree to the :link',
                                                ['link' => Html::link($privacyPolicyUrl, __('Terms and Privacy Policy'), attributes: ['class' => 'text-decoration-underline', 'target' => '_blank'])]
                                            ))),
                                        );
                                    })
                                    ->add(
                                        'filters_ecommerce_checkout_form_after',
                                        HtmlField::class,
                                        HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_after', null, $model['products']))
                                    )
                                    ->addWrapper(
                                        'footer_actions_wrapper',
                                        '<div class="w-100 row align-items-center g-3 mb-5">',
                                        '</div>',
                                        function (CheckoutForm $form) use ($model) {
                                            $form
                                                ->addWrapper(
                                                    'footer_actions_left_wrapper',
                                                    '<div class="order-2 order-md-1 col-md-6 text-center text-md-start mb-4 mb-md-0">',
                                                    '</div>',
                                                    function (CheckoutForm $form) use ($model) {
                                                        $form
                                                            ->add(
                                                                'footer_actions_back_to_cart',
                                                                HtmlField::class,
                                                                HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.back-to-cart'))
                                                            )
                                                            ->add(
                                                                'filters_ecommerce_checkout_form_after_back_to_cart_link',
                                                                HtmlField::class,
                                                                HtmlFieldOption::make()->content(apply_filters('ecommerce_checkout_form_after_back_to_cart_link', null, $model['products']))
                                                            );
                                                    }
                                                )
                                                ->addWrapper(
                                                    'footer_actions_right_wrapper',
                                                    '<div class="order-1 order-md-2 col-md-6">',
                                                    '</div>',
                                                    function (CheckoutForm $form) {
                                                        $form->add(
                                                            'footer_actions_checkout',
                                                            HtmlField::class,
                                                            HtmlFieldOption::make()->content(view('plugins/ecommerce::orders.partials.checkout-button'))
                                                        );
                                                    }
                                                );
                                        }
                                    );
                            }
                        );
                }
            );
    }

    protected function addWrapper(string $name, string $open, string $close, Closure $callback): static
    {
        $this->add(
            "open_$name",
            HtmlField::class,
            HtmlFieldOption::make()->content($open)
        );

        $callback($this);

        $this->add(
            "close_$name",
            HtmlField::class,
            HtmlFieldOption::make()->content($close)
        );

        return $this;
    }
}
