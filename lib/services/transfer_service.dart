import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:epossa_app/model/transfer.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:epossa_app/util/rest_endpoints.dart';
import 'package:http/http.dart' as http;

class TransferService {
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  Future<Transfer> create(Map<String, dynamic> params) async {
    final response =
        await http.post(Uri.encodeFull(URL_TRANSFERS), body: params);
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = await json.decode(response.body);
      return convertResponseToTransfer(responseBody);
    } else {
      throw Exception(
          'Failed to save a Transfer. Error: ${response.toString()}');
    }
  }


  Future<List<Transfer>> readAll() async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();

    final response = await http.Client().get(URL_TRANSFERS, headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      if (mapResponse["result"] == "ok") {
        final transfers = mapResponse["data"].cast<Map<String, dynamic>>();
        final transferList = await transfers.map<Transfer>((json) {
          return Transfer.fromJson(json);
        }).toList();
        return transferList;
      } else {
        return [];
      }
    } else {
      throw Exception(
          'Failed to load Transfers from the internet. Error: ${response.toString()}');
    }
  }

  Future<List<Transfer>> readBySender(String senderPhone) async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();

    final response = await http.Client().get('$URL_TRANSFERS_BY_SENDER$senderPhone', headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      if (mapResponse["result"] == "ok") {
        final transfers = mapResponse["data"].cast<Map<String, dynamic>>();
        final transferList = await transfers.map<Transfer>((json) {
          return Transfer.fromJson(json);
        }).toList();
        return transferList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load Transfers by sender from the internet');
    }
  }

  Future<List<Transfer>> readByReceiver(String receiverPhone) async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();

    final response = await http.Client().get('$URL_TRANSFERS_BY_RECEIVER$receiverPhone', headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      if (mapResponse["result"] == "ok") {
        final transfers = mapResponse["data"].cast<Map<String, dynamic>>();
        final transferList = await transfers.map<Transfer>((json) {
          return Transfer.fromJson(json);
        }).toList();
        return transferList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load Transfers by sender from the internet');
    }
  }


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

  Future<Transfer> convertResponseToTransfer(Map<String, dynamic> json) async {
    if (json["data"] == null) {
      return null;
    }

    await _sharedPreferenceService.save(AUTHENTICATION_TOKEN, json["token"]);

    return Transfer(
        json["data"]["id"],
        DateTime.parse(json["data"]["created_at"]),
        json["data"]["phone_number_sender"],
        json["data"]["phone_number_receiver"],
        json["data"]["amount"],
        json["data"]["description"]);
  }

  Future<Transfer> convertResponseToTransferUpdate(
      Map<String, dynamic> json) async {
    if (json["data"] == null) {
      return null;
    }

    await _sharedPreferenceService.save(AUTHENTICATION_TOKEN, json["token"]);

    return Transfer(
      json["data"]["id"],
      DateTime.parse(json["data"]["created_at"]),
      json["data"]["phone_number_sender"],
      json["data"]["phone_number_receiver"],
      double.parse(json["data"]["amount"]),
      json["data"]["description"],
    );
  }
}
