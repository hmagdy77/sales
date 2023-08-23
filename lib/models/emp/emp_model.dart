// To parse this JSON data, do
//
//     final empModel = empModelFromJson(jsonString);

import 'dart:convert';

EmpModel empModelFromJson(String str) => EmpModel.fromJson(json.decode(str));

String empModelToJson(EmpModel data) => json.encode(data.toJson());

class EmpModel {
  EmpModel({
    required this.status,
    required this.data,
  });

  String status;
  List<Emp> data;

  factory EmpModel.fromJson(Map<String, dynamic> json) => EmpModel(
        status: json["status"],
        data: List<Emp>.from(json["data"].map((x) => Emp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Emp {
  Emp({
    required this.empId,
    required this.empName,
    required this.empTel1,
    required this.empTel2,
    required this.empBirth,
    required this.empNatid,
    required this.empAddress,
    required this.empJop,
    required this.empWorkStart,
    required this.empWorkEnd,
    required this.empStopped,
    required this.empSal,
    required this.empHours,
  });

  int empId;
  String empName;
  String empTel1;
  String empTel2;
  DateTime empBirth;
  String empNatid;
  String empAddress;
  String empJop;
  DateTime empWorkStart;
  DateTime empWorkEnd;
  int empStopped;
  int empSal;
  int empHours;

  factory Emp.fromJson(Map<String, dynamic> json) => Emp(
        empId: json["emp_id"],
        empName: json["emp_name"],
        empTel1: json["emp_tel1"],
        empTel2: json["emp_tel2"],
        empBirth: DateTime.parse(json["emp_birth"]),
        empNatid: json["emp_natid"],
        empAddress: json["emp_address"],
        empJop: json["emp_jop"],
        empWorkStart: DateTime.parse(json["emp_work_start"]),
        empWorkEnd: DateTime.parse(json["emp_work_end"]),
        empStopped: json["emp_stopped"],
        empSal: json["emp_sal"],
        empHours: json["emp_hours"],
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "emp_name": empName,
        "emp_tel1": empTel1,
        "emp_tel2": empTel2,
        "emp_birth": empBirth,
        "emp_natid": empNatid,
        "emp_address": empAddress,
        "emp_jop": empJop,
        "emp_work_start": empWorkStart,
        "emp_work_end": empWorkEnd,
        "emp_stopped": empStopped,
        "emp_sal": empSal,
        "emp_hours": empHours,
      };
}
