class UserPassword {
  String phone;
  String oldPassword;
  String newPassword;

  UserPassword(this.phone, this.oldPassword, this.newPassword);

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };

  factory UserPassword.fromJson(Map<String, dynamic> json) {
    return UserPassword(
      json["phone"],
      json["oldPassword"],
      json["newPassword"],
    );
  }
}
