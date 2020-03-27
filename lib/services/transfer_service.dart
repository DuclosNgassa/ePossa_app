import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:epossa_app/model/transfer.dart';
import 'package:epossa_app/model/transferDto.dart';
import 'package:epossa_app/model/transfer_bilan.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:epossa_app/util/rest_endpoints.dart';
import 'package:http/http.dart' as http;

class TransferService {
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  Future<Transfer> create(TransferDTO transfer) async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();

    final response = await http.Client()
        .post('$URL_TRANSFERS', body: jsonEncode(transfer), headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      dynamic userDynamic = jsonDecode(response.body);
      Transfer transfer = Transfer.fromJson(userDynamic);
      return transfer;
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
    } else {
      throw Exception(
          'Failed to save a Transfer. Error: ${response.toString()}');
    }
  }

  Future<List<Transfer>> readBySender(String senderPhone) async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();

    List<Transfer> transferList = new List();
    double sumTransferSent = 0.0;
    //final response = await http.Client().get('$URL_TRANSFERS_BY_SENDER$senderPhone');
    final response = await http.Client()
        .get('$URL_TRANSFERS_BY_SENDER$senderPhone', headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> transfers = jsonDecode(response.body);
      transferList = transfers.map<Transfer>((json) {
        Transfer transferMap = Transfer.fromJson(json);
        sumTransferSent += transferMap.amount;
        return transferMap;
      }).toList();
      //save all tranfers sent localy
      await _sharedPreferenceService.save(
          SUM_TRANSFER_SENT, sumTransferSent.toString());

      return transferList;
    } else if (response.statusCode == HttpStatus.notFound) {
      return transferList;
    } else {
      throw Exception('Failed to load Transfers by sender from the internet');
    }
  }

  Future<List<Transfer>> readByReceiver(String receiverPhone) async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();

    List<Transfer> transferList = new List();
    double sumTransferReceived = 0.0;
    //final response = await http.Client().get('$URL_TRANSFERS_BY_RECEIVER$receiverPhone');
    final response = await http.Client()
        .get('$URL_TRANSFERS_BY_RECEIVER$receiverPhone', headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> transfers = jsonDecode(response.body);
      transferList = transfers.map<Transfer>((json) {
        Transfer transferMap = Transfer.fromJson(json);
        sumTransferReceived += transferMap.amount;
        return transferMap;
      }).toList();
      //save all tranfers sent localy
      await _sharedPreferenceService.save(
          SUM_TRANSFER_RECEIVED, sumTransferReceived.toString());

      return transferList;
    } else if (response.statusCode == HttpStatus.notFound) {
      return transferList;
    } else {
      throw Exception('Failed to load Transfers by sender from the internet');
    }
  }

  Future<TransferBilan> getTransferBilan() async {
    //this both calls save sumTransferSent and sumTransferReceived
    String userPhone = await _sharedPreferenceService.read(USER_PHONE);
    await readByReceiver(userPhone);
    await readBySender(userPhone);

    String sumSent = await _sharedPreferenceService.read(SUM_TRANSFER_SENT);
    String sumReceived =
        await _sharedPreferenceService.read(SUM_TRANSFER_RECEIVED);

    TransferBilan transferBilan = TransferBilan();
    transferBilan.sumTransferSent = double.parse(sumSent ?? "0");
    transferBilan.sumTransferReceived = double.parse(sumReceived ?? "0");
    transferBilan.difference =
        transferBilan.sumTransferReceived - transferBilan.sumTransferSent;

    return transferBilan;
  }

  List<Transfer> sortDescending(List<Transfer> transfers) {
    transfers.sort((transfer1, transfer2) =>
        transfer1.created_at.isAfter(transfer2.created_at) ? 0 : 1);

    return transfers;
  }
}
