import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:epossa_app/model/login_model.dart';
import 'package:epossa_app/model/reset_password.dart';
import 'package:epossa_app/model/user.dart';
import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:epossa_app/util/rest_endpoints.dart';

class AuthenticationService {
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  Future<UserDTO> signin(User user) async {
    HttpClientRequest request =
        await HttpClient().postUrl(Uri.parse('$URL_SIGNIN'))
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(user));
    HttpClientResponse response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      String reply = await response.transform(utf8.decoder).join();
      Map userMap = jsonDecode(reply);
      UserDTO createdUser = UserDTO.fromJson(userMap);
      return createdUser;
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
    } else {
      throw Exception('Failed to create user. Error: ${response.toString()}');
    }
  }

  Future<bool> login(String phone, String password) async {
    Login loginViewModel = new Login(phone, password);
    return await _login(loginViewModel);
  }

  Future<bool> _login(Login loginViewModel) async {
    HttpClientRequest request =
        await HttpClient().postUrl(Uri.parse('$URL_LOGIN'))
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(loginViewModel));
    HttpClientResponse response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      List<String> responseTokens = response.headers[AUTHORIZATION_TOKEN];

      if (responseTokens.length > 0) {
        String jwBearerToken = responseTokens[0];
        _sharedPreferenceService.save(AUTHORIZATION_TOKEN, jwBearerToken);
        return true;
      }
    }
    return false;
  }

  Future<bool> resetPassword(ResetPassword resetPassword) async {
    HttpClientRequest request =
        await HttpClient().putUrl(Uri.parse('$URL_RESET_PASSWORD'))
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(resetPassword));
    HttpClientResponse response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }

  logout() async {
    await _sharedPreferenceService.clearForLogOut();
  }
}
