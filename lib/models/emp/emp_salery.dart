// To parse this JSON data, do
//
//     final empSaleryModel = empSaleryModelFromJson(jsonString);

import 'dart:convert';

EmpSaleryModel empSaleryModelFromJson(String str) =>
    EmpSaleryModel.fromJson(json.decode(str));

String empSaleryModelToJson(EmpSaleryModel data) => json.encode(data.toJson());

class EmpSaleryModel {
  EmpSaleryModel({
    required this.status,
    required this.data,
  });

  String status;
  List<EmpSalery> data;

  factory EmpSaleryModel.fromJson(Map<String, dynamic> json) => EmpSaleryModel(
        status: json["status"],
        data: List<EmpSalery>.from(
            json["data"].map((x) => EmpSalery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EmpSalery {
  EmpSalery({
    required this.monthId,
    required this.empId,
    required this.empName,
    required this.empJop,
    required this.empSal,
    required this.empHours,
    required this.year,
    required this.month,
    required this.minutes,
    required this.minutesRest,
    required this.attend,
    required this.holiday,
    required this.absence,
    required this.payment,
    required this.exept,
    required this.bouns,
  });

  int monthId;
  int empId;
  String empName;
  String empJop;
  int empSal;
  int empHours;
  String year;
  String month;
  int minutes;
  int minutesRest;
  int attend;
  int holiday;
  int absence;
  int payment;
  int exept;
  int bouns;

  factory EmpSalery.fromJson(Map<String, dynamic> json) => EmpSalery(
        monthId: json["month_id"],
        empId: json["emp_id"],
        empName: json["emp_name"],
        empJop: json["emp_jop"],
        empSal: json["emp_sal"],
        empHours: json["emp_hours"],
        year: json["year"],
        month: json["month"],
        minutes: json["minutes"],
        minutesRest: json["minutes_rest"],
        attend: json["attend"],
        holiday: json["holiday"],
        absence: json["absence"],
        payment: json["payment"],
        exept: json["exept"],
        bouns: json["bouns"],
      );

  Map<String, dynamic> toJson() => {
        "month_id": monthId,
        "emp_id": empId,
        "emp_name": empName,
        "emp_jop": empJop,
        "emp_sal": empSal,
        "emp_hours": empHours,
        "year": year,
        "month": month,
        "minutes": minutes,
        "minutes_rest": minutesRest,
        "attend": attend,
        "holiday": holiday,
        "absence": absence,
        "payment": payment,
        "exept": exept,
        "bouns": bouns,
      };
}
