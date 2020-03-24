import 'package:epossa_app/model/user_status.dart';
import 'package:intl/intl.dart';

import 'basis_dto.dart';

class UserDTO extends BasisDTO {
  var formatter = new DateFormat('yyyy-MM-dd HH:mm');
  String name;
  String phone;
  String device;
  UserStatus status;
  double balance;
  int rating;

  UserDTO(id, created_at, this.name, this.phone, this.device, this.status,
      this.balance, this.rating)
      : super(id, created_at);

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': formatter.format(created_at),
        'name': name,
        'phone': phone,
        'device': device,
        'status': convertStatusToString(status),
        'balance': balance.toString(),
        'rating': rating.toString(),
      };

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    var formatterFactory = new DateFormat('yyyy-MM-dd HH:mm');
    return UserDTO(
      json["id"],
      DateTime.parse(
          formatterFactory.format(DateTime.parse(json["created_at"]))),
      json["name"],
      json["phone"],
      json["device"],
      convertStringToStatus(json["status"]),
      json["balance"],
      json["rating"],
    );
  }

  factory UserDTO.fromJsonPref(Map<String, dynamic> json) {
    var formatterFactory = new DateFormat('yyyy-MM-dd HH:mm');
    return UserDTO(
      json["id"],
      DateTime.parse(
          formatterFactory.format(DateTime.parse(json["created_at"]))),
      json["name"],
      json["phone"],
      json["device"],
      convertStringToStatus(json["status"]),
      double.parse(json["balance"]),
      int.parse(json["rating"]),
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
