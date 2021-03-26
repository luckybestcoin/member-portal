
@push('css')
<link rel="stylesheet" type="text/css" href="/icon/icofont/css/icofont.css">
@endpush

<div class="info-box mb-3 bg-info">
    <span class="info-box-icon">
        <i class="icofont icofont-ticket"></i>
    </span>
    <div class="info-box-content">
        <span class="info-box-text"><h5>Your PIN</h5></span>
        <span class="info-box-number" id="pin-balance">
        </span>
    </div>
</div>
<div class="info-box mb-3 bg-secondary">
    <div class="row m-2" style="width: 100%">
        <div class="col-lg-12">
            <label>Left Side Turnover</label>
            <h3 class="text-nowrap" id="left-turnover"></h3>
            <hr>
            <label>Right Side Turnover</label>
            <h3 class="text-nowrap" id="right-turnover"></h3>
        </div>
    </div>
</div>

@push('scripts')
<script>
    $(document).ready(function(){
        $.get("/pinbalance", function (result){
            $("#pin-balance").text(result);
        });
        $.get("/turnoverbalance", function (result){
            $("#left-turnover").text(result['left_turnover']);
            $("#right-turnover").text(result['right_turnover']);
        });
    });
</script>
@endpush
