// To parse this JSON data, do
//
//     final saleryPaymentModel = saleryPaymentModelFromJson(jsonString);

import 'dart:convert';

SaleryPaymentModel saleryPaymentModelFromJson(String str) =>
    SaleryPaymentModel.fromJson(json.decode(str));

String saleryPaymentModelToJson(SaleryPaymentModel data) =>
    json.encode(data.toJson());

class SaleryPaymentModel {
  String status;
  List<SalPayment> data;

  SaleryPaymentModel({
    required this.status,
    required this.data,
  });

  factory SaleryPaymentModel.fromJson(Map<String, dynamic> json) =>
      SaleryPaymentModel(
        status: json["status"],
        data: List<SalPayment>.from(
            json["data"].map((x) => SalPayment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SalPayment {
  dynamic sumPayment;

  SalPayment({
    this.sumPayment,
  });

  factory SalPayment.fromJson(Map<String, dynamic> json) => SalPayment(
        sumPayment: json["SUM(payment)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(payment)": sumPayment,
      };
}
