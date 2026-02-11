@extends(BaseHelper::getAdminMasterLayoutTemplate())
@section('content')
<div class="row">
    <div class="col-md-8">
        {{-- Main Review Details Card --}}
        <x-core::card>
            <x-core::card.header>
                <x-core::card.title>
                    Review Details
                </x-core::card.title>
            </x-core::card.header>
            <x-core::card.body>
                {{-- Star Rating --}}
                <div class="mb-3">
                    <strong>Rating:</strong>
                    <div style="color: #ffb700; font-size: 1.2rem;">
                        @for ($i = 1; $i <= 5; $i++)
                            @if ($i <= $review->star)
                                <i class="ti ti-star-filled"></i>
                            @else
                                <i class="ti ti-star"></i>
                            @endif
                        @endfor
                        <span style="color: #6c757d; font-size: 1rem;">({{ number_format($review->star, 1) }} out of
                            5)</span>
                    </div>
                </div>

                {{-- Review Comment --}}
                <div class="mb-3">
                    <strong>Comment:</strong>
                    <p class="text-muted" style="font-size: 1.1rem; white-space: pre-wrap;">{{ $review->comment }}</p>
                </div>

                <hr>

                {{-- Status --}}
                <strong>Status:</strong>
                {{-- THE FIX: Manually create the badge based on the status text --}}
                @if ($review->status == 'published')
                    <span class="badge bg-success">Published</span>
                @elseif ($review->status == 'pending')
                    <span class="badge bg-warning">Pending</span>
                @else
                    <span class="badge bg-secondary">{{ ucfirst($review->status) }}</span>
                @endif

                {{-- Dates --}}
                <div class="mb-3">
                    <strong>Created At:</strong> {{ BaseHelper::formatDateTime($review->created_at) }}
                </div>

            </x-core::card.body>
        </x-core::card>
    </div>

    <div class="col-md-4">
        {{-- Customer Information Card --}}
        <x-core::card>
            <x-core::card.header>
                <x-core::card.title>
                    Author Information
                </x-core::card.title>
            </x-core::card.header>
            <x-core::card.body>
                <p><strong>Name:</strong> {{ $review->customer_name }}</p>
                <p><strong>Email:</strong> <a
                        href="mailto:{{ $review->customer_email }}">{{ $review->customer_email }}</a></p>
            </x-core::card.body>
        </x-core::card>

        {{-- Product Information Card --}}
        @if ($review->product)
            <x-core::card class="mt-3">
                <x-core::card.header>
                    <x-core::card.title>
                        Product Information
                    </x-core::card.title>
                </x-core::card.header>
                <x-core::card.body>
                    <p>
                        <strong>Name:</strong>
                        <a href="{{ route('products.edit', $review->product->id) }}"
                            target="_blank">{{ $review->product->name }}</a>
                    </p>
                    <p><strong>ID:</strong> {{ $review->product_id }}</p>
                </x-core::card.body>
            </x-core::card>
        @endif

        {{-- Action Card for Approving --}}
        <x-core::card class="mt-3">
            <x-core::card.header>
                <x-core::card.title>
                    Actions
                </x-core::card.title>
            </x-core::card.header>
            <x-core::card.body>
                {{-- Check for any success messages --}}
                @if (session()->has('success_message'))
                    <div class="alert alert-success">
                        {{ session('success_message') }}
                    </div>
                @endif

                {{-- If the review is pending, show the approve button --}}
                @if ($review->status == \Botble\Base\Enums\BaseStatusEnum::PENDING)
                    <p>This review is currently pending approval.</p>
                    <form action="{{ route('product-reviews.approve', $review->id) }}" method="POST">
                        @csrf
                        {{-- Dropdown for selecting coupon --}}
                        <div class="mb-3">
                            <label for="couponId" class="form-label"><strong>Select Coupon:</strong></label>
                            <select name="couponId" id="couponId" class="form-select">
                                <option value="{{ env('REVIEW_COUPON_ID_10') }}" selected>10% Coupon</option>
                                <option value="{{ env('REVIEW_COUPON_ID_15') }}">15% Coupon</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="ti ti-check"></i> Approve Review
                        </button>
                    </form>
                @else
                    <p>This review has been published.</p>
                @endif
            </x-core::card.body>
        </x-core::card>
    </div>
</div>
@stop