import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/model/userPassword.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:epossa_app/util/rest_endpoints.dart';
import 'package:http/http.dart' as http;

class UserService {
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  Future<UserDTO> readByPhoneNumber(String phoneNumber) async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();

    final response = await http.Client()
        .get('$URL_USERS_BY_PHONE$phoneNumber', headers: headers);
    if (response.statusCode == HttpStatus.ok) {
      dynamic userDynamic = jsonDecode(response.body);

      UserDTO user = UserDTO.fromJson(userDynamic);

      // Save user in SharePref
      await _sharedPreferenceService.saveUser(user);

      return user;
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
    } else {
      throw Exception('Failed to load user by phone from the internet');
    }
  }

  Future<UserDTO> update(UserDTO userDto) async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();
    int id = userDto.id;

    final response = await http.Client()
        .put('$URL_USERS/$id', body: jsonEncode(userDto), headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      dynamic userDynamic = jsonDecode(response.body);
      UserDTO user = UserDTO.fromJson(userDynamic);

      await _sharedPreferenceService.saveUser(user);

      return user;
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
    } else {
      throw Exception('Failed to update user. Error: ${response.toString()}');
    }
  }

  Future<bool> changePassword(UserPassword userPassword) async {
    Map<String, String> headers = await _sharedPreferenceService.getHeaders();
    final response = await http.Client().put('$URL_CHANGE_PASSWORD',
        body: jsonEncode(userPassword), headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.notFound) {
      return false;
    } else {
      throw Exception('Failed to update user. Error: ${response.toString()}');
    }
  }

  Future<bool> delete(int id) async {
    final response = await http.Client().delete('$URL_USERS/$id');
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
