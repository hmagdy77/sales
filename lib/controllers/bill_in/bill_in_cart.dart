import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_strings.dart';
import '../../core/service/services.dart';
import '../../models/items/item_model.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillInCartController extends GetxController {
  addToCarts(Item item);
  addAllToCarts(List<Item> items);
  removeFromCart(Item item);
  void removeOneProduct(Item item, int index);
  void clearCart();
  var pay14 = 0.obs;
}

class BillInCartControllerImp extends BillInCartController {
  Map myCarts = {}.obs;
  var isLoading = false.obs;
  List<List<String>> items = [];
  List<TextEditingController>? controllers = [];
  List<bool>? isOverd = [];
  late TextEditingController numberOfPices;
  MyService myService = Get.find();
  @override
  void onInit() {
    numberOfPices = TextEditingController();
    myCarts.clear();
    super.onInit();
  }

  @override
  void dispose() {
    numberOfPices.dispose();
    super.dispose();
  }

  void updateQuantity(Item item, int quantity) {
    myCarts.update(item, (value) => quantity);
  }

  @override
  addToCarts(Item item) {
    if (myCarts.containsKey(item)) {
      MySnackBar.snack(MyStrings.alreadyIn, '');
      // myCarts[item] += 1;
    } else {
      myCarts[item] = 1;
      controllers!.add(TextEditingController());
      isOverd!.add(false);
    }
  }

  @override
  void removeFromCart(Item item) {
    if (myCarts.containsKey(item) && myCarts[item] == 1) {
      myCarts.removeWhere((key, value) => key == item);
    } else {
      myCarts[item] -= 1;
    }
  }

  @override
  void removeOneProduct(Item item, int index) {
    myCarts.removeWhere((key, value) => key == item);
    controllers!.removeAt(index);
    isOverd!.removeAt(index);
  }

  @override
  void clearCart() {
    myCarts.clear();
    for (int i = 0; i < controllers!.length; i++) {
      controllers![i].clear();
      isOverd![i] = false;
    }
  }

  @override
  addAllToCarts(List<Item> items) {
    isLoading(true);
    for (int index = 0; index < items.length; index++) {
      addToCarts(items[index]);
      updateQuantity(items[index], items[index].itemCount);
    }
    isLoading(false);
  }

  get supTotal =>
      myCarts.entries.map((e) => e.key.itemPriceIn * e.value).toList();

  get total => myCarts.isEmpty
      ? 0
      : myCarts.entries
          .map((e) => e.key.itemPriceIn * e.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);

  // @override
  // int quantity() {
  //   if (myCarts.isEmpty) {
  //     return 0;
  //   } else {
  //     return myCarts.entries
  //         .map((e) => e.value)
  //         .toList()
  //         .reduce((value, element) => value + element);
  //   }
  // }

  // @override
  // bool isInCart(Item item) {
  //   if ((myCarts.containsKey(Item) && myCarts[Item] == 1)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
