// To parse this JSON data, do
//
//     final worksSales = worksSalesFromJson(jsonString);

import 'dart:convert';

WorksSales worksSalesFromJson(String str) =>
    WorksSales.fromJson(json.decode(str));

String worksSalesToJson(WorksSales data) => json.encode(data.toJson());

class WorksSales {
  String status;
  List<Datum> data;

  WorksSales({
    required this.status,
    required this.data,
  });

  factory WorksSales.fromJson(Map<String, dynamic> json) => WorksSales(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic sumWorkTotal;

  Datum({
    this.sumWorkTotal,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sumWorkTotal: json["SUM(work_total)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(work_total)": sumWorkTotal,
      };
}
