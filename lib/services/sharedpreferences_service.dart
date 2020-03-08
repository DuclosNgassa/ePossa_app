import 'package:epossa_app/util/constant_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = Map();
    headers['auth-token'] = await read(AUTHENTICATION_TOKEN);
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

  clearForLogOut() async {
    remove(USER_PHONE);
    remove(USER_NAME);
  }
}
