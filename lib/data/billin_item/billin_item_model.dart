// To parse this JSON data, do
//
//     final billsInItemModel = billsInItemModelFromJson(jsonString);

import 'dart:convert';

BillsInItemModel billsInItemModelFromJson(String str) =>
    BillsInItemModel.fromJson(json.decode(str));

String billsInItemModelToJson(BillsInItemModel data) =>
    json.encode(data.toJson());

class BillsInItemModel {
  BillsInItemModel({
    required this.status,
    required this.data,
  });

  String status;
  List<BillInItem> data;

  factory BillsInItemModel.fromJson(Map<String, dynamic> json) =>
      BillsInItemModel(
        status: json["status"],
        data: List<BillInItem>.from(
            json["data"].map((x) => BillInItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BillInItem {
  BillInItem({
    required this.itemId,
    required this.itemName,
    required this.itemNum,
    required this.itemPrice,
    required this.itemCount,
    required this.billId,
  });

  int itemId;
  String itemName;
  String itemNum;
  String itemPrice;
  String itemCount;
  int billId;

  factory BillInItem.fromJson(Map<String, dynamic> json) => BillInItem(
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemNum: json["item_num"],
        itemPrice: json["item_price"],
        itemCount: json["item_count"],
        billId: json["bill_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_name": itemName,
        "item_num": itemNum,
        "item_price": itemPrice,
        "item_count": itemCount,
        "bill_id": billId,
      };
}
