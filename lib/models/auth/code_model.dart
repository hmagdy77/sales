// To parse this JSON data, do
//
//     final codeModel = codeModelFromJson(jsonString);

import 'dart:convert';

CodeModel codeModelFromJson(String str) => CodeModel.fromJson(json.decode(str));

String codeModelToJson(CodeModel data) => json.encode(data.toJson());

class CodeModel {
  CodeModel({
    required this.status,
    required this.data,
  });

  String status;
  List<Code> data;

  factory CodeModel.fromJson(Map<String, dynamic> json) => CodeModel(
        status: json["status"],
        data: List<Code>.from(json["data"].map((x) => Code.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Code {
  Code({
    required this.usersId,
    required this.usersName,
    required this.usersEmail,
    required this.usersCode,
    required this.usersReset,
    required this.usersPhone,
    required this.usersPassword,
    required this.usersApprove,
    required this.usersTime,
  });

  String usersId;
  String usersName;
  String usersEmail;
  String usersCode;
  String usersReset;
  String usersPhone;
  String usersPassword;
  String usersApprove;
  DateTime usersTime;

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        usersId: json["users_id"],
        usersName: json["users_name"],
        usersEmail: json["users_email"],
        usersCode: json["users_code"],
        usersReset: json["users_reset"],
        usersPhone: json["users_phone"],
        usersPassword: json["users_password"],
        usersApprove: json["users_approve"],
        usersTime: DateTime.parse(json["users_time"]),
      );

  Map<String, dynamic> toJson() => {
        "users_id": usersId,
        "users_name": usersName,
        "users_email": usersEmail,
        "users_code": usersCode,
        "users_reset": usersReset,
        "users_phone": usersPhone,
        "users_password": usersPassword,
        "users_approve": usersApprove,
        "users_time": usersTime.toIso8601String(),
      };
}
