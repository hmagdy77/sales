// To parse this JSON data, do
//
//     final supModel = supModelFromJson(jsonString);

import 'dart:convert';

SupModel supModelFromJson(String str) => SupModel.fromJson(json.decode(str));

String supModelToJson(SupModel data) => json.encode(data.toJson());

class SupModel {
  SupModel({
    required this.status,
    required this.data,
  });

  String status;
  List<Sup> data;

  factory SupModel.fromJson(Map<String, dynamic> json) => SupModel(
        status: json["status"],
        data: List<Sup>.from(json["data"].map((x) => Sup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Sup {
  Sup({
    required this.supId,
    required this.supName,
    required this.supTel,
  });

  int supId;
  String supName;
  String supTel;

  factory Sup.fromJson(Map<String, dynamic> json) => Sup(
        supId: json["sup_id"],
        supName: json["sup_name"],
        supTel: json["sup_tel"],
      );

  Map<String, dynamic> toJson() => {
        "sup_id": supId,
        "sup_name": supName,
        "sup_tel": supTel,
      };
}
