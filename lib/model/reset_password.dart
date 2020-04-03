class ResetPassword {
  String phone;
  String email;
  String temppassword;

  ResetPassword(this.phone, this.email, this.temppassword);

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'email': email,
        'temppassword': temppassword,
      };

  @override
  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    return ResetPassword(
      json["phone"],
      json["email"],
      json["temppassword"],
    );
  }
}
