import 'package:epossa_app/model/basis_dto.dart';
import 'package:epossa_app/model/user_status.dart';

class User extends BasisDTO {
  String name;
  String phone;
  String password;
  String device;
  UserStatus status;
  double balance;
  int rating;
  String salt;

  User(id, this.name, created_at, this.phone, this.password, this.device,
      this.status, this.balance, this.rating, this.salt)
      : super(id, created_at);

  @override
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'created_at': created_at.toString(),
        'phone': phone,
        'password': password,
        'device': device,
        'status': convertStatusToString(status),
        'balance': balance.toString(),
        'rating': rating.toString(),
        'salt': salt,
      };

  Map<String, dynamic> toJsonWithoutId() => {
        'name': name,
        'created_at': created_at.toString(),
        'phone': phone,
        'password': password,
        'device': device,
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
      json["phone"],
      json["password"],
      json["device"],
      convertStringToStatus(json["status"]),
      json["balance"],
      json["rating"],
      json["salt"],
    );
  }

  factory User.fromJsonPref(Map<String, dynamic> json) {
    return User(
      int.parse(json["id"]),
      json["name"],
      DateTime.parse(json["created_at"]),
      json["phone"],
      json["password"],
      json["device"],
      convertStringToStatus(json["status"]),
      double.parse(json["balance"]),
      int.parse(json["rating"]),
      json["salt"],
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
