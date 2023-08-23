import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/status/status_model.dart';
import '../../models/items/item_model.dart';

abstract class BillInItemController extends GetxController {
  addBillInItem(
      {required String billId, required Item item, required int itemCount});

  editItems(
      {required String billId,
      required String itemId,
      required String itemName,
      required String itemNum,
      required String itemPrice,
      required String itemsup,
      required String itemCount});
  getitemsbyBillService(String billId);
  getItemsbyBillId(String billId);
  getItemsByIndex(String billId);
  deleteItems(String billId);
}

class BillInItemControllerImp extends BillInItemController {
  var billsInItemsList = <Item>[].obs;
  List<Item> billsInSearchItemsList = <Item>[].obs;
  bool isShown = true;
  var isLoading = false.obs;

  @override
  editItems(
      {required String billId,
      required String itemName,
      required String itemId,
      required String itemNum,
      required String itemPrice,
      required String itemsup,
      required String itemCount}) async {
    isLoading.value = true;
    var editItem = await Crud.postRequest(
      MyStrings.apiEditBillsInItems,
      {
        'item_id': itemId,
        'item_name': itemName,
        'item_num': itemNum,
        'item_sup': itemsup,
        'item_price_in': itemPrice,
        'item_price_out': 'itemPriceOut',
        'item_count': itemCount,
        'bill_id': billId,
      },
      statusModelFromJson,
    );
    try {
      if (editItem.status == "suc") {
        isLoading(false);
        update();
      } else if (editItem.status == "fail") {
        // MySnackBar.snack(MyStrings.noitemsEdited, 'Some thing went wrong');
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
      MyStrings.apiDeleteBillsInItems,
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
      MyStrings.apiGetBillsInItems,
      {'bill_id': billId},
      itemModelFromJson,
    );
    return items.data;
  }

  @override
  getItemsbyBillId(String billId) async {
    var items = await getitemsbyBillService(billId);
    isLoading(true);
    billsInItemsList.value = items;
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
      billsInItemsList.value = items;
    }
    isLoading(false);
  }

  @override
  addBillInItem(
      {required String billId,
      required Item item,
      required int itemCount}) async {
    isLoading.value = true;
    var addBillIn = await Crud.postRequest(
      MyStrings.apiAddBillsInItems,
      {
        'item_name': item.itemName,
        'item_num': item.itemNum,
        'item_sup': item.itemSup,
        'stock_id': item.itemId.toString(),
        'item_price_in': item.itemPriceIn.toString(),
        'item_price_out': 'itemPriceOut',
        'item_count': itemCount.toString(),
        'bill_id': billId,
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