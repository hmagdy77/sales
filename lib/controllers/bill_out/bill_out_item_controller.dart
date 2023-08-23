import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/status/status_model.dart';
import '../../models/items/item_model.dart';

abstract class BillOutItemController extends GetxController {
  addItems(
      {required String billId,
      required Item item,
      required int itemCount,
      required String workId,
      required String isBack});

  editItems({
    required String billId,
    required Item item,
    required String itemCount,
  });
  getitemsbyBillService(String billId);
  getItemsbyBillId(String billId);
  getItemsByIndex(String billId);
  deleteItems(String billId);
}

class BillOutItemControllerImp extends BillOutItemController {
  var billsOutItemsList = <Item>[].obs;
  List<Item> billsOutSearchItemsList = <Item>[].obs;
  bool isShown = true;
  var isLoading = false.obs;

  @override
  editItems(
      {required String billId,
      required Item item,
      required String itemCount}) async {
    isLoading.value = true;
    var editItem = await Crud.postRequest(
      MyStrings.apiEditBillsOutItems,
      {
        'item_id': item.itemId.toString(),
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'item_price_in': 'itemPriceOut',
        'item_price_out': item.itemPriceOut.toString(),
        'item_count': itemCount.toString(),
        'bill_id': billId,
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
  deleteItems(String billId) async {
    isLoading(true);
    var item = await Crud.postRequest(
      MyStrings.apiDeleteBillsOutItems,
      {'bill_id': billId},
      statusModelFromJson,
    );
    if (item.status == 'suc') {
      isLoading(false);
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  getitemsbyBillService(String billId) async {
    var items = await Crud.postRequest(
      MyStrings.apiGetBillsOutItems,
      {'bill_id': billId},
      itemModelFromJson,
    );
    return items.data;
  }

  @override
  getItemsbyBillId(String billId) async {
    var items = await getitemsbyBillService(billId);
    isLoading(true);
    billsOutItemsList.value = items;
    isLoading(false);
    if (items.isEmpty) {
      isLoading(false);
      update();
    }
  }

  @override
  getItemsByIndex(String billId) async {
    isLoading(true);
    var items = await getItemsbyBillId(billId);
    if (items != null) {
      billsOutItemsList.value = items;
    }
    isLoading(false);
  }

  @override
  addItems(
      {required String billId,
      required Item item,
      required int itemCount,
      required String workId,
      required String isBack}) async {
    isLoading.value = true;
    var addBillIn = await Crud.postRequest(
      MyStrings.apiAddBillsOutItems,
      {
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'stock_id': item.itemId.toString(),
        'item_price_in': 'item_price_in',
        'item_price_out': item.itemPriceOut.toString(),
        'item_count': itemCount.toString(),
        'work_id': workId,
        'is_back': isBack,
        'bill_id': billId,
        'item_pakage': item.itemPakage
      },
      statusModelFromJson,
    );
    try {
      if (addBillIn.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillIn.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      //MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }
}

 // await Future.delayed(const Duration(seconds: 2));