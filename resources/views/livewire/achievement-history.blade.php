<div>
    <section class="content">
        <div class="container-fluid">
            <div class="card card-default">
                <div class="card-body table-responsive p-1">
                    <table class="table table-hovered">
                        <thead>
                        <tr>
                            <th>Timestamp</th>
                            <th>Achievement</th>
                            <th>Omset</th>
                            <th>Reward</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach ($data as $i => $row)
                            <tr>
                                <td class="align-middle">{{ $row->created_at }}</td>
                                <td class="align-middle">{{ $row->rating->rating_name }}</td>
                                <td class="align-middle text-nowrap text-right">$ {{ number_format($row->rating->rating_min_turnover, 2) }}</td>
                                <td class="align-middle text-nowrap text-right">$ {{ number_format($row->rating->rating_reward, 2) }}</td>
                                <td>{{ $row->process?: "Waiting..." }}</td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</div>
