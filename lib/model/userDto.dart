import 'package:epossa_app/model/userRole.dart';
import 'package:epossa_app/model/user_status.dart';
import 'package:epossa_app/util/util.dart';
import 'package:intl/intl.dart';

import 'basis_dto.dart';

class UserDTO extends BasisDTO {
  var formatter = new DateFormat('yyyy-MM-dd HH:mm');
  var birthdateformatter = new DateFormat('yyyy-MM-dd');
  String name;
  String email;
  String phone;
  String device;
  UserStatus status;
  double balance;
  int rating;

  UserDTO(id, created_at, this.name, this.email, this.phone, this.device, this.status,
      this.balance, this.rating)
      : super(id, created_at);

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': formatter.format(created_at),
        'name': name,
        'email': email,
        'phone': phone,
        'device': device,
        'status': Util.convertStatusToString(status),
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
      json["email"],
      json["phone"],
      json["device"],
      Util.convertStringToStatus(json["status"]),
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
      json["email"],
      json["phone"],
      json["device"],
      Util.convertStringToStatus(json["status"]),
      double.parse(json["balance"]),
      int.parse(json["rating"]),
    );
  }


}
