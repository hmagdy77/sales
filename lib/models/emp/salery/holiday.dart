// To parse this JSON data, do
//
//     final saleryHolidayModel = saleryHolidayModelFromJson(jsonString);

import 'dart:convert';

SaleryHolidayModel saleryHolidayModelFromJson(String str) =>
    SaleryHolidayModel.fromJson(json.decode(str));

String saleryHolidayModelToJson(SaleryHolidayModel data) =>
    json.encode(data.toJson());

class SaleryHolidayModel {
  String status;
  List<SalHoliday> data;

  SaleryHolidayModel({
    required this.status,
    required this.data,
  });

  factory SaleryHolidayModel.fromJson(Map<String, dynamic> json) =>
      SaleryHolidayModel(
        status: json["status"],
        data: List<SalHoliday>.from(
            json["data"].map((x) => SalHoliday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SalHoliday {
  dynamic sumEmpHoliday;

  SalHoliday({
    this.sumEmpHoliday,
  });

  factory SalHoliday.fromJson(Map<String, dynamic> json) => SalHoliday(
        sumEmpHoliday: json["SUM(emp_holiday)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(emp_holiday)": sumEmpHoliday,
      };
}
