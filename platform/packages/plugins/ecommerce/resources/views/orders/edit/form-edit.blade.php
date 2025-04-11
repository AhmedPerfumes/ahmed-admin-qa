<form action="{{ route('orders.edit', $order->id) }}">
    <x-core::form.textarea
        :label="trans('plugins/ecommerce::order.note')"
        name="description"
        :placeholder="trans('plugins/ecommerce::order.add_note')"
        :value="$order->description"
        class="textarea-auto-height"
    />

    <x-core::button type="button" class="btn-update-order">
        {{ trans('plugins/ecommerce::order.save') }}
    </x-core::button>
</form>
