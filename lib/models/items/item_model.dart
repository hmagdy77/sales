import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  ItemModel({
    required this.status,
    required this.data,
  });

  String status;
  List<Item> data;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        status: json["status"],
        data: List<Item>.from(json["data"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.itemId,
    required this.itemName,
    required this.itemNum,
    required this.itemSup,
    required this.itemPriceOut,
    required this.itemPriceIn,
    required this.itemCount,
    required this.billId,
    required this.stockId,
    required this.itemQuant,
    required this.itemMin,
    required this.itemMax,
    required this.itemPakage,
    required this.itemPiec,
    required this.bikeKind,
    required this.bikeColor,
    required this.bikeModel,
    required this.bikeCondition,
    required this.workId,
    required this.isBack,
    required this.itemTime,
  });

  int itemId;
  String itemName;
  String itemNum;
  String itemSup;
  double itemPriceOut;
  double itemPriceIn;
  int itemCount;
  String billId;
  String stockId;
  int itemQuant;
  int itemMin;
  int itemMax;
  String itemPakage;
  String itemPiec;
  String bikeKind; //bike_kind
  String bikeModel; //bike_model
  String bikeColor; //bike_color
  String bikeCondition; //bike_condition
  String workId;
  int isBack;
  DateTime itemTime;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemNum: json["item_num"],
        itemSup: json["item_sup"],
        itemPriceOut: json["item_price_out"]?.toDouble(),
        itemPriceIn: json["item_price_in"]?.toDouble(),
        itemCount: json["item_count"],
        billId: json["bill_id"],
        stockId: json["stock_id"],
        itemQuant: json["item_quant"],
        itemMin: json["item_min"],
        itemMax: json["item_max"],
        itemPakage: json["item_pakage"],
        itemPiec: json["item_piec"],
        bikeKind: json["bike_kind"],
        bikeColor: json["bike_color"],
        bikeCondition: json["bike_condition"],
        bikeModel: json["bike_model"],
        workId: json["work_id"],
        isBack: json["is_back"],
        itemTime: DateTime.parse(json["item_time"]),
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_name": itemName,
        "item_num": itemNum,
        "item_sup": itemSup,
        "item_price_out": itemPriceOut,
        "item_price_in": itemPriceIn,
        "item_count": itemCount,
        "bill_id": billId,
        "stock_id": stockId,
        "item_quant": itemQuant,
        "item_pakage": itemPakage,
        "item_piec": itemPiec,
        "bike_kind": bikeKind,
        "bike_model": bikeModel,
        "bike_color": bikeColor,
        "bike_condition": bikeCondition,
        "item_time": itemTime.toIso8601String(),
      };
}
