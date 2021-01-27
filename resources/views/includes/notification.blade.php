@if ($notification)
@push('css')
<link rel="stylesheet" type="text/css" href="/assets/icon/icofont/css/icofont.css">
@endpush

<div class="alert alert-{{ $notification['tipe'] }}">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <i class="icofont icofont-close-line-circled"></i>
    </button>
    <ul>
        {!! $notification['pesan'] !!}
    </ul>
</div>
@endif
