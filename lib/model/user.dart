import 'package:epossa_app/model/basis_dto.dart';
import 'package:epossa_app/model/user_status.dart';

class User extends BasisDTO {
  String name;
  String phone_number;
  String password;
  String device_token;
  UserStatus status;
  double balance;
  int rating;

  User(id, this.name, created_at, this.phone_number,
      this.password, this.device_token, this.status, this.balance, this.rating)
      : super(id, created_at);

  @override
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'created_at': created_at.toString(),
        'phone_number': phone_number,
        'password': password,
        'device_token': device_token,
        'status': convertStatusToString(status),
        'balance': balance.toString(),
        'rating': rating.toString(),
      };

  @override
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["id"],
      json["name"],
      DateTime.parse(json["created_at"]),
      json["phone_number"],
      json["password"],
      json["device_token"],
      convertStringToStatus(json["user_status"]),
      json["balance"],
      json["rating"],
    );
  }

  @override
  Map<String, dynamic> toMap(Object _user){
    User user = _user;
    Map<String, dynamic> params = Map<String, dynamic>();
    params["name"] = user.name;
    params["created_at"] = user.created_at.toString();
    params["phone_number"] = user.phone_number;
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
