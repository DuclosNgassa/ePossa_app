import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:epossa_app/model/user.dart';
import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:epossa_app/util/rest_endpoints.dart';
import 'package:http/http.dart' as http;

class UserService {
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  Future<User> create(UserDto userDto) async {
    //Map<String, String> headers = await _sharedPreferenceService.getHeaders();
    //int id = userDto.id;
    HttpClientRequest request =
        await HttpClient().postUrl(Uri.parse('$URL_USERS'))
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(userDto));
    HttpClientResponse response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      String reply = await response.transform(utf8.decoder).join();
      Map userMap = jsonDecode(reply);
      User createdUser = User.fromJson(userMap);
      //TODO Save user in SharePref
      _sharedPreferenceService.save(USER_PHONE, createdUser.phone);
      _sharedPreferenceService.save(USER_NAME, createdUser.name);

      return createdUser;
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
    } else {
      throw Exception('Failed to create user. Error: ${response.toString()}');
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
    User user = null;
    final response = await http.Client().get('$URL_USERS_BY_PHONE$phoneNumber');
    if (response.statusCode == HttpStatus.ok) {
      dynamic userDynamic = jsonDecode(response.body);
      User user = User.fromJson(userDynamic);
      return user;
    } else if (response.statusCode == HttpStatus.notFound) {
      return user;
    } else {
      throw Exception('Failed to load user by phone from the internet');
    }
  }

  Future<User> update(UserDto userDto) async {
    //Map<String, String> headers = await _sharedPreferenceService.getHeaders();
    int id = userDto.id;
    HttpClientRequest request =
        await HttpClient().putUrl(Uri.parse('$URL_USERS/$id'))
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(userDto));
    HttpClientResponse response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      String reply = await response.transform(utf8.decoder).join();
      //TODO Save user in SharePref
      Map userMap = jsonDecode(reply);
      return User.fromJson(userMap);
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
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
      json["data"]["device"],
      User.convertStringToStatus(json["data"]["user_status"]),
      json["data"]["balance"],
      json["data"]["rating"],
      json["data"]["salt"],
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
      json["data"]["device"],
      User.convertStringToStatus(json["data"]["user_status"]),
      double.parse(json["data"]["balance"]),
      int.parse(json["data"]["rating"]),
      json["data"]["salt"],
    );
  }
}
