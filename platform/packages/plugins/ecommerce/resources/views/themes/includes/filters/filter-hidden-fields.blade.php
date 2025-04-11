@foreach ([
        'layout',
        'page',
        'per-page',
        'sort-by',
        'collection',
    ] as $item)
        <input
            name="{{ $item }}"
            type="hidden"
            class="product-filter-item"
            value="{{ BaseHelper::stringify(request()->input($item)) }}"
        >
@endforeach
