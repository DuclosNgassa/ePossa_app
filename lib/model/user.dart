import 'package:epossa_app/model/userRole.dart';
import 'package:epossa_app/model/user_status.dart';
import 'package:epossa_app/util/util.dart';

class User {
  String name;
  String phone;
  String password;
  String device;
  UserStatus status;
  UserRole role;
  double balance;
  int rating;

  User(this.name, this.phone, this.password, this.device, this.status,this.role,
      this.balance, this.rating);

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'password': password,
        'device': device,
        'status': Util.convertStatusToString(status),
        'role': Util.convertRoleToString(role),
        'balance': balance.toString(),
        'rating': rating.toString(),
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["name"],
      json["phone"],
      json["password"],
      json["device"],
      Util.convertStringToStatus(json["status"]),
      Util.convertStringToRole(json["role"]),
      json["balance"],
      json["rating"],
    );
  }

}
