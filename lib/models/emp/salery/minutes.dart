// To parse this JSON data, do
//
//     final saleryMinutesModel = saleryMinutesModelFromJson(jsonString);

import 'dart:convert';

SaleryMinutesModel saleryMinutesModelFromJson(String str) =>
    SaleryMinutesModel.fromJson(json.decode(str));

String saleryMinutesModelToJson(SaleryMinutesModel data) =>
    json.encode(data.toJson());

class SaleryMinutesModel {
  String status;
  List<SalMinutes> data;

  SaleryMinutesModel({
    required this.status,
    required this.data,
  });

  factory SaleryMinutesModel.fromJson(Map<String, dynamic> json) =>
      SaleryMinutesModel(
        status: json["status"],
        data: List<SalMinutes>.from(
            json["data"].map((x) => SalMinutes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SalMinutes {
  dynamic sumMinutes;

  SalMinutes({
    this.sumMinutes,
  });

  factory SalMinutes.fromJson(Map<String, dynamic> json) => SalMinutes(
        sumMinutes: json["SUM(minutes)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(minutes)": sumMinutes,
      };
}
