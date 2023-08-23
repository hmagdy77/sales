// To parse this JSON data, do
//
//     final sumBillTotalModel = sumBillTotalModelFromJson(jsonString);

import 'dart:convert';

SumBillTotalModel sumBillTotalModelFromJson(String str) =>
    SumBillTotalModel.fromJson(json.decode(str));

String sumBillTotalModelToJson(SumBillTotalModel data) =>
    json.encode(data.toJson());

class SumBillTotalModel {
  String status;
  List<Datum> data;

  SumBillTotalModel({
    required this.status,
    required this.data,
  });

  factory SumBillTotalModel.fromJson(Map<String, dynamic> json) =>
      SumBillTotalModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic sumBillTotal;

  Datum({
    this.sumBillTotal,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sumBillTotal: json["SUM(bill_total)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(bill_total)": sumBillTotal,
      };
}
