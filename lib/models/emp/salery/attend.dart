// To parse this JSON data, do
//
//     final saleryAtendModel = saleryAtendModelFromJson(jsonString);

import 'dart:convert';

SaleryAtendModel saleryAtendModelFromJson(String str) =>
    SaleryAtendModel.fromJson(json.decode(str));

String saleryAtendModelToJson(SaleryAtendModel data) =>
    json.encode(data.toJson());

class SaleryAtendModel {
  String status;
  List<SalAttend> data;

  SaleryAtendModel({
    required this.status,
    required this.data,
  });

  factory SaleryAtendModel.fromJson(Map<String, dynamic> json) =>
      SaleryAtendModel(
        status: json["status"],
        data: List<SalAttend>.from(
            json["data"].map((x) => SalAttend.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SalAttend {
  dynamic sumIsExit;

  SalAttend({
    this.sumIsExit,
  });

  factory SalAttend.fromJson(Map<String, dynamic> json) => SalAttend(
        sumIsExit: json["SUM(is_exit)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(is_exit)": sumIsExit,
      };
}
