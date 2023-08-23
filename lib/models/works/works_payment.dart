// To parse this JSON data, do
//
//     final worksPayment = worksPaymentFromJson(jsonString);

import 'dart:convert';

WorksPayment worksPaymentFromJson(String str) =>
    WorksPayment.fromJson(json.decode(str));

String worksPaymentToJson(WorksPayment data) => json.encode(data.toJson());

class WorksPayment {
  String status;
  List<Payment> data;

  WorksPayment({
    required this.status,
    required this.data,
  });

  factory WorksPayment.fromJson(Map<String, dynamic> json) => WorksPayment(
        status: json["status"],
        data: List<Payment>.from(json["data"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Payment {
  dynamic sumWorkPayment;

  Payment({
    this.sumWorkPayment,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        sumWorkPayment: json["SUM(work_payment)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(work_payment)": sumWorkPayment,
      };
}
