<div>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="ml-2">History</h4>
                            <hr>
                            <table class="w-100">
                                @foreach ($history as $item)
                                <tr>
                                    <td>
                                        {{ $item->created_at }}
                                    </td>
                                    <td>
                                        {{ $item->transaction? $item->transacttion->transaction_information: '' }}
                                    </td>
                                    <td>
                                        {{ $item->transaction_exchange_type }}
                                    </td>
                                    <td class="text-right">
                                        {{ $item->transaction_exchange_amount }}
                                    </td>
                                </tr>
                                @endforeach
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
