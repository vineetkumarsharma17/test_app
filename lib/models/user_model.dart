// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? userToken;
  final String? id;
  final String? name;
  final String? mobile;
  final String? email;

  User({
    this.userToken,
    this.id,
    this.name,
    this.mobile,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userToken: json["user_token"],
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "user_token": userToken,
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
      };
}
