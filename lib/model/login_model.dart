class Login {
  String phone;
  String password;

  Login(this.phone, this.password);

  Map<String, dynamic> toJson() => {
        'username': phone,
        'password': password,
      };

  @override
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      json["username"],
      json["password"],
    );
  }
}
