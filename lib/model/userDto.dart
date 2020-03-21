import 'package:epossa_app/model/user_status.dart';

class UserDto {
  int id;
  String name;
  String phone;
  String password;
  String device;
  UserStatus status;
  double balance;
  int rating;
  String salt;
  String authenticationToken;

  UserDto(this.name, this.phone, this.password, this.device, this.status,
      this.balance, this.rating);

  UserDto.salt(this.name, this.phone, this.password, this.device, this.status,
      this.balance, this.rating, this.salt);

  UserDto.id(this.id, this.name, this.phone, this.password, this.device,
      this.status, this.balance, this.rating, this.authenticationToken);

  UserDto.idSalt(this.id, this.name, this.phone, this.password, this.salt,
      this.device, this.status, this.balance, this.rating);

  UserDto.login(this.phone, this.password);

  UserDto.name(this.name);

  UserDto.phone(this.phone);

  UserDto.password(this.password);

  UserDto.balance(this.balance);

  UserDto.rating(this.rating);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'password': password,
        'device': device,
        'status': convertStatusToString(status),
        'balance': balance.toString(),
        'rating': rating.toString(),
        'salt': salt,
      };

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto.id(
      json["id"],
      json["name"],
      json["phone"],
      json["password"],
      json["device"],
      convertStringToStatus(json["user_status"]),
      json["balance"],
      json["rating"],
      json["authenticationToken"],
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
