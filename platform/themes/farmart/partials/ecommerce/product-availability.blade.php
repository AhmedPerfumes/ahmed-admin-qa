<div class="summary-meta">
    @if ($product->isOutOfStock())
        <div class="product-stock out-of-stock d-inline-block">
            <label>{{ __('Availability') }}:</label> <span>{{ __('Out of stock') }}</span>
        </div>
    @elseif (! $product->with_storehouse_management || $product->quantity < 1)
        <div class="product-stock in-stock d-inline-block">
            <label>{{ __('Availability') }}:</label> <span>{!! BaseHelper::clean($product->stock_status_html) !!}</span>
        </div>
    @elseif ($product->quantity)
        @if (EcommerceHelper::showNumberOfProductsInProductSingle())
            <div class="product-stock in-stock d-inline-block">
                <label>{{ __('Availability') }}:</label>
                <span class="product-quantity-available">
                    @if ($product->quantity != 1)
                        {{ __(':number products available', ['number' => $product->quantity]) }}
                    @else
                        {{ __(':number product available', ['number' => $product->quantity]) }}
                    @endif
                </span>
            </div>
        @else
            <div class="product-stock in-stock d-inline-block">
                <label>{{ __('Availability') }}:</label> <span>{{ __('In stock') }}</span>
            </div>
        @endif
    @endif
</div>
