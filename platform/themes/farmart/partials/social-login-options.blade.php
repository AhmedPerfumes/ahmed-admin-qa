@if (SocialService::hasAnyProviderEnable())
    <div class="card-social-login-container">
        <div class="social-login-text">
            <div class="login-text">{{ __('Or login with') }}</div>
        </div>
        <div class="card-social-login-content">
            @foreach (SocialService::getProviderKeys() as $item)
                @if (SocialService::getProviderEnabled($item))
                    <a
                        class="sl-button sl-button-{{ $item }} mt-2"
                        href="{{ route('auth.social', array_merge([$item], $params)) }}"
                    >
                        <div class="sl-button-svg-container">
                            <span class="svg-icon">
                                <svg>
                                    <use
                                        href="#svg-icon-sl-{{ $item }}"
                                        xlink:href="#svg-icon-sl-{{ $item }}"
                                    ></use>
                                </svg>
                            </span>
                        </div>
                        <div class="sl-button-label-container">
                            <span>{!! BaseHelper::clean(__('Continue with <strong>:provider</strong>', ['provider' => $item])) !!}</span>
                        </div>
                    </a>
                @endif
            @endforeach
        </div>
    </div>
@endif
