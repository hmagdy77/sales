// To parse this JSON data, do
//
//     final workPaymentModel = workPaymentModelFromJson(jsonString);

import 'dart:convert';

WorkPaymentModel workPaymentModelFromJson(String str) =>
    WorkPaymentModel.fromJson(json.decode(str));

String workPaymentModelToJson(WorkPaymentModel data) =>
    json.encode(data.toJson());

class WorkPaymentModel {
  String status;
  List<WorkPayment> data;

  WorkPaymentModel({
    required this.status,
    required this.data,
  });

  factory WorkPaymentModel.fromJson(Map<String, dynamic> json) =>
      WorkPaymentModel(
        status: json["status"],
        data: List<WorkPayment>.from(
            json["data"].map((x) => WorkPayment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WorkPayment {
  int paymentId;
  String workId;
  String workName;
  String notes;
  int paymentTotal;
  DateTime paymentTimestamp;

  WorkPayment({
    required this.paymentId,
    required this.workId,
    required this.workName,
    required this.notes,
    required this.paymentTotal,
    required this.paymentTimestamp,
  });

  factory WorkPayment.fromJson(Map<String, dynamic> json) => WorkPayment(
        paymentId: json["payment_id"],
        workId: json["work_id"],
        workName: json["work_name"],
        notes: json["notes"],
        paymentTotal: json["payment_total"],
        paymentTimestamp: DateTime.parse(json["payment_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "work_id": workId,
        "work_name": workName,
        "notes": notes,
        "payment_total": paymentTotal,
        "payment_timestamp": paymentTimestamp.toIso8601String(),
      };
}
