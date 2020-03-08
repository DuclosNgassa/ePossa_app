import 'package:epossa_app/model/user_status.dart';

class UserDto {
  String name;
  String phone;
  String password;
  String device_token;
  UserStatus status;
  double balance;
  int rating;

  UserDto(this.name, this.phone, this.password, this.device_token, this.status,
      this.balance, this.rating);

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'password': password,
        'device_token': device_token,
        'status': convertStatusToString(status),
        'balance': balance.toString(),
        'rating': rating.toString(),
      };

  Map<String, dynamic> toJsonWithoutId() => {
        'name': name,
        'phone': phone,
        'password': password,
        'device_token': device_token,
        'status': convertStatusToString(status),
        'balance': balance.toString(),
        'rating': rating.toString(),
      };

  @override
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      json["name"],
      json["phone"],
      json["password"],
      json["device_token"],
      convertStringToStatus(json["user_status"]),
      json["balance"],
      json["rating"],
    );
  }

  @override
  Map<String, dynamic> toMap(UserDto user) {
    Map<String, dynamic> params = Map<String, dynamic>();
    params["name"] = user.name;
    params["phone"] = user.phone;
    params["password"] = user.password;
    params["device_token"] = user.device_token;
    params["user_status"] = convertStatusToString(user.status);
    params["balance"] = user.balance.toString();
    params["rating"] = user.rating.toString();

    return params;
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
