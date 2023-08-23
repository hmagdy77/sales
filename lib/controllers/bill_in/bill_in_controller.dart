import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../core/service/services.dart';
import '../../models/bills/sum/bill_payment.dart';
import '../../models/bills/sum_bill_total_model.dart';
import '../../models/status/status_model.dart';
import '../../models/bills/bill_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillInController extends GetxController {
  addBillIn(String sup);
  getBillsIn();
  search(String searchName);
  deleteBill(String billId);
  getDate({required context, required bool start, required bool end});
  getBillsInSum({required int kind});
  getBillsInPaymentSum({required int kind});
  editBillIn(
      {required String sup,
      required String id,
      required String total,
      required String numberOfItems});
  saveBillIn({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String isBack,
  });
}

class BillInControllerImp extends BillInController {
  late TextEditingController billInSearchController;
  late TextEditingController billPayment;
  late TextEditingController billNotes;
  bool isShown = true;
  var isLoading = false.obs;
  List<Bill> billsInList = <Bill>[].obs;
  List<Bill> billsInSearchList = <Bill>[].obs;
  List<Bill> billsInListReversed = <Bill>[].obs;
  List<Bill> billsInDateList = <Bill>[].obs;
  MyService myService = Get.find();
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;
  var billKind = ''.obs;
  var billsStockTotal = 0.obs;
  var billsbackTotal = 0.obs;
  var billsStockPayment = 0.obs;
  var billsbackPayment = 0.obs;
  var billsBikesTotal = 0.obs;
  var billsbackBikesTotal = 0.obs;
  var billsBikesPayment = 0.obs;
  var billsbackBikesPayment = 0.obs;

  @override
  void onInit() {
    billInSearchController = TextEditingController();
    billPayment = TextEditingController();
    billNotes = TextEditingController();
    getBillsIn();
    super.onInit();
  }

  @override
  void dispose() {
    billInSearchController.dispose();
    billPayment.dispose();
    billNotes.dispose();
    super.dispose();
  }

  @override
  getDate({required context, required bool start, required bool end}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('ar'),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        if (start) {
          startDate.value = formatter.format(pickedDate);
        } else if (end) {
          endDate.value = formatter.format(pickedDate);
        }
      },
    );
  }

  @override
  getBillsInSum({required int kind}) async {
    try {
      var getSum = await Crud.postRequest(
        MyStrings.apiGetBillsInDate,
        {
          'start_date': '${startDate.value.toString()} 00:00:00',
          'end_date': '${endDate.value.toString()} 23:59:00',
          'is_back': kind.toString(),
        },
        sumBillTotalModelFromJson,
      );
      if (getSum.status == 'fail') {
        isLoading(false);
        update();
      } else if (getSum.status == 'suc') {
        if (getSum.data[0].sumBillTotal == null) {
          switch (kind) {
            case 0:
              billsStockTotal.value = 0;
              break;
            case 1:
              billsbackTotal.value = 0;
              break;
            case 4:
              billsBikesTotal.value = 0;
              break;
            case 5:
              billsbackBikesTotal.value = 0;
          }
          isLoading(false);
          update();
        } else {
          switch (kind) {
            case 0:
              billsStockTotal.value = getSum.data[0].sumBillTotal;
              break;
            case 1:
              billsbackTotal.value = getSum.data[0].sumBillTotal;
              break;
            case 4:
              billsBikesTotal.value = getSum.data[0].sumBillTotal;
              break;
            case 5:
              billsbackBikesTotal.value = getSum.data[0].sumBillTotal;
          }

          isLoading(false);
          update();
        }
      }
    } catch (_) {}
  }

  @override
  getBillsInPaymentSum({required int kind}) async {
    try {
      var getSum = await Crud.postRequest(
        MyStrings.apiGetBillsInPaymentDate,
        {
          'start_date': '${startDate.value.toString()} 00:00:00',
          'end_date': '${endDate.value.toString()} 23:59:00',
          'is_back': kind.toString(),
        },
        sumBillPaymentModelFromJson,
      );
      if (getSum.status == 'fail') {
        isLoading(false);
        update();
      } else if (getSum.status == 'suc') {
        if (getSum.data[0].sumBillPayment == null) {
          switch (kind) {
            case 0:
              billsStockPayment.value = 0;
              break;
            case 1:
              billsbackPayment.value = 0;
              break;
            case 4:
              billsBikesPayment.value = 0;
              break;
            case 5:
              billsbackBikesPayment.value = 0;
          }
          isLoading(false);
          update();
        } else {
          switch (kind) {
            case 0:
              billsStockPayment.value = getSum.data[0].sumBillPayment;
              break;
            case 1:
              billsbackPayment.value = getSum.data[0].sumBillPayment;
              break;
            case 4:
              billsBikesPayment.value = getSum.data[0].sumBillPayment;
              break;
            case 5:
              billsbackBikesPayment.value = getSum.data[0].sumBillPayment;
          }
          isLoading(false);
          update();
        }
      }
    } catch (_) {}
  }

  @override
  deleteBill(String billId) async {
    isLoading(true);
    var item = await Crud.postRequest(
      MyStrings.apiDeleteBillsIn,
      {'bill_id': billId},
      statusModelFromJson,
    );
    if (item.status == 'suc') {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [AppRoutes.searchBillInScreen],
      );
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  addBillIn(String sup) async {
    isLoading.value = true;
    var addBillIn = await Crud.postRequest(
      MyStrings.apiAddBillsIn,
      {
        'bill_sup': sup,
        'agent_name': '',
        'agent_phone': '',
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
      isLoading(false);
      update();
    }
  }

  @override
  editBillIn({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
  }) async {
    try {
      isLoading.value = true;
      var editBillIn = await Crud.postRequest(
        MyStrings.apiEditBillsIn,
        {
          'bill_sup': sup,
          'bill_id': id,
          'bill_total': total,
          'bill_items': numberOfItems,
          'bill_payment': billPayment.text.toString(),
          'bill_notes': billNotes.text,
        },
        statusModelFromJson,
      );
      if (editBillIn.status == "suc") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchBillInScreen],
        );
        isLoading(false);
        update();
      } else if (editBillIn.status == "fail") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchBillInScreen],
        );
        MySnackBar.snack(MyStrings.noitemsEdited, '');
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  saveBillIn({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String isBack,
  }) async {
    try {
      isLoading.value = true;
      var saveBillIn = await Crud.postRequest(
        MyStrings.apiSaveBillsIn,
        {
          'bill_sup': sup,
          'bill_id': id,
          'bill_total': total,
          'bill_items': numberOfItems,
          'work_num': '0',
          'is_back': isBack,
          'bill_payment': billPayment.text.toString(),
          'bill_notes': billNotes.text,
          'bill_timestamp':
              '${formatter.format(now)} ${DateTime.now().hour}:${DateTime.now().minute}:00',
        },
        statusModelFromJson,
      );
      if (saveBillIn.status == "suc") {
        if (isBack == '1') {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.addBackBillInScreen],
          );
          isLoading(false);
          update();
        } else {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.addBillInScreen],
          );
          isLoading(false);
          update();
        }
      } else if (saveBillIn.status == "fail") {
        // MySnackBar.snack(MyStrings.noitemsEdited, '');
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  getBillsIn() async {
    isLoading(true);
    var billIn = await Crud.postRequest(
      MyStrings.apiGetBillsIn,
      {},
      billModelFromJson,
    );
    try {
      if (billIn.status == 'fail') {
        isLoading(false);
        update();
      } else if (billIn.status == 'suc') {
        isLoading(false);
        billsInList.addAll(billIn.data);
        billsInListReversed = billsInList.reversed.toList();
        update();
      }
    } catch (_) {}
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsInSearchList = billsInList.where(
      (bill) {
        var supName = bill.billSup;
        var billId = bill.billId.toString();
        var billTotal = bill.billTotal.toString();
        return supName.contains(searchName) ||
            billId.contains(searchName) ||
            billTotal.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }
}
