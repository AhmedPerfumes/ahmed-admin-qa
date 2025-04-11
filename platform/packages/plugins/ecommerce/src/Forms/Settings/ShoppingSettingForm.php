<?php

namespace Botble\Ecommerce\Forms\Settings;

use Botble\Base\Forms\FieldOptions\NumberFieldOption;
use Botble\Base\Forms\FieldOptions\OnOffFieldOption;
use Botble\Base\Forms\FieldOptions\RadioFieldOption;
use Botble\Base\Forms\Fields\NumberField;
use Botble\Base\Forms\Fields\OnOffField;
use Botble\Base\Forms\Fields\RadioField;
use Botble\Ecommerce\Facades\EcommerceHelper;
use Botble\Ecommerce\Http\Requests\Settings\ShoppingSettingRequest;
use Botble\Setting\Forms\SettingForm;

class ShoppingSettingForm extends SettingForm
{
    public function setup(): void
    {
        parent::setup();

        $this
            ->setSectionTitle(trans('plugins/ecommerce::setting.shopping.name'))
            ->setSectionDescription(trans('plugins/ecommerce::setting.shopping.description'))
            ->setValidatorClass(ShoppingSettingRequest::class)
            ->add(
                'shopping_cart_enabled',
                OnOffField::class,
                OnOffFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.enable_cart'))
                    ->value(EcommerceHelper::isCartEnabled())
            )
            ->add(
                'cart_destroy_on_logout',
                OnOffField::class,
                OnOffFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.cart_destroy_on_logout'))
                    ->value(get_ecommerce_setting('cart_destroy_on_logout', false))
            )
            ->add(
                'wishlist_enabled',
                OnOffField::class,
                OnOffFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.enable_wishlist'))
                    ->value(EcommerceHelper::isWishlistEnabled())
            )
            ->addOpenFieldset('wishlist')
            ->add(
                'wishlist_sharing',
                OnOffField::class,
                OnOffFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.enable_wishlist_sharing'))
                    ->collapsible('wishlist_enabled', true, EcommerceHelper::isWishlistEnabled())
                    ->value(EcommerceHelper::isWishlistSharingEnabled())
            )
            ->add(
                'shared_wishlist_lifetime',
                NumberField::class,
                NumberFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.shared_wishlist_lifetime'))
                    ->value(EcommerceHelper::getSharedWishlistLifetime())
                    ->helperText(trans('plugins/ecommerce::setting.shopping.form.shared_wishlist_lifetime_helper'))
            )
            ->addCloseFieldset('wishlist')
            ->add(
                'compare_enabled',
                OnOffField::class,
                OnOffFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.enable_compare'))
                    ->value(EcommerceHelper::isCompareEnabled())
            )
            ->add(
                'order_tracking_enabled',
                OnOffField::class,
                OnOffFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.enable_order_tracking'))
                    ->value(EcommerceHelper::isOrderTrackingEnabled())
            )
            ->add(
                'enable_quick_buy_button',
                OnOffField::class,
                OnOffFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.enable_quick_buy_button'))
                    ->value(EcommerceHelper::isQuickBuyButtonEnabled())
            )
            ->add(
                'order_auto_confirmed',
                OnOffField::class,
                OnOffFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.enable_order_auto_confirmed'))
                    ->value(EcommerceHelper::isOrderAutoConfirmedEnabled())
            )
            ->add(
                'quick_buy_target_page',
                RadioField::class,
                RadioFieldOption::make()
                    ->label(trans('plugins/ecommerce::setting.shopping.form.quick_buy_target'))
                    ->choices([
                        'checkout' => trans('plugins/ecommerce::setting.shopping.form.checkout_page'),
                        'cart' => trans('plugins/ecommerce::setting.shopping.form.cart_page'),
                    ])
                    ->selected(EcommerceHelper::getQuickBuyButtonTarget())
            );
    }
}
