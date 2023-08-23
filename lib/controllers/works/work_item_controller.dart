import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/status/status_model.dart';
import '../../models/items/item_model.dart';

abstract class WorkItemController extends GetxController {
  addItems({
    required Item item,
    required String itemCount,
    required String workId,
    required String isBack,
  });
  editItems({
    required Item item,
    required String itemCount,
    required String workId,
    required String isBack,
  });
  // getitemsbyBillService(String workId);
  // getItemsByIndex(String workId);
  // getItemsByWorkId(String workId);
  getWorkItems({required String workId});
  converter({required Item item});
  // getWorkItems({required String workId});
}

class WorkItemControllerImp extends WorkItemController {
  var workItemsList = <Item>[].obs;
  List<Item> items = <Item>[].obs;
  var isLoading = false.obs;
  var converterQuantity = ''.obs;

  @override
  addItems({
    required Item item,
    required String itemCount,
    required String workId,
    required String isBack,
  }) async {
    isLoading.value = true;
    var addworkItem = await Crud.postRequest(
      MyStrings.apiAddworkItems,
      {
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'item_price_out': item.itemPriceOut.toString(),
        'item_count': itemCount.toString(),
        'work_id': workId,
        'is_back': isBack,
        'item_pakage': item.itemPakage,
        'item_piec': item.itemPiec,
        'item_price_in': 'item_price_in',
        'stock_id': 'stock_id',
        'bill_id': 'bill_id',
      },
      statusModelFromJson,
    );
    try {
      if (addworkItem.status == "suc") {
        isLoading(false);
        update();
      } else if (addworkItem.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  editItems({
    required Item item,
    required String itemCount,
    required String workId,
    required String isBack,
  }) async {
    isLoading.value = true;
    var editItem = await Crud.postRequest(
      MyStrings.apiEditworkItems,
      {
        'item_num': item.itemNum,
        'is_back': isBack,
        'item_count': itemCount.toString(),
        'work_id': workId,
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
      //MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }

  @override
  getWorkItems({required String workId}) async {
    isLoading.value = true;
    var itemsR = await Crud.postRequest(
      MyStrings.apiGetWorkItems,
      {
        'work_id': workId,
      },
      itemModelFromJson,
    );
    if (itemsR.status == "suc") {
      workItemsList.addAll(itemsR.data);
      isLoading(false);
      update();
    } else if (itemsR.status == "fail") {
      isLoading(false);
      update();
    }
    try {} catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  converter({required Item item}) {
    var quntity = item.itemCount;
    var pices = int.parse(item.itemPiec);
    if (quntity == 0) {
      return converterQuantity.value = "0";
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
}
