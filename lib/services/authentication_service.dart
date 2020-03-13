import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:epossa_app/model/user.dart';
import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/services/user_service.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:epossa_app/util/rest_endpoints.dart';

class AuthenticationService {
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  UserService _userService = new UserService();

  Future<User> signin(UserDto userDto) async {
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
      await _sharedPreferenceService.save(USER_PHONE, createdUser.phone);
      await _sharedPreferenceService.save(USER_NAME, createdUser.name);

      return createdUser;
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
    } else {
      throw Exception('Failed to create user. Error: ${response.toString()}');
    }
  }

  Future<bool> login(String phone, String password) async {
    User logedUser = await _userService.readByPhoneNumber(phone);

    if (logedUser == null) {
      return false;
    }
    String hashedPassword = hashPassword(password, logedUser.salt);
    if (hashedPassword == logedUser.password) {
      await _sharedPreferenceService.save(LOGEDIN, "YES");
      await _sharedPreferenceService.save(USER_PHONE, logedUser.phone);
      await _sharedPreferenceService.save(USER_NAME, logedUser.name);

      return true;
    } else {
      return false;
    }
  }

  logout() {
    _sharedPreferenceService.clearForLogOut();
  }

  String hashPassword(String password, String salt) {
    var key = utf8.encode(password);
    var bytes = utf8.encode(salt);

    var hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}
