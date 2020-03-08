import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:epossa_app/model/user.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/util/rest_endpoints.dart';
import 'package:http/http.dart' as http;

class UserService {
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  Future<User> create(Map<String, dynamic> params) async {
    final response = await http.post(Uri.encodeFull(URL_USERS), body: params);
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = await json.decode(response.body);
      return convertResponseToUser(responseBody);
    } else {
      throw Exception('Failed to save a User. Error: ${response.toString()}');
    }
  }

  Future<List<User>> readAll() async {
    //Map<String, String> headers = await _sharedPreferenceService.getHeaders();

    //final response = await http.Client().get(URL_USERS, headers: headers);
    final response = await http.Client().get(URL_USERS);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      if (mapResponse["result"] == "ok") {
        final users = mapResponse["data"].cast<Map<String, dynamic>>();
        final userList = await users.map<User>((json) {
          return User.fromJson(json);
        }).toList();
        return userList;
      } else {
        return [];
      }
    } else {
      throw Exception(
          'Failed to load Users from the internet. Error: ${response.toString()}');
    }
  }

  Future<User> readByPhoneNumber(String phoneNumber) async {
    final response = await http.Client().get('$URL_USERS_BY_PHONE$phoneNumber');
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      if (mapResponse["result"] == "ok") {
        return convertResponseToUser(mapResponse);
      } else {
        return null;
      }
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
    } else {
      throw Exception(
          'Failed to readByPhoneNumber from the internet. Error: ${response.toString()}');
    }
  }

  Future<User> update(Map<String, dynamic> params) async {
    //Map<String, String> headers = await _sharedPreferenceService.getHeaders();

/*
    final response = await http.Client()
        .put('$URL_USERS/${params["id"]}', headers: headers, body: params);
*/
    final response =
        await http.Client().put('$URL_USERS/${params["id"]}', body: params);
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = await json.decode(response.body);
      return convertResponseToUserUpdate(responseBody);
    } else {
      throw Exception('Failed to update user. Error: ${response.toString()}');
    }
  }

  Future<bool> delete(int id) async {
    //Map<String, String> headers = await _sharedPreferenceService.getHeaders();

/*
    final response =
    await http.Client().delete('$URL_USERS/$id', headers: headers);
*/
    final response = await http.Client().delete('$URL_USERS/$id');
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = await json.decode(response.body);
      if (responseBody["result"] == "ok") {
        return true;
      }
    } else {
      throw Exception('Failed to delete a user. Error: ${response.toString()}');
    }
  }

  Future<User> convertResponseToUser(Map<String, dynamic> json) async {
    if (json["data"] == null) {
      return null;
    }

//    await _sharedPreferenceService.save(AUTHENTICATION_TOKEN, json["token"]);

    return User(
      json["data"]["id"],
      json["data"]["name"],
      DateTime.parse(json["data"]["created_at"]),
      json["data"]["phone"],
      json["data"]["password"],
      json["data"]["device_token"],
      User.convertStringToStatus(json["data"]["user_status"]),
      json["data"]["balance"],
      json["data"]["rating"],
    );
  }

  Future<User> convertResponseToUserUpdate(Map<String, dynamic> json) async {
    if (json["data"] == null) {
      return null;
    }

//    await _sharedPreferenceService.save(AUTHENTICATION_TOKEN, json["token"]);

    return User(
      json["data"]["id"],
      json["data"]["name"],
      DateTime.parse(json["data"]["created_at"]),
      json["data"]["phone"],
      json["data"]["password"],
      json["data"]["device_token"],
      User.convertStringToStatus(json["data"]["user_status"]),
      double.parse(json["data"]["balance"]),
      int.parse(json["data"]["rating"]),
    );
  }
}
