import 'dart:convert';

RegisterModel userFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String userToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.username,
    required this.email,
    required this.pass,
    required this.phone,
  });

  String username;
  String email;
  String phone;
  String pass;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      pass: json["pass"]);

  Map<String, dynamic> toJson() =>
      {"username": username, "email": email, "phone": phone, "pass": pass};
}
