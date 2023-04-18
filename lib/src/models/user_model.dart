import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {required this.uid,
      required this.username,
      required this.email,
      this.phone,
      this.nitCI,
      this.invoiceName,
      this.permissions,
      this.invoices,
      this.photoURL,
      this.createdAt,
      this.updatedAt});

  String uid;
  String username;
  String email;
  String? phone;
  String? nitCI;
  String? invoiceName;
  String? permissions;
  List<dynamic>? invoices;
  String? photoURL;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        nitCI: json["nitCI"],
        phone: json["phone"],
        invoiceName: json["invoiceName"],
        permissions: json['permissions'],
        photoURL: json['photoURL'],
        //invoices: List<dynamic>.from(json["invoices"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "nitCI": nitCI,
        "phone": phone,
        "invoiceName": invoiceName,
        "permissions": permissions,
        "photoURL": photoURL
        //"tickets": List<dynamic>.from(tickets.map((x) => x)),
        //"invoices": List<dynamic>.from(billing.map((x) => x)),
      };
}
