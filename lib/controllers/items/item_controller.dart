import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../core/service/services.dart';
import '../../models/status/status_model.dart';
import '../../models/items/item_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class ItemController extends GetxController {
  addItem({required String sup, required int kind});
  editItem({required Item item, required String sup});
  getItems();
  getItemsByKind({required int kind});
  deleteItem(String id);
  stock(String id, String quantity);
  String converter(Item item);
  searchInList({required String searchName, required int kind});
  void searchKind(String searchName);
  void searchMinAndMax(String searchName, int kind);
  // void searchAvilableBikes(String searchName, String kind);
  void searchAvilableQuant(String searchName, int kind);
}

class ItemControllerImp extends ItemController {
  late TextEditingController name;
  late TextEditingController num;
  late TextEditingController bikeKind;
  late TextEditingController bikeModel;
  late TextEditingController bikeColor;
  late TextEditingController priceIn;
  late TextEditingController priceOut;
  late TextEditingController numberOfpices;
  late TextEditingController quant;
  late TextEditingController min;
  late TextEditingController max;
  late TextEditingController print;

  GlobalKey<FormState> editItemKey = GlobalKey<FormState>();
  GlobalKey<FormState> addItemKey = GlobalKey<FormState>();
  var printNumber = 0.obs;
  List<Widget> printList = [];
  var selectedPackage = ''.obs;
  var selectedKind = ''.obs;
  var selectedTime = ''.obs;
  var selectedBikeCondtion = ''.obs;
  var usedKind = 0.obs;
  bool isShown = true;
  var isLoading = false.obs;
  List<Item> itemsList = <Item>[].obs;
  List<Item> stockItemsList = <Item>[].obs;
  List<Item> bikesItemsList = <Item>[].obs;
  List<Item> rentItemsList = <Item>[].obs;
  List<Item> fixItemsList = <Item>[].obs;
  List<Item> searchItemsList = <Item>[].obs;
  List<List<String>> printItems = [];
  MyService myService = Get.find();
  var converterQuantity = ''.obs;
  @override
  void onInit() {
    name = TextEditingController();
    num = TextEditingController();
    priceIn = TextEditingController();
    priceOut = TextEditingController();
    numberOfpices = TextEditingController();
    quant = TextEditingController();
    print = TextEditingController();
    bikeColor = TextEditingController();
    bikeKind = TextEditingController();
    bikeModel = TextEditingController();
    min = TextEditingController();
    max = TextEditingController();
    getItems();
    getItemsByKind(kind: 0);
    getItemsByKind(kind: 2);
    getItemsByKind(kind: 3);
    getItemsByKind(kind: 4);
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    num.dispose();
    priceIn.dispose();
    priceOut.dispose();
    numberOfpices.dispose();
    quant.dispose();
    print.dispose();
    bikeColor.dispose();
    bikeKind.dispose();
    bikeModel.dispose();
    min.dispose();
    max.dispose();
    super.dispose();
  }

  @override
  addItem({
    String? sup,
    required int kind,
    String? bikeKind,
    String? bikeModel,
    String? bikeColor,
    String? bikeCondition,
  }) async {
    var formData = addItemKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var addItem = await Crud.postRequest(
          MyStrings.apiAddItem,
          {
            'item_name': name.text,
            'item_num': num.text.trim(),
            'item_sup': sup ?? '',
            'item_price_in': priceIn.text,
            'item_price_out': priceOut.text,
            'item_quant': quant.text,
            'item_pakage': kind == 0
                ? selectedPackage.value
                : kind == 2
                    ? selectedTime.value
                    : kind == 3
                        ? MyStrings.fix
                        : MyStrings.bike,
            'item_piec': bikeKind == null ? numberOfpices.text : '1',
            'item_count': '0',
            'item_min': min.text.toString(),
            'item_max': max.text.toString(),
            'bill_id': '0',
            'is_back': kind.toString(),
            'bike_kind': bikeKind ?? '',
            'bike_condition': bikeCondition ?? '',
            'bike_color': bikeColor ?? '',
            'bike_model': bikeModel ?? '',
          },
          statusModelFromJson);

      if (addItem.status == "suc") {
        isLoading(false);
        kind == 0
            ? Get.offNamed(
                AppRoutes.loadingScreen,
                arguments: [AppRoutes.addStockItemsScreen],
              )
            : kind == 2
                ? Get.offNamed(
                    AppRoutes.loadingScreen,
                    arguments: [AppRoutes.addRentItemScreen],
                  )
                : kind == 3
                    ? Get.offNamed(
                        AppRoutes.loadingScreen,
                        arguments: [AppRoutes.addFixItemScreen],
                      )
                    : Get.offNamed(
                        AppRoutes.loadingScreen,
                        arguments: [AppRoutes.addBikeItemScreen],
                      );
        name.clear();
        num.clear();
        priceIn.clear();
        priceOut.clear();
        update();
      } else if (addItem.status == "found") {
        MySnackBar.snack(MyStrings.fail, MyStrings.found);
        isLoading(false);
        update();
      } else if (addItem.status == "fail") {
        isLoading(false);
        update();
      }
      try {} catch (_) {
        isLoading(false);
        update();
      }
    }
  }

  @override
  editItem({required Item item, String? sup}) async {
    var formData = editItemKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var editItem = await Crud.postRequest(
        MyStrings.apiEditItem,
        {
          'item_id': item.itemId.toString(),
          'item_name': name.text,
          'item_num': num.text,
          'item_sup': sup ?? '',
          'item_price_in': priceIn.text,
          'item_price_out': priceOut.text,
          'item_min': min.text,
          'item_max': max.text,
          'item_pakage': selectedPackage.value.isEmpty
              ? item.itemPakage
              : selectedPackage.value,
          'item_piec': numberOfpices.text.toString(),
          'item_count': '0',
          'bill_id': '0'
        },
        statusModelFromJson,
      );
      try {
        if (editItem.status == "suc") {
          isLoading(false);
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.searchItemScreen],
          );
          update();
        } else if (editItem.status == "fail") {
          MySnackBar.snack(MyStrings.noitemsEdited, '');
          isLoading(false);
          update();
        }
      } catch (_) {
        isLoading(false);
        update();
      }
    }
  }

  @override
  stock(String id, String quantity) async {
    isLoading.value = true;
    var editItem = await Crud.postRequest(
      MyStrings.apiStockItem,
      {
        'item_id': id,
        'item_quant': quantity,
      },
      statusModelFromJson,
    );
    try {
      if (editItem.status == "suc") {
        isLoading(false);
        update();
      } else if (editItem.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  converter(Item item) {
    var quntity = item.itemQuant;
    var pices = int.parse(item.itemPiec);
    if (quntity == 0) {
      return converterQuantity.value = MyStrings.emptyQuantity;
    } else if (quntity <= pices) {
      return converterQuantity.value = '$quntity قطعة';
    } else {
      int finalQuantity = quntity ~/ pices;
      int numberOfPices = quntity - (finalQuantity * pices);
      if (numberOfPices == 0) {
        return converterQuantity.value = '$finalQuantity ${item.itemPakage}';
      } else {
        return converterQuantity.value =
            '$finalQuantity ${item.itemPakage} +  $numberOfPices قطعة';
      }
    }
  }

  @override
  getItems() async {
    isLoading(true);
    var item = await Crud.postRequest(
      MyStrings.apiGetItems,
      {},
      itemModelFromJson,
    );
    try {
      if (item.status == 'fail') {
        isLoading(false);
        update();
      } else if (item.status == 'suc') {
        isLoading(false);
        itemsList.addAll(item.data);
        update();
      }
    } catch (_) {}
  }

  @override
  getItemsByKind({required int kind}) async {
    isLoading(true);
    var item = await Crud.postRequest(
      MyStrings.apiGetItemsKind,
      {'is_back': kind.toString()},
      itemModelFromJson,
    );
    try {
      if (item.status == 'fail') {
        isLoading(false);
        update();
      } else if (item.status == 'suc') {
        isLoading(false);
        if (kind == 0) {
          stockItemsList.addAll(item.data);
        } else if (kind == 2) {
          rentItemsList.addAll(item.data);
        } else if (kind == 3) {
          fixItemsList.addAll(item.data);
        } else if (kind == 4) {
          bikesItemsList.addAll(item.data);
        }
        update();
      }
    } catch (_) {}
  }

  @override
  void searchInList({required String searchName, required int kind}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    switch (kind) {
      case 0:
        searchItemsList = stockItemsList.where(
          (item) {
            var itemName = item.itemName;
            var itemSup = item.itemSup.toLowerCase();
            var itemNum = item.itemNum.toLowerCase();
            var itemId = item.itemId.toString();
            return itemName.contains(searchName) ||
                itemNum.contains(searchName) ||
                itemSup.contains(searchName) ||
                itemId.contains(searchName);
          },
        ).toList();
        break;
      case 2:
        searchItemsList = rentItemsList.where(
          (item) {
            var itemName = item.itemName;
            var itemNum = item.itemNum.toLowerCase();
            var itemprice = item.itemNum.toLowerCase();
            var itemId = item.itemId.toString();
            return itemName.contains(searchName) ||
                itemNum.contains(searchName) ||
                itemprice.contains(searchName) ||
                itemId.contains(searchName);
          },
        ).toList();
        break;
      case 3:
        searchItemsList = fixItemsList.where(
          (item) {
            var itemName = item.itemName;
            var itemNum = item.itemNum.toLowerCase();
            var itemprice = item.itemNum.toLowerCase();
            var itemId = item.itemId.toString();
            return itemName.contains(searchName) ||
                itemNum.contains(searchName) ||
                itemprice.contains(searchName) ||
                itemId.contains(searchName);
          },
        ).toList();
        break;
      case 4:
        searchItemsList = bikesItemsList.where(
          (item) {
            var itemName = item.itemName;
            var itemSup = item.itemSup.toLowerCase();
            var itemNum = item.itemNum.toLowerCase();
            var itemId = item.itemId.toString();
            return itemName.contains(searchName) ||
                itemNum.contains(searchName) ||
                itemSup.contains(searchName) ||
                itemId.contains(searchName);
          },
        ).toList();
        break;
    }
    isLoading(false);
    update();
  }

  @override
  void searchKind(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchItemsList = itemsList.where(
      (item) {
        var itemKind = item.isBack.toString();
        return itemKind.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  // @override
  // void searchAvilableBikes(String searchName, String kind) {
  //   isLoading(true);
  //   searchName = searchName.toLowerCase();
  //   searchItemsList = itemsList.where(
  //     (item) {
  //       var itemKind = item.isBack.toString();
  //       var itemQuant = item.itemQuant.toString();
  //       return itemKind.contains(searchName) && itemQuant.contains(kind);
  //     },
  //   ).toList();
  //   isLoading(false);
  //   update();
  // }

  @override
  void searchAvilableQuant(String searchName, int kind) {
    isLoading(true);
    searchItemsList = itemsList.where(
      (item) {
        var itemKind = item.isBack.toString();
        var itemQuant = item.itemQuant;
        switch (kind) {
          case 0:
            return itemKind.contains(searchName) && itemQuant == 0;
          case 1:
            return itemKind.contains(searchName) && itemQuant != 0;
          default:
            return itemKind.contains(searchName);
        }
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  void searchMinAndMax(String searchName, int kind) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchItemsList = itemsList.where(
      (item) {
        var itemKind = item.isBack.toString();
        var itemQuant = item.itemQuant;
        var itemmMin = item.itemMin;
        var itemMax = item.itemMax;
        switch (kind) {
          case 0:
            return itemKind.contains('0') && itemQuant <= itemmMin;
          case 1:
            return itemKind.contains('0') && itemQuant >= itemMax;
          default:
            return itemKind.contains('0');
        }
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deleteItem(String id) async {
    isLoading(true);
    var item = await Crud.postRequest(
      MyStrings.apiDeleteItem,
      {'item_id': id},
      statusModelFromJson,
    );
    if (item.status == 'suc') {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [AppRoutes.searchItemScreen],
      );
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }
}

 // await Future.delayed(const Duration(seconds: 2));