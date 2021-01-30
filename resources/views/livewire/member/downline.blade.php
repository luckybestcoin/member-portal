<div>
    <!-- page body start -->
    @push('css')
    <!-- list css -->
    <link rel="stylesheet" type="text/css" href="/assets/pages/list-scroll/list.css">
    <link rel="stylesheet" type="text/css" href="/bower_components/stroll/css/stroll.css">
    @endpush
    <div class="page-body">
        <div class="row">
            <div class="col-md-12 text-center ">
                <div>
                    <h4>{{ $data->anggota_nama }}</h4>
                </div>
            </div>
            <div class="col-md-12 col-lg-6">
                <div class="card card-block user-card">
                    <ul class="scroll-list cards" style="height: 500px">
                        @foreach ($data->child_kiri as $i => $row)
                            <li >
                                <a href="javascript:void(0);" wire:click="setMember({{ $row->anggota_id }})">
                                    <h6>{{ ++$i }}. <label class="badge badge-primary">$ {{ number_format($row->paket_harga, 2) }}</label> {{ $row->anggota_uid }} - {{ $row->anggota_nama }} <strong class="pull-right text-right" style="margin-top: -8px">Left : $ {{ number_format($row->omset_kiri - $row->omset_keluar_kiri->sum('omset_keluar_jumlah'), 2) }} <br>Right : $ {{ number_format($row->omset_kanan - $row->omset_keluar_kanan->sum('omset_keluar_jumlah'), 2) }}</strong></h6>
                                </a>
                            </li>
                        @endforeach
                    </ul>
                    <br>
                    <h5 class="text-center">Left Turnover Total : {{ number_format($data->omset_kiri - $data->omset_keluar_kiri->sum('omset_keluar_jumlah'), 2) }}</h5>
                </div>
            </div>
            <div class="col-md-12 col-lg-6">
                <div class="card card-block user-card">
                    <ul class="scroll-list cards" style="height: 500px">
                        @foreach ($data->child_kanan as $i => $row)
                            <li >
                                <a href="javascript:void(0);" wire:click="setMember({{ $row->anggota_id }})">
                                    <h6>{{ ++$i }}. <label class="badge badge-primary">$ {{ number_format($row->paket_harga, 2) }}</label> {{ $row->anggota_uid }} - {{ $row->anggota_nama }} <strong class="pull-right text-right" style="margin-top: -8px">Left : $ {{ number_format($row->omset_kiri - $row->omset_keluar_kiri->sum('omset_keluar_jumlah'), 2) }} <br>Right : $ {{ number_format($row->omset_kanan - $row->omset_keluar_kanan->sum('omset_keluar_jumlah'), 2) }}</strong></h6>
                                </a>
                            </li>
                        @endforeach
                    </ul>
                    <br>
                    <h5 class="text-center">Right Turnover Total : {{ number_format($data->omset_kanan - $data->omset_keluar_kanan->sum('omset_keluar_jumlah'), 2) }}</h5>
                </div>
            </div>
            <div class="col-md-12 text-center">
                <button class="btn btn-warning" wire:click="setMember({{ auth()->id() }})">Reset</button>
            </div>
        </div>
    </div>
    <!-- page body end -->
    @push('scripts')
    <!-- list-scroll js -->
    <script src="/bower_components/stroll/js/stroll.js"></script>
    <script type="text/javascript" src="/assets/pages/list-scroll/list-custom.js"></script>
    <script>
        $(document).ready(function() {
            stroll.bind('.scroll-list');
            var a = $(".cards").height();
            $(".cards").slimScroll({
                height: a,
                allowPageScroll: false,
                color: '#000'
            });
        });

        Livewire.on('reinitialize', () => {
            stroll.bind('.scroll-list');
            var a = $(".cards").height();
            $(".cards").slimScroll({
                height: a,
                allowPageScroll: false,
                color: '#000'
            });
        });
    </script>
    @endpush
</div>
