// To parse this JSON data, do
//
//     final saleryExeptModel = saleryExeptModelFromJson(jsonString);

import 'dart:convert';

SaleryExeptModel saleryExeptModelFromJson(String str) =>
    SaleryExeptModel.fromJson(json.decode(str));

String saleryExeptModelToJson(SaleryExeptModel data) =>
    json.encode(data.toJson());

class SaleryExeptModel {
  String status;
  List<SalDiscounT> data;

  SaleryExeptModel({
    required this.status,
    required this.data,
  });

  factory SaleryExeptModel.fromJson(Map<String, dynamic> json) =>
      SaleryExeptModel(
        status: json["status"],
        data: List<SalDiscounT>.from(
            json["data"].map((x) => SalDiscounT.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SalDiscounT {
  dynamic sumExept;

  SalDiscounT({
    this.sumExept,
  });

  factory SalDiscounT.fromJson(Map<String, dynamic> json) => SalDiscounT(
        sumExept: json["SUM(exept)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(exept)": sumExept,
      };
}
