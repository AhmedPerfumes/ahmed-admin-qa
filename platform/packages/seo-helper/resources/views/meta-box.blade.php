@php
    $category = \Botble\Ecommerce\Models\ProductCategory::select('ec_product_categories.name')->leftJoin('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id')->where('ec_product_category_product.product_id', $object->id)->where('parent_id', 0)->first();
    $sub_category = \Botble\Ecommerce\Models\ProductCategory::select('ec_product_categories.name')->leftJoin('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id')->where('ec_product_category_product.product_id', $object->id)->where('parent_id', '!=', 0)->first();
    // echo strtolower(implode('-', explode(' ', $category->name))) . strtolower(implode('-', explode(' ', $sub_category->name)));
    // Assets::addScriptsDirectly('vendor/core/packages/slug/js/slug.js')->addStylesDirectly('vendor/core/packages/slug/css/slug.css');
    $prefix = apply_filters(FILTER_SLUG_PREFIX, SlugHelper::getPrefix($object::class), $object);
    $value = $object->slug ?: old('slug');
    $endingURL = SlugHelper::getPublicSingleEndingURL();
    $previewURL = str_replace('--slug--', (string) $value, env('CUSTOM_URL') . $prefix . '/' . config('packages.slug.general.pattern')) . $endingURL;
    // $input_group_text = env('CUSTOM_URL'). $prefix;
    // $data_view = rtrim(str_replace('--slug--', '', env('CUSTOM_URL'). $prefix . '/' . config('packages.slug.general.pattern')), '/') . '/';
    if(!empty($category) && !empty($sub_category)) {
        $previewURL = str_replace('--slug--', (string) $value, env('CUSTOM_URL') . $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $sub_category->name))) .'/'. config('packages.slug.general.pattern')) . $endingURL;
        // $input_group_text = env('CUSTOM_URL'). $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $sub_category->name))). '/';
        // $data_view = rtrim(str_replace('--slug--', '', env('CUSTOM_URL'). $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $sub_category->name))) . '/' . config('packages.slug.general.pattern')), '/') . '/';
    }
@endphp
@push('meta-box-header-seo_wrap')
    <x-core::card.actions>
        <a href="#" class="btn-trigger-show-seo-detail">
            {{ trans('packages/seo-helper::seo-helper.edit_seo_meta') }}
        </a>
    </x-core::card.actions>
@endpush

<div
    @class(['seo-preview', 'noindex' => $meta['index'] === 'noindex'])
    v-pre
>
    <p @class(['default-seo-description', 'hidden' => !empty($object->id)])>
        {{ trans('packages/seo-helper::seo-helper.default_description') }}
    </p>

    <div @class(['existed-seo-meta', 'hidden' => empty($object->id)])>
        @if ($meta['index'] === 'noindex')
            <span class="page-index-status">
                <x-core::icon name="ti ti-search-off" class="text-warning" size="sm" />

                {{ trans('packages/seo-helper::seo-helper.noindex') }}
            </span>
        @endif

        <h4 class="page-title-seo text-truncate">
            {!! BaseHelper::clean($meta['seo_title'] ?? (!empty($object->id) ? $object->name ?? $object->title : null)) !!}
        </h4>

        <div class="page-url-seo">
            {{-- <p>{{ !empty($object->id) && $object->url ? (url(apply_filters(FILTER_SLUG_PREFIX, SlugHelper::getPrefix($object::class), $object)) . '/' . $object->slug) : '-' }}</p> --}}
            <a href="{{ $previewURL }}" target="_blank">{{ $previewURL }}</a>
        </div>

        <div>
            <span style="color: #70757a;">{{ !empty($object->id) && $object->created_at ? $object->created_at->format('M d, Y') : Carbon\Carbon::now()->format('M d, Y') }}
                - </span>
            <span class="page-description-seo">
                @if (!empty($meta['seo_description']))
                    {{ Str::limit(strip_tags($meta['seo_description']), 250) }}
                @elseif ($metaDescription = (!empty($object->id) ? ($object->description ?: ($object->content ?: old('seo_meta.seo_description'))) : old('seo_meta.seo_description')))
                    {{ Str::limit(strip_tags($metaDescription), 250) }}
                @endif
            </span>
        </div>
    </div>
</div>

<div class="hidden seo-edit-section" v-pre>
    <x-core::hr class="my-4" />

    {!! $form !!}
</div>
