import 'package:epossa_app/model/user_status.dart';

class User {
  int id;
  String name;
  DateTime created_at;
  String phone_number = '';
  String password = '';
  String device_token = '';
  UserStatus status;
  int balance;

  User(
      {this.id,
      this.name,
      this.created_at,
      this.phone_number,
      this.password,
      this.device_token,
      this.status,
      this.balance});
}
