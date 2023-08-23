// To parse this JSON data, do
//
//     final sumBillPaymentModel = sumBillPaymentModelFromJson(jsonString);

import 'dart:convert';

SumBillPaymentModel sumBillPaymentModelFromJson(String str) =>
    SumBillPaymentModel.fromJson(json.decode(str));

String sumBillPaymentModelToJson(SumBillPaymentModel data) =>
    json.encode(data.toJson());

class SumBillPaymentModel {
  String status;
  List<SumBillPayment> data;

  SumBillPaymentModel({
    required this.status,
    required this.data,
  });

  factory SumBillPaymentModel.fromJson(Map<String, dynamic> json) =>
      SumBillPaymentModel(
        status: json["status"],
        data: List<SumBillPayment>.from(
            json["data"].map((x) => SumBillPayment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SumBillPayment {
  dynamic sumBillPayment;

  SumBillPayment({
    this.sumBillPayment,
  });

  factory SumBillPayment.fromJson(Map<String, dynamic> json) => SumBillPayment(
        sumBillPayment: json["SUM(bill_payment)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(bill_payment)": sumBillPayment,
      };
}
