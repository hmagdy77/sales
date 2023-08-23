// To parse this JSON data, do
//
//     final saleryBounsModel = saleryBounsModelFromJson(jsonString);

import 'dart:convert';

SaleryBounsModel saleryBounsModelFromJson(String str) =>
    SaleryBounsModel.fromJson(json.decode(str));

String saleryBounsModelToJson(SaleryBounsModel data) =>
    json.encode(data.toJson());

class SaleryBounsModel {
  String status;
  List<SalBouns> data;

  SaleryBounsModel({
    required this.status,
    required this.data,
  });

  factory SaleryBounsModel.fromJson(Map<String, dynamic> json) =>
      SaleryBounsModel(
        status: json["status"],
        data:
            List<SalBouns>.from(json["data"].map((x) => SalBouns.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SalBouns {
  dynamic sumBouns;

  SalBouns({
    this.sumBouns,
  });

  factory SalBouns.fromJson(Map<String, dynamic> json) => SalBouns(
        sumBouns: json["SUM(bouns)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(bouns)": sumBouns,
      };
}
