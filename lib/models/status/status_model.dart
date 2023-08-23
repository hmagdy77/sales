// To parse this JSON data, do
//
//     final statusModel = statusModelFromJson(jsonString);

import 'dart:convert';

StatusModel statusModelFromJson(String str) =>
    StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

class StatusModel {
  StatusModel({
    required this.status,
  });

  String status;

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
