@extends($layout ?? BaseHelper::getAdminMasterLayoutTemplate())
@section('content')
<div>
    <h2 class="text-center">Tracking Manager</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>AWB</th>
                <th>Reference</th>
                <th>COD Amount</th>
                <th>From</th>
                <th>To</th>
            </tr>    
        </thead>
        <tbody>
            <tr>
                <td>{{ isset($track->AWB) ? $track->AWB : '-' }}</td>
                <td>{{ isset($track->Reference) ? $track->Reference : '-' }}</td>
                <td>{{ isset($track->CODAmount) ? $track->CODAmount : '-' }}</td>
                <td>{{ isset($track->OriginCity) ? $track->OriginCity : '-' }}</td>
                <td>{{ isset($track->DesinationCity) ? $track->DesinationCity : '-' }}</td>
            </tr>
        </tbody>
    </table>

    <h3>Events</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Location</th>
                <th>Status</th>
                <th>Date &amp; Time</th>
            </tr>
        </thead>
        <tbody>
            @if(isset($track->Scans))
            @foreach($track->Scans as $key => $val)
            @php $date = \Carbon\Carbon::parse($val->ScanDateTime); @endphp
                <tr>
                    <td>{{ $val->City }}</td>
                    <td>{{ $val->ScanDescription }}</td>
                    <td>{{ $date->format('d M Y, h:i A') }}</td>
                </tr>
            @endforeach
            @else
                <tr>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                </tr>
            @endif
        </tbody>
    </table>
</div>
@endsection