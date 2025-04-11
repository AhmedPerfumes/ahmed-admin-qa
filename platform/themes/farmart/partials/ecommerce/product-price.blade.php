<span class="product-price">
    <span class="product-price-sale d-flex align-items-center bb-product-price @if (!$product->isOnSale()) d-none @endif">
        <del aria-hidden="true">
            <span class="price-amount">
                <bdi>
                    <span class="amount bb-product-price-text-old" data-bb-value="product-original-price">{{ format_price($product->price_with_taxes) }}</span>
                </bdi>
            </span>
        </del>
        <ins>
            <span class="price-amount">
                <bdi>
                    <span class="amount bb-product-price-text" data-bb-value="product-price">{{ format_price($product->front_sale_price_with_taxes) }}</span>
                </bdi>
            </span>
        </ins>
    </span>
    <span class="product-price-original @if ($product->isOnSale()) d-none @endif">
        <span class="price-amount">
            <bdi>
                <span class="amount bb-product-price-text" data-bb-value="product-price">{{ format_price($product->front_sale_price_with_taxes) }}</span>
            </bdi>
        </span>
    </span>
</span>
