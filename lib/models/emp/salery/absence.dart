// To parse this JSON data, do
//
//     final saleryAbsenceModel = saleryAbsenceModelFromJson(jsonString);

import 'dart:convert';

SaleryAbsenceModel saleryAbsenceModelFromJson(String str) =>
    SaleryAbsenceModel.fromJson(json.decode(str));

String saleryAbsenceModelToJson(SaleryAbsenceModel data) =>
    json.encode(data.toJson());

class SaleryAbsenceModel {
  String status;
  List<SalAbsence> data;

  SaleryAbsenceModel({
    required this.status,
    required this.data,
  });

  factory SaleryAbsenceModel.fromJson(Map<String, dynamic> json) =>
      SaleryAbsenceModel(
        status: json["status"],
        data: List<SalAbsence>.from(
            json["data"].map((x) => SalAbsence.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SalAbsence {
  dynamic sumEmpAbsence;

  SalAbsence({
    this.sumEmpAbsence,
  });

  factory SalAbsence.fromJson(Map<String, dynamic> json) => SalAbsence(
        sumEmpAbsence: json["SUM(emp_absence)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(emp_absence)": sumEmpAbsence,
      };
}
