class LoginViewModel {
  String phone;
  String password;

  LoginViewModel(this.phone, this.password);

  @override
  Map<String, dynamic> toJson() => {
        'username': phone,
        'password': password,
      };

  @override
  factory LoginViewModel.fromJson(Map<String, dynamic> json) {
    return LoginViewModel(
      json["username"],
      json["password"],
    );
  }
}
