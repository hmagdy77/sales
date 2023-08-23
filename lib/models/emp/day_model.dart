// To parse this JSON data, do
//
//     final dayModel = dayModelFromJson(jsonString);

import 'dart:convert';

DayModel dayModelFromJson(String str) => DayModel.fromJson(json.decode(str));

String dayModelToJson(DayModel data) => json.encode(data.toJson());

class DayModel {
  DayModel({
    required this.status,
    required this.data,
  });

  String status;
  List<Day> data;

  factory DayModel.fromJson(Map<String, dynamic> json) => DayModel(
        status: json["status"],
        data: List<Day>.from(json["data"].map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Day {
  Day({
    required this.dayId,
    required this.empId,
    required this.empName,
    required this.empJop,
    required this.empSal,
    required this.empHours,
    required this.day,
    required this.empAttend,
    required this.empExit,
    required this.isExit,
    required this.empHoliday,
    required this.empAbsence,
    required this.empRest,
    required this.empNotes,
    required this.minutes,
    required this.payment,
    required this.exept,
    required this.bouns,
  });

  int dayId;
  int empId;
  String empName;
  String empJop;
  int empSal;
  int empHours;
  DateTime day;
  DateTime empAttend;
  DateTime empExit;
  int isExit;
  int empHoliday;
  int empAbsence;
  int empRest;
  String empNotes;
  int minutes;
  int payment;
  int exept;
  int bouns;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        dayId: json["day_id"],
        empId: json["emp_id"],
        empName: json["emp_name"],
        empJop: json["emp_jop"],
        empSal: json["emp_sal"],
        empHours: json["emp_hours"],
        day: DateTime.parse(json["day"]),
        empAttend: DateTime.parse(json["emp_attend"]),
        empExit: DateTime.parse(json["emp_exit"]),
        isExit: json["is_exit"],
        empHoliday: json["emp_holiday"],
        empAbsence: json["emp_absence"],
        empRest: json["emp_rest"],
        empNotes: json["emp_notes"],
        minutes: json["minutes"],
        payment: json["payment"],
        exept: json["exept"],
        bouns: json["bouns"],
      );

  Map<String, dynamic> toJson() => {
        "day_id": dayId,
        "emp_id": empId,
        "emp_name": empName,
        "emp_jop": empJop,
        "emp_sal": empSal,
        "emp_hours": empHours,
        "day":
            "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "emp_attend": empAttend.toIso8601String(),
        "emp_exit": empExit.toIso8601String(),
        "is_exit": isExit,
        "emp_holiday": empHoliday,
        "emp_absence": empAbsence,
        "emp_rest": empRest,
        "emp_notes": empNotes,
        "minutes": minutes,
        "payment": payment,
        "exept": exept,
        "bouns": bouns,
      };
}
