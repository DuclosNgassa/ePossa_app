import 'dart:async';

import 'package:epossa_app/model/transfer.dart';

class TransferService {
  Future<List<Transfer>> fetchTransfer() async {
    List<Transfer> transferList = new List();

    for (int i = 0; i <= 10; i++) {
      Transfer transfer = new Transfer(
          i,
          new DateTime.now(),
          '0023767655567' + i.toString(),
          '00237654458989' + i.toString(),
          double.parse("1000" + i.toString()),
          'Chausurehvhgvghvhjvjvvhvkvhvhjvjvhvhvhvk jvkjvvkjvhj hgvhvghvhjvjv g ghvjhgvghvhgv  hvhvhvkhvvvzfuozuofu' +
              i.toString());

      transferList.add(transfer);
    }

    return transferList;
  }

  Future<List<Transfer>> fetchReceived() async {
    List<Transfer> transferList = new List();

    for (int i = 0; i <= 10; i++) {
      Transfer transfer = new Transfer(
          i,
          new DateTime.now(),
          '0023767655567' + i.toString(),
          '00237654458989' + i.toString(),
          double.parse("1000" + i.toString()),
          'Chausurehvhgvghvhjvjvvhvkvhvhjvjvhvhvhvk jvkjvvkjvhj ' +
              i.toString());

      transferList.add(transfer);
    }

    return transferList;
  }

  List<Transfer> sortDescending(List<Transfer> transfers) {
    transfers.sort((transfer1, transfer2) =>
        transfer1.created_at.isAfter(transfer2.created_at) ? 0 : 1);

    return transfers;
  }
}
