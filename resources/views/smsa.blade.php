@extends($layout ?? BaseHelper::getAdminMasterLayoutTemplate())
@section('content')
    <table id="smsa-table" class="table table-striped table-bordered" style="width: 100%;">
        <thead>
            <tr>
                <th colspan="8" rowspan="1">
                    <button id="create-all" type="button" class="button"><i class="fas fa-box"></i> Create Shipment</button>
                    <button id="print-all" type="button" class="button"><i class="fas fa-print"></i> Print Label</button>
                </th>
            </tr>
            <tr>
                <th><input type="checkbox" id="select-all"></th>
                <th>Order Number</th>
                <th>Customer Name</th>
                <th>Order Date</th>
                <th>Status</th>
                <th>Amount</th>
                <th>AWB</th>
                <th>Action</th>
            </tr>
        </thead>
    </table>


    <form action='{{ route('smsa.bulk-edit') }}' method="post" id="bulk-edit">
        @csrf
        <input type="hidden" name="ids" id="ids">
    </form>

    <form action='{{ route('smsa.bulk-print') }}' method="post" id="bulk-print">
        @csrf
        <input type="hidden" name="awbs" id="awbs">
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#smsa-table').DataTable({
                processing: true,
                serverSide: true,
                ajax: '{{ route('smsa.data') }}',
                columns: [
                    { data: 'check', orderable: false, searchable: false },
                    { data: 'code' },
                    { data: 'customer_name' },
                    { data: 'created_at' },
                    { data: 'statuss' },
                    { data: 'amount' },
                    { data: 'awb' },
                    { data: 'action', orderable: false, searchable: false }
                ]
            });

            $('#select-all').on('click', function() {
                const checked = this.checked;
                $('.row-checkbox').each(function() {
                    this.checked = checked;
                });
            });

            $('#create-all').on('click', function() {
                const checkboxes = document.getElementsByClassName('row-checkbox');
                let isChecked = false;

                // Loop through the checkboxes to see if any are checked
                for (let i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        isChecked = true;
                        break; // Exit the loop if at least one is checked
                    }
                }

                if(!isChecked) {
                    alert('Please Select at Least One Checkbox.');
                    return;
                }

                // Get the selected checkboxes and their values
                let selectedCheckboxes = [];
                for (let i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        selectedCheckboxes.push(checkboxes[i].id);
                    }
                }
                console.log(selectedCheckboxes);
                $('#ids').val(selectedCheckboxes);
                $('#bulk-edit').submit();
            });

            $('#print-all').on('click', function() {
                const checkboxes = document.getElementsByClassName('row-checkbox');
                let isChecked = false;

                // Loop through the checkboxes to see if any are checked
                for (let i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        isChecked = true;
                        break; // Exit the loop if at least one is checked
                    }
                }

                if(!isChecked) {
                    alert('Please Select at Least One Checkbox.');
                    return;
                }

                let selectedAWB = [];
                for (let i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        selectedAWB.push(checkboxes[i].value);
                    }
                }
                console.log(selectedAWB);
                $('#awbs').val(selectedAWB);
                $('#bulk-print').submit();
            });
        });
    </script>
@endsection