// To parse this JSON data, do
//
//     final sumItemModel = sumItemModelFromJson(jsonString);

import 'dart:convert';

SumItemModel sumItemModelFromJson(String str) =>
    SumItemModel.fromJson(json.decode(str));

String sumItemModelToJson(SumItemModel data) => json.encode(data.toJson());

class SumItemModel {
  SumItemModel({
    required this.status,
    required this.data,
  });

  String status;
  List<SumItem> data;

  factory SumItemModel.fromJson(Map<String, dynamic> json) => SumItemModel(
        status: json["status"],
        data: List<SumItem>.from(json["data"].map((x) => SumItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SumItem {
  SumItem({
    this.sumItemCount,
  });

  dynamic sumItemCount;

  factory SumItem.fromJson(Map<String, dynamic> json) => SumItem(
        sumItemCount: json["SUM(item_count)"],
      );

  Map<String, dynamic> toJson() => {
        "SUM(item_count)": sumItemCount,
      };
}
