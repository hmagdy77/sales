// To parse this JSON data, do
//
//     final saleryRestModel = saleryRestModelFromJson(jsonString);

import 'dart:convert';

SaleryRestModel saleryRestModelFromJson(String str) =>
    SaleryRestModel.fromJson(json.decode(str));

String saleryRestModelToJson(SaleryRestModel data) =>
    json.encode(data.toJson());

class SaleryRestModel {
  String status;
  List<SalRest> data;

  SaleryRestModel({
    required this.status,
    required this.data,
  });

  factory SaleryRestModel.fromJson(Map<String, dynamic> json) =>
      SaleryRestModel(
        status: json["status"],
        data: List<SalRest>.from(json["data"].map((x) => SalRest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SalRest {
  dynamic sumEmpRest;

  SalRest({
    this.sumEmpRest,
  });

  factory SalRest.fromJson(Map<String, dynamic> json) => SalRest(
        sumEmpRest: json["SUM(emp_rest)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(emp_rest)": sumEmpRest,
      };
}
