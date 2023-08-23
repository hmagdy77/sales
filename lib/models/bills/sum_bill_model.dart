// To parse this JSON data, do
//
//     final sumBillModel = sumBillModelFromJson(jsonString);
// bill_total
import 'dart:convert';

SumBillModel sumBillModelFromJson(String str) =>
    SumBillModel.fromJson(json.decode(str));

String sumModelToJson(SumBillModel data) => json.encode(data.toJson());

class SumBillModel {
  SumBillModel({
    required this.status,
    required this.data,
  });

  String status;
  List<SumBill> data;

  factory SumBillModel.fromJson(Map<String, dynamic> json) => SumBillModel(
        status: json["status"],
        data: List<SumBill>.from(json["data"].map((x) => SumBill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SumBill {
  SumBill({
    this.sumBillTotal,
  });

  dynamic sumBillTotal;

  factory SumBill.fromJson(Map<String, dynamic> json) => SumBill(
        sumBillTotal: json["SUM(bill_after_discount)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(bill_after_discount)": sumBillTotal,
      };
}
