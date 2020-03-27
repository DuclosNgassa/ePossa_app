import 'package:epossa_app/model/user_status.dart';

class User {
  String name;
  String phone;
  String password;
  String device;
  UserStatus status;
  double balance;
  int rating;

  User(this.name, this.phone, this.password, this.device, this.status,
      this.balance, this.rating);

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'password': password,
        'device': device,
        'status': convertStatusToString(status),
        'balance': balance.toString(),
        'rating': rating.toString(),
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["name"],
      json["phone"],
      json["password"],
      json["device"],
      convertStringToStatus(json["status"]),
      json["balance"],
      json["rating"],
    );
  }

  static String convertStatusToString(UserStatus value) {
    switch (value) {
      case UserStatus.active:
        {
          return 'active';
        }
        break;
      case UserStatus.blocked:
        {
          return 'blocked';
        }
        break;
    }
    return 'blocked';
  }

  static UserStatus convertStringToStatus(String value) {
    switch (value) {
      case 'active':
        {
          return UserStatus.active;
        }
        break;
      case 'blocked':
        {
          return UserStatus.blocked;
        }
        break;
    }
    return UserStatus.blocked;
  }
}
