import 'package:epossa_app/model/transfer.dart';
import 'dart:async';

class TransferService{

  Future<List<Transfer>> fetchTransfer() async {
    List<Transfer> transferList = new List();

    for (int i = 0; i <= 10; i++) {
      Transfer transfer = new Transfer(
          id: i,
          created_at: new DateTime.now(),
          phone_number_receiver: '0023767655567' + i.toString(),
          phone_number_sender: '002376544590098' + i.toString(),
          amount: 1000 + i,
          description: 'Chausurehvhgvghvhjvjvvhvkvhvhjvjvhvhvhvk jvkjvvkjvhj' + i.toString());

      transferList.add(transfer);
    }

    return transferList;
  }

  Future<List<Transfer>> fetchReceived() async {
    List<Transfer> transferList = new List();

    for (int i = 0; i <= 10; i++) {
      Transfer transfer = new Transfer(
          id: i,
          created_at: new DateTime.now(),
          phone_number_receiver: '0023767655567' + i.toString(),
          phone_number_sender: '00237654458989' + i.toString(),
          amount: 1000 + i,
          description: 'Chausurehvhgvghvhjvjvvhvkvhvhjvjvhvhvhvk jvkjvvkjvhj ' + i.toString());

      transferList.add(transfer);
    }

    return transferList;
  }

  List<Transfer> sortDescending(List<Transfer> transfers){
    transfers.sort((transfer1, transfer2) => transfer1.created_at.isAfter(transfer2.created_at) ? 0 : 1);

    return transfers;
  }

}