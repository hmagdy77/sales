// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  String status;
  List<Bill> data;

  BillModel({
    required this.status,
    required this.data,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
        status: json["status"],
        data: List<Bill>.from(json["data"].map((x) => Bill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Bill {
  int billId;
  String workNum;
  String workName;
  int isBack;
  String billSup;
  int billItems;
  int billTotal;
  int billDiscount;
  int billAfterAiscount;
  int billPaid;
  int billUnpaid;
  int billPayment;
  String agentName;
  String agentPhone;
  String billNotes;
  DateTime billTimestamp;

  Bill({
    required this.billId,
    required this.workNum,
    required this.workName,
    required this.isBack,
    required this.billSup,
    required this.billItems,
    required this.billTotal,
    required this.billDiscount,
    required this.billAfterAiscount,
    required this.billPaid,
    required this.billUnpaid,
    required this.billPayment,
    required this.agentName,
    required this.agentPhone,
    required this.billNotes,
    required this.billTimestamp,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        billId: json["bill_id"],
        workNum: json["work_num"],
        workName: json["work_name"],
        isBack: json["is_back"],
        billSup: json["bill_sup"],
        billItems: json["bill_items"],
        billTotal: json["bill_total"],
        billDiscount: json["bill_discount"],
        billAfterAiscount: json["bill_after_discount"],
        billPaid: json["bill_paid"],
        billUnpaid: json["bill_unpaid"],
        billPayment: json["bill_payment"],
        agentName: json["agent_name"],
        agentPhone: json["agent_phone"],
        billNotes: json["bill_notes"],
        billTimestamp: DateTime.parse(json["bill_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "bill_id": billId,
        "work_num": workNum,
        "work_name": workName,
        "is_back": isBack,
        "bill_sup": billSup,
        "bill_items": billItems,
        "bill_total": billTotal,
        "bill_discount": billDiscount,
        "bill_paid": billPaid,
        "bill_unpaid": billUnpaid,
        "bill_payment": billPayment,
        "agent_name": agentName,
        "agent_phone": agentPhone,
        "bill_timestamp": billTimestamp.toIso8601String(),
      };
}
