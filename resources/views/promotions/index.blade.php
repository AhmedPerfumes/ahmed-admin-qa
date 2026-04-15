@extends($layout ?? BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1 class="h4">Promotions List</h1>
                <div>
                    <a href="{{ route('promotions.create') }}" class="btn btn-success">Create Promotion</a>
                    <button type="submit" form="bulkDeleteForm" class="btn btn-danger ms-2" id="bulkDeleteBtn" disabled>
                        Delete Selected
                    </button>
                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-body">
                    @if($promotions->isEmpty())
                        <p class="text-muted">No promotions found.</p>
                    @else
                        <!-- Bulk Delete Form -->
                        <form id="bulkDeleteForm" action="{{ route('promotions.bulkDelete') }}" method="POST">
                            @csrf
                            @method('DELETE')
                            <table id="promotionsTable" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" id="selectAll"></th>
                                        <th>Name</th>
                                        <th>Type</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Details</th>
                                        <th>Actions</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($promotions as $promotion)
                                        @php
                                            $isExpired = $promotion->end_date ? \Carbon\Carbon::parse($promotion->end_date)->isPast() : false;
                                            $rowClass = $isExpired ? 'bg-gray text-muted' : '';
                                            $strikeStyle = $isExpired ? 'text-decoration: line-through;' : '';
                                        @endphp
                                        <tr class="{{ $rowClass }}" style="{{ $strikeStyle }}">
                                            <td>
                                                <input type="checkbox" name="ids[]" value="{{ $promotion->id }}" class="selectItem">
                                            </td>
                                            <td>{{ $promotion->name ?? 'N/A' }}</td>
                                            <td>{{ ucfirst($promotion->type ?? 'N/A') }}</td>
                                            <td>{{ $promotion->start_date ? \Carbon\Carbon::parse($promotion->start_date)->format('Y-m-d') : 'N/A' }}</td>
                                            <td>{{ $promotion->end_date ? \Carbon\Carbon::parse($promotion->end_date)->format('Y-m-d') : 'N/A' }}</td>

                                            <td>
                                                @php $type = $promotion->type ?? ''; @endphp

                                                @if($type === 'bogo')
                                                    <strong>BOGO Rules:</strong>
                                                    <ul>
                                                        @foreach($promotion->bogoRules as $rule)
                                                            <li>
                                                                Buy: {{ $rule->buyProduct->name ?? $rule->buy_product_id }},
                                                                Free: {{ $rule->freeProduct->name ?? $rule->free_product_id }}
                                                            </li>
                                                        @endforeach
                                                    </ul>

                                                @elseif($type === 'buy_x_get_y')
                                                    <strong>Buy X Get Y:</strong>
                                                    @foreach($promotion->buyXGetYRules as $rule)
                                                        <p>Buy Quantity: {{ $rule->buy_quantity }}</p>
                                                        <p>Get Quantity: {{ $rule->get_quantity }}</p>
                                                        <p>Products:
                                                            @foreach($rule->products as $p)
                                                                {{ $p->product->name ?? 'N/A' }}@if(!$loop->last), @endif
                                                            @endforeach
                                                        </p>
                                                    @endforeach

                                                @elseif($type === 'discount')
                                                    <strong>Discount:</strong>
                                                    @foreach($promotion->discountRules as $rule)
                                                        <p>Apply To: {{ $rule->apply_to }}</p>
                                                        @if($rule->apply_to === 'group')
                                                            <p>Products:
                                                                @foreach($rule->products as $p)
                                                                    {{ $p->product->name ?? 'N/A' }}@if(!$loop->last), @endif
                                                                @endforeach
                                                            </p>
                                                            <p>
                                                                Value : {{ $rule->discount_type }} {{ $rule->percentage }}%
                                                            </p>
                                                        @elseif($rule->apply_to === 'individual')
                                                            <p>Individual Discounts:</p>
                                                            @foreach($rule->individualRules as $ind)
                                                                <p>{{ $ind->product->name ?? 'N/A' }} - {{ $ind->discount_type }} {{ $ind->value }}</p>
                                                            @endforeach
                                                        @endif
                                                    @endforeach

                                                @elseif($type === 'coupon')
                                                    <strong>Coupon:</strong>
                                                    @foreach($promotion->couponRules as $rule)
                                                        <p>Code: {{ $rule->coupon_code }}</p>
                                                        @if ($rule->coupon_type === 'percent')
                                                        <p>Value: {{ number_format($rule->percentage, 2) }}%</p>
                                                    @else
                                                        <p>Value: {{($rule->amount) }}</p>
                                                    @endif

                                                        
                                                        @if($rule->apply_to === 'group')
                                                            <p>Products:
                                                                @foreach($rule->products as $p)
                                                                    {{ $p->product->name ?? 'N/A' }}@if(!$loop->last), @endif
                                                                @endforeach
                                                            </p>
                                                        
                                                     
                                                         
                                                        @elseif($rule->apply_to === 'customer')
                                                            <p>Customers:
                                                                @foreach($rule->customers as $c)
                                                                    {{ $c->name ?? 'N/A' }}@if(!$loop->last), @endif
                                                                @endforeach
                                                            </p>
                                                        @endif
                                                    @endforeach

                                                @elseif($type === 'cashback')
                                                    <strong>Cashback:</strong>
                                                    @php $rule = $promotion->cashbackRule; @endphp
                                                    @if($rule)
                                                        <p>Product Type: {{ $rule->product_type }}</p>
                                                        @if($rule->product_type === 'group')
                                                            <p>Products:
                                                                @foreach($rule->products as $p)
                                                                    {{ $p->product->name ?? 'N/A' }}@if(!$loop->last), @endif
                                                                @endforeach
                                                            </p>
                                                        @endif
                                                        @php
                                                            $hasPercent = !is_null($rule->cashback_percentage);
                                                            $percentLabel = rtrim(rtrim(number_format((float)($rule->cashback_percentage ?? 0), 2, '.', ''), '0'), '.');
                                                            $amountLabel = rtrim(rtrim(number_format((float)($rule->cashback_amount ?? 0), 2, '.', ''), '0'), '.');
                                                        @endphp
                                                        @if($hasPercent)
                                                            <p>Cashback: {{ $percentLabel }}%</p>
                                                        @else
                                                            <p>Cashback: {{ $amountLabel }}</p>
                                                        @endif
                                                        @if(!empty($rule->duration))
                                                            <p>Duration: {{ $rule->duration }} day(s)</p>
                                                        @endif
                                                    @else
                                                        <p class="text-muted">No cashback rule found.</p>
                                                    @endif

                                                @elseif($type === 'foc')
                                                    <strong>FOC:</strong>
                                                    @foreach($promotion->focRules as $rule)
                                                        <p>Min: {{ $rule->min_threshold }}</p>
                                                        <p>Max: {{ $rule->max_threshold }}</p>
                                                        <p>Products:
                                                            @foreach($rule->products as $p)
                                                                {{ $p->product->name ?? 'N/A' }}@if(!$loop->last), @endif
                                                            @endforeach
                                                        </p>
                                                    @endforeach
                                                @endif
                                            </td>

                                            <td>
                                                <a href="{{ route('promotions.edit', $promotion) }}" class="btn btn-primary btn-sm mb-1">Edit</a>
                                                <button type="button" class="btn btn-danger btn-sm mb-1 deletePromotion" data-id="{{ $promotion->id }}">
                                                    Delete
                                                </button>
                                            </td>

                                            <td>
                                                @if($isExpired)
                                                    <span class="badge bg-red text-white">Expired</span>
                                                @else
                                                    <span class="badge bg-success text-white">Active</span>
                                                @endif
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </form>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Hidden form for single delete -->
<form id="deleteForm" method="POST" style="display:none;">
    @csrf
    @method('DELETE')
</form>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

<script>
$(document).ready(function() {
    $('#promotionsTable').DataTable({"ordering": false});

    function toggleBulkDeleteBtn() {
        let anyChecked = $('.selectItem:checked').length > 0;
        $('#bulkDeleteBtn').prop('disabled', !anyChecked);
    }

    $('#selectAll').on('click', function() {
        $('.selectItem').prop('checked', this.checked);
        toggleBulkDeleteBtn();
    });

    $(document).on('change', '.selectItem', function() {
        toggleBulkDeleteBtn();
    });

    $('#bulkDeleteForm').on('submit', function(e) {
        let count = $('.selectItem:checked').length;
        if(count === 0 || !confirm('Are you sure you want to delete ' + count + ' promotion(s)?')) {
            e.preventDefault();
        }
    });

    // Pass Laravel route for destroy with placeholder
    let destroyUrlTemplate = "{{ route('promotions.destroy', ':id') }}";

    // Single delete
    $(document).on('click', '.deletePromotion', function(e) {
        e.preventDefault();
        let id = $(this).data('id');
        if(confirm('Are you sure you want to delete this promotion?')) {
            let url = destroyUrlTemplate.replace(':id', id);
            $('#deleteForm').attr('action', url).submit();
        }
    });
});
</script>
@endsection
