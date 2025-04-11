@php
    EcommerceHelper::registerThemeAssets();
    $version = get_cms_version();
    Theme::asset()->add('lightgallery-css', 'vendor/core/plugins/ecommerce/libraries/lightgallery/css/lightgallery.min.css', version: $version);
    Theme::asset()->add('slick-css', 'vendor/core/plugins/ecommerce/libraries/slick/slick.css', version: $version);
    Theme::asset()->container('footer')->add('lightgallery-js', 'vendor/core/plugins/ecommerce/libraries/lightgallery/js/lightgallery.min.js', ['jquery'], version: $version);
    Theme::asset()->container('footer')->add('slick-js', 'vendor/core/plugins/ecommerce/libraries/slick/slick.min.js', ['jquery'], version: $version);

    $galleryStyle = theme_option('ecommerce_product_gallery_image_style', 'vertical');
@endphp

<div class="bb-product-gallery-wrapper">
    <div @class(['bb-product-gallery', 'bb-product-gallery-' . $galleryStyle])>
        <div class="bb-product-gallery-images">
            @if (! empty($product->video))
                @foreach($product->video as $video)
                    @continue(! $video['url'])

                    <div class="bb-product-video">
                        @if ($video['provider'] === 'video')
                            <video
                                id="{{ md5($video['url']) }}"
                                playsinline="playsinline"
                                mute="true"
                                preload="auto"
                                class="media-video"
                                aria-label="{{ $product->name }}"
                                poster="{{ $video['thumbnail'] }}"
                            >
                                <source src="{{ $video['url'] }}" type="video/{{ File::extension($video['url']) ?: 'mp4' }}">
                                <img src="{{ $video['thumbnail'] }}" alt="{{ $video['url'] }}">
                            </video>
                            <button class="bb-button-trigger-play-video" data-target="{{ md5($video['url']) }}">
                                <x-core::icon name="ti ti-player-play-filled" />
                            </button>
                        @else
                            <iframe
                                data-provider="{{ $video['provider'] }}"
                                src="{{ $video['url'] }}"
                                frameborder="0"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
                            </iframe>
                        @endif
                    </div>
                @endforeach
            @endif
            @foreach ($productImages as $image)
                <a href="{{ RvMedia::getImageUrl($image) }}">
                    {{ RvMedia::image($image, $product->name) }}
                </a>
            @endforeach
        </div>
        <div class="bb-product-gallery-thumbnails" data-vertical="{{ $galleryStyle === 'vertical' ? 1 : 0 }}">
            @foreach($product->video as $video)
                @continue(! $video['url'])

                <div class="video-thumbnail">
                    <img src="{{ $video['thumbnail'] }}" alt="{{ $product->name }}">
                    <x-core::icon name="ti ti-player-play-filled" />
                </div>
            @endforeach
            @foreach ($productImages as $image)
                <div>
                    {{ RvMedia::image($image, $product->name, 'thumb') }}
                </div>
            @endforeach
        </div>
    </div>
</div>
