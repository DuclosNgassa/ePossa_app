class PasswordReset {
  String phone;
  String email;
  String temppassword;

  PasswordReset(this.phone, this.email, this.temppassword);

  Map<String, dynamic> toJson() => {
        'username': phone,
        'email': email,
        'temppassword': temppassword,
      };

  @override
  factory PasswordReset.fromJson(Map<String, dynamic> json) {
    return PasswordReset(
      json["username"],
      json["email"],
      json["temppassword"],
    );
  }
}
