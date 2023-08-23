import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../core/service/services.dart';
import '../../models/bills/sum_bill_model.dart';
import '../../models/status/status_model.dart';
import '../../models/bills/bill_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillOutController extends GetxController {
  addBillOut();
  getBillsOut();
  search(String searchName);
  void searchKind(String searchName);
  deleteBill(String billId);
  getDate({required context, required bool start, required bool end});
  getBillsOutSum({required int kind});
  double unPaid({required double afterDiscount});
  double afterDiscount({required double total});
  editBillOut({
    required String id,
    required String total,
    required String numberOfItems,
  });
  saveBillOut({
    required String id,
    required String total,
    required String numberOfItems,
    required String isBack,
    required String workNum,
  });
  getitemsbyBillService(String workId);
  getItemsbyBillId(String workId);
  getItemsByIndex(String workId);
  void searchWorkBills(String searchName);
  addPayment({
    required String workName,
    required String workId,
  });
}

class BillOutControllerImp extends BillOutController {
  List<Bill> billsOutList = <Bill>[].obs;
  var workBillsList = <Bill>[].obs;
  List<Bill> billsOutSearchList = <Bill>[].obs;
  List<Bill> billsOutListReversed = <Bill>[].obs;
  GlobalKey<FormState> billOutKey = GlobalKey<FormState>();

  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;
  var discountValue = 0.obs;
  var paidValue = 0.obs;
  var billsStockTotal = 0.obs;
  var billsbackTotal = 0.obs;
  var billsRentTotal = 0.obs;
  var billsfixTotal = 0.obs;
  var stockRentFix = 0.obs;
  var bikesTotal = 0.obs;
  var bikesBackTotal = 0.obs;
  var safy = 0.obs;

  MyService myService = Get.find();
  late TextEditingController billOutSearchController;
  late TextEditingController agentNameController;
  late TextEditingController agentPhoneController;
  late TextEditingController billNotesController;
  late TextEditingController discountController;
  late TextEditingController paidController;

  bool isShown = true;
  var isLoading = false.obs;

  @override
  void onInit() {
    billOutSearchController = TextEditingController();
    agentNameController = TextEditingController();
    agentPhoneController = TextEditingController();
    billNotesController = TextEditingController();
    discountController = TextEditingController();
    paidController = TextEditingController();
    getBillsOut();
    super.onInit();
  }

  @override
  void dispose() {
    billOutSearchController.dispose();
    agentNameController.dispose();
    agentPhoneController.dispose();
    billNotesController.dispose();
    discountController.dispose();
    paidController.dispose();
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
  getBillsOutSum({required int kind}) async {
    var getSum = await Crud.postRequest(
      MyStrings.apiGetBillsOutInDate,
      {
        'start_date': '${startDate.value.toString()} 00:00:00',
        'end_date': '${endDate.value.toString()} 23:59:00',
        'is_back': kind.toString(),
      },
      sumBillModelFromJson,
    );
    try {
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
            case 2:
              billsRentTotal.value = 0;
              break;
            case 3:
              billsfixTotal.value = 0;
              break;
            case 4:
              bikesTotal.value = 0;
              break;
            case 5:
              bikesBackTotal.value = 0;
              break;
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
            case 2:
              billsRentTotal.value = getSum.data[0].sumBillTotal;
              break;
            case 3:
              billsfixTotal.value = getSum.data[0].sumBillTotal;
              break;
            case 4:
              bikesTotal.value = getSum.data[0].sumBillTotal;
              break;
            case 5:
              bikesBackTotal.value = getSum.data[0].sumBillTotal;
              break;
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
      MyStrings.apiDeleteBillsOut,
      {'bill_id': billId},
      statusModelFromJson,
    );
    if (item.status == 'suc') {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [AppRoutes.searchBillOutScreen],
      );
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  addBillOut() async {
    isLoading.value = true;
    var addBillOut = await Crud.postRequest(
      MyStrings.apiAddBillsOut,
      {
        'agent_name': 'agent_name',
        'agent_phone': 'agent_phone',
      },
      statusModelFromJson,
    );
    try {
      if (addBillOut.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillOut.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  editBillOut({
    required String id,
    required String total,
    required String numberOfItems,
  }) async {
    isLoading.value = true;
    try {
      var editBillOut = await Crud.postRequest(
        MyStrings.apiEditBillsOut,
        {
          'agent_name': agentNameController.text,
          'agent_phone': agentPhoneController.text.trim(),
          'bill_notes': billNotesController.text,
          'bill_id': id,
          'bill_sup': 'bill_sup',
          'bill_total': total,
          'bill_discount': discountController.text,
          'bill_after_discount':
              (double.parse(total) - discountValue.value).toString(),
          'bill_paid': paidController.text,
          'bill_unpaid':
              ((double.parse(total) - discountValue.value) - paidValue.value)
                  .toString(),
          'bill_items': numberOfItems,
          // 'bill_timestamp': '${formatter.format(now)} 00:00:00'
        },
        statusModelFromJson,
      );
      if (editBillOut.status == "suc") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchBillOutScreen],
        );
        isLoading(false);
        update();
      } else if (editBillOut.status == "fail") {
        MySnackBar.snack(MyStrings.noitemsEdited, '');
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchBillOutScreen],
        );
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  saveBillOut({
    required String id,
    required String total,
    required String numberOfItems,
    required String isBack,
    required String workNum,
  }) async {
    isLoading.value = true;
    try {
      var saveBillOut = await Crud.postRequest(
        MyStrings.apiSaveBillsOut,
        {
          'agent_name': agentNameController.text,
          'agent_phone': agentPhoneController.text.trim(),
          'bill_notes': billNotesController.text,
          'work_num': workNum,
          'is_back': isBack,
          'bill_id': id,
          'bill_total': total,
          'bill_unpaid':
              (paidValue.value - (double.parse(total) - discountValue.value))
                  .toString(),
          'bill_paid': paidValue.value.toString(),
          'bill_discount': discountValue.value.toString(),
          'bill_after_discount':
              (double.parse(total) - discountValue.value).toString(),
          'bill_items': numberOfItems,
          'bill_timestamp':
              '${formatter.format(now)} ${DateTime.now().hour}:${DateTime.now().minute}:00',
        },
        statusModelFromJson,
      );
      if (saveBillOut.status == "suc") {
        if (isBack == '1') {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.addBackBillOutScreen],
          );
          isLoading(false);
          update();
        } else {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.addBillOutScreen],
          );
          isLoading(false);
          update();
        }
      } else if (saveBillOut.status == "fail") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchBillOutScreen],
        );
        isLoading(false);
        update();
      }
    } catch (_) {
      // MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }

  @override
  double unPaid({required double afterDiscount}) {
    if (paidValue.value == 0) {
      return afterDiscount;
    } else {
      return (paidValue.value - afterDiscount);
    }
  }

  @override
  double afterDiscount({required double total}) {
    if (discountValue.value == 0) {
      return total;
    } else {
      return (total - discountValue.value);
    }
  }

  @override
  getBillsOut() async {
    isLoading(true);
    var billOut = await Crud.postRequest(
      MyStrings.apiGetBillsOut,
      {},
      billModelFromJson,
    );
    try {
      if (billOut.status == 'fail') {
        isLoading(false);
        update();
      } else if (billOut.status == 'suc') {
        isLoading(false);
        billsOutList.addAll(billOut.data);
        billsOutListReversed = billsOutList.reversed.toList();
        update();
      }
    } catch (_) {}
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsOutSearchList = billsOutList.where(
      (bill) {
        var billId = bill.billId.toString();
        var billTotal = bill.billTotal.toString();
        var billAgentName = bill.agentName.toString();
        var billAgentPhone = bill.agentPhone.toString();

        return billId.contains(searchName) ||
            billTotal.contains(searchName) ||
            billAgentName.contains(searchName) ||
            billAgentPhone.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  void searchKind(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsOutSearchList = workBillsList.where(
      (bill) {
        var billBack = bill.isBack.toString();
        return billBack.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  void searchWorkBills(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsOutSearchList = workBillsList.where(
      (bill) {
        var billId = bill.billId.toString();
        var billTotal = bill.billTotal.toString();
        var billAgentName = bill.agentName.toString();
        var billAgentPhone = bill.agentPhone.toString();

        return billId.contains(searchName) ||
            billTotal.contains(searchName) ||
            billAgentName.contains(searchName) ||
            billAgentPhone.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  getitemsbyBillService(String workId) async {
    var bills = await Crud.postRequest(
      MyStrings.apiGetWorkBills,
      {'work_id': workId},
      billModelFromJson,
    );
    return bills.data;
  }

  @override
  getItemsbyBillId(String workId) async {
    var bills = await getitemsbyBillService(workId);
    isLoading(true);
    workBillsList.value = bills;
    isLoading(false);
    if (bills.isEmpty) {
      isLoading(false);
      update();
    }
  }

  @override
  getItemsByIndex(String workId) async {
    isLoading(true);
    var items = await getItemsbyBillId(workId);
    if (items != null) {
      workBillsList.value = items;
    }
    isLoading(false);
  }

  @override
  addPayment({
    required String workName,
    required String workId,
  }) async {
    var formData = billOutKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var addBillOut = await Crud.postRequest(
        MyStrings.apiAddBillsOut,
        {
          'agent_name': 'agent_name',
          'agent_phone': 'agent_phone',
        },
        statusModelFromJson,
      );
      try {
        if (addBillOut.status == "suc") {
          isLoading(false);
          update();
        } else if (addBillOut.status == "fail") {
          MySnackBar.snack('please try later', 'Some thing went wrong');
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
}
