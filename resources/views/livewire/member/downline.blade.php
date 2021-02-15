<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 text-center">
                    <label>{{ $data->anggota_nama }}</label>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Left Side</h3>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table class="table table-striped table-valign-middle">
                                <thead>
                                    <tr>
                                        <th>UID</th>
                                        <th>Name</th>
                                        <th>Package</th>
                                        <th colspan="2">Turnover <small>Left | Right</small></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($data->child_kiri as $item)
                                    <tr>
                                        <td class="text-unwrap">{{ $item->anggota_uid }}</td>
                                        <td class="text-unwrap">{{ $item->anggota_nama }}</td>
                                        <td class="text-right text-unwrap">$ {{ $item->paket->paket_nama." ".number_format($row->paket_harga, 2) }}</td>
                                        <td class="text-right text-unwrap">$ {{ number_format($row->omset_kiri - $row->omset_keluar_kiri->sum('omset_keluar_jumlah'), 2) }}</td>
                                        <td class="text-right text-unwrap">$ {{ number_format($row->omset_kanan - $row->omset_keluar_kanan->sum('omset_keluar_jumlah'), 2) }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer clearfix">
                            <label class="float-right ">$ {{ number_format($data->omset_kanan - $data->omset_keluar_kanan->sum('omset_keluar_jumlah'), 2) }}</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Right Side</h3>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table class="table table-striped table-valign-middle">
                                <thead>
                                    <tr>
                                        <th>UID</th>
                                        <th>Name</th>
                                        <th>Package</th>
                                        <th colspan="2">Turnover <small>Left | Right</small></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($data->child_kiri as $item)
                                    <tr>
                                        <td class="text-unwrap">{{ $item->anggota_uid }}</td>
                                        <td class="text-unwrap">{{ $item->anggota_nama }}</td>
                                        <td class="text-right text-unwrap">$ {{ $item->paket->paket_nama." ".number_format($row->paket_harga, 2) }}</td>
                                        <td class="text-right text-unwrap">$ {{ number_format($row->omset_kiri - $row->omset_keluar_kiri->sum('omset_keluar_jumlah'), 2) }}</td>
                                        <td class="text-right text-unwrap">$ {{ number_format($row->omset_kanan - $row->omset_keluar_kanan->sum('omset_keluar_jumlah'), 2) }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer clearfix">
                            <label class="float-right ">$ {{ number_format($data->omset_kanan - $data->omset_keluar_kanan->sum('omset_keluar_jumlah'), 2) }}</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
