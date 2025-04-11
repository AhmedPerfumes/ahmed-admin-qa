<x-core::card.header class="justify-content-between">
    <x-core::card.title>
        {{ trans('plugins/ecommerce::order.order_information') }} {{ $order->code }}
    </x-core::card.title>
    <?php //echo "<pre>"; print_r($order); die; ?>
    {{-- @if ($order->status == 'completed') --}}
        <x-core::badge color="info" class="d-flex align-items-center gap-1">
            <x-core::icon name="ti ti-shopping-cart-check"></x-core::icon>
            {{ $order->status }}
        </x-core::badge>
    {{-- @else
        <x-core::badge color="warning" class="d-flex align-items-center gap-1">
            <x-core::icon name="ti ti-shopping-cart"></x-core::icon>
            {{ trans('plugins/ecommerce::order.uncompleted') }}
        </x-core::badge>
    @endif --}}
</x-core::card.header>
