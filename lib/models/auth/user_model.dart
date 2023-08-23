// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.data,
  });

  String status;
  List<User> data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class User {
  User({
    required this.userId,
    required this.userName,
    required this.userPassword,
    required this.userAdmin,
    required this.userTime,
  });

  int userId;
  String userName;
  String userPassword;
  int userAdmin;
  DateTime userTime;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userPassword: json["user_password"],
        userAdmin: json["user_admin"],
        userTime: DateTime.parse(json["user_time"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_password": userPassword,
        "user_admin": userAdmin,
        "user_time": userTime.toIso8601String(),
      };
}
