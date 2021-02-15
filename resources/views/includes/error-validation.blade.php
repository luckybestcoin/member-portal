@if ($errors->any())
@push('css')
<link rel="stylesheet" type="text/css" href="/assets/icon/icofont/css/icofont.css">
@endpush
<div class="alert alert-danger alert-dismissible">
    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
    <h5><i class="icon fas fa-ban"></i> Error!</h5>
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
