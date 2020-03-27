import 'dart:convert';

import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = Map();
    headers[AUTHORIZATION_TOKEN] = await read(AUTHORIZATION_TOKEN);
    headers[CONTENT_TYPE] = APPLICATION_JSON;

    return headers;
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  saveUser(UserDTO user) async {
    await save(USER_PHONE, user.phone);
    await save(USER_NAME, user.name);
    await save(USER, jsonEncode(user));
  }

  clearForLogOut() async {
    remove(USER_PHONE);
    remove(USER_NAME);
  }
}
