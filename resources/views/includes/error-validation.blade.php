@if ($errors->any())
@push('css')
<link rel="stylesheet" type="text/css" href="/assets/icon/icofont/css/icofont.css">
@endpush

<div class="alert alert-danger">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <i class="icofont icofont-close-line-circled"></i>
    </button>
    @if ($errors->count() == 1)
        {!! $errors->first() !!}
    @else
    <ul>
        @foreach ($errors->all() as $error)
        <li>{!! $error !!}</li>
        @endforeach
    </ul>
    @endif
</div>
@endif
