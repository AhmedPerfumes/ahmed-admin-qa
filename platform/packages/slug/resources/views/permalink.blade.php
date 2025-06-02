@php
    $category = \Botble\Ecommerce\Models\ProductCategory::select('ec_product_categories.name')->leftJoin('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id')->where('ec_product_category_product.product_id', $model->id)->where('parent_id', 0)->first();
    $sub_category = \Botble\Ecommerce\Models\ProductCategory::select('ec_product_categories.name')->leftJoin('ec_product_category_product', 'ec_product_category_product.category_id', '=', 'ec_product_categories.id')->where('ec_product_category_product.product_id', $model->id)->where('parent_id', '!=', 0)->first();
    // echo strtolower(implode('-', explode(' ', $category->name))) . strtolower(implode('-', explode(' ', $sub_category->name)));
    Assets::addScriptsDirectly('vendor/core/packages/slug/js/slug.js')->addStylesDirectly('vendor/core/packages/slug/css/slug.css');
    $prefix = apply_filters(FILTER_SLUG_PREFIX, SlugHelper::getPrefix($model::class), $model);
    $value = $value ?: old('slug');
    $endingURL = SlugHelper::getPublicSingleEndingURL();
    $previewURL = str_replace('--slug--', (string) $value, env('CUSTOM_URL') . $prefix . '/' . config('packages.slug.general.pattern')) . $endingURL . (Auth::user() && $preview ? '?preview=true' : '');
    $input_group_text = env('CUSTOM_URL'). $prefix;
    $data_view = rtrim(str_replace('--slug--', '', env('CUSTOM_URL'). $prefix . '/' . config('packages.slug.general.pattern')), '/') . '/';
    //echo $model;
    if(!empty($category) && isset($model->slugable) && $model->slugable->prefix != 'blog') {
        if($category->name == 'Online Exclusive') {
            //echo ";;;";
            //echo $category;
            $previewURL = str_replace('--slug--', (string) $value, env('CUSTOM_URL') . $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. config('packages.slug.general.pattern')) . $endingURL . (Auth::user() && $preview ? '?preview=true' : '');
            $input_group_text = env('CUSTOM_URL'). $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $category->name))). '/';
            $data_view = rtrim(str_replace('--slug--', '', env('CUSTOM_URL'). $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $category->name))) . '/' . config('packages.slug.general.pattern')), '/') . '/';
        } elseif ($category->name == 'Hair Mist') {
            //echo ";;;";
            //echo $category;
            $previewURL = str_replace('--slug--', (string) $value, env('CUSTOM_URL') . $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. config('packages.slug.general.pattern')) . $endingURL . (Auth::user() && $preview ? '?preview=true' : '');
            $input_group_text = env('CUSTOM_URL'). $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $category->name))). '/';
            $data_view = rtrim(str_replace('--slug--', '', env('CUSTOM_URL'). $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $category->name))) . '/' . config('packages.slug.general.pattern')), '/') . '/';
        } else {
            //echo ";;;";
            //echo $category;
            $previewURL = str_replace('--slug--', (string) $value, env('CUSTOM_URL') . $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $sub_category->name))) .'/'. config('packages.slug.general.pattern')) . $endingURL . (Auth::user() && $preview ? '?preview=true' : '');
            $input_group_text = env('CUSTOM_URL'). $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $sub_category->name))). '/';
            $data_view = rtrim(str_replace('--slug--', '', env('CUSTOM_URL'). $prefix .'/'. strtolower(implode('-', explode(' ', $category->name))) .'/'. strtolower(implode('-', explode(' ', $sub_category->name))) . '/' . config('packages.slug.general.pattern')), '/') . '/';
        }
    }
@endphp

<div
    class="slug-field-wrapper"
    data-field-name="{{ SlugHelper::getColumnNameToGenerateSlug($model) }}"
>
    @if (in_array(
        Route::currentRouteName(), ['pages.create', 'pages.edit'])
        && BaseHelper::isHomepage(Route::current()->parameter('page.id'))
    )
        <x-core::form.text-input
            :label="trans('core/base::forms.permalink')"
            name="slug"
            :group-flat="true"
            :value="BaseHelper::getHomepageUrl()"
            :readonly="true"
        />
    @else
        <x-core::form.text-input
            :label="trans('core/base::forms.permalink')"
            :required="true"
            name="slug"
            :group-flat="true"
            class="ps-0"
            :value="$value"
        >
            <x-slot:prepend>
                <span class="input-group-text">
                    {{ $input_group_text }}/
                </span>
            </x-slot:prepend>

            <x-slot:append>
                <span class="input-group-text slug-actions">
                    <a
                        href="#"
                        @class(['link-secondary', 'd-none' => ! $value])
                        data-bs-toggle="tooltip"
                        aria-label="{{ trans('packages/slug::slug.generate_url') }}"
                        data-bs-original-title="{{ trans('packages/slug::slug.generate_url') }}"
                        data-bb-toggle="generate-slug"
                    >
                        <x-core::icon name="ti ti-wand" />
                    </a>
                </span>
            </x-slot:append>
        </x-core::form.text-input>
        @if (Auth::user() && $id && is_in_admin(true))
            <x-core::form.helper-text class="mt-n2 text-truncate">
                {{ trans('packages/slug::slug.preview') }}: <a href="{{ $previewURL }}" target="_blank">{{ $previewURL }}</a>
            </x-core::form.helper-text>
        @endif
        @if ($editable)
            <input
                class="slug-current"
                name="{{ $name }}"
                type="hidden"
                value="{{ $value }}"
            >
            <div
                class="slug-data"
                data-url="{{ route('slug.create') }}"
                data-view="{{ $data_view }}"
                data-id="{{ $id ?: 0 }}"
            ></div>
            <input
                name="slug_id"
                type="hidden"
                value="{{ $id ?: 0 }}"
            >
            <input
                name="is_slug_editable"
                type="hidden"
                value="1"
            >
        @endif
    @endif
</div>
