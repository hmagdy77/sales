import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../core/service/services.dart';
import '../../models/bills/sum_bill_model.dart';
import '../../models/emp/emp_model.dart';
import '../../models/items/item_model.dart';
import '../../models/status/status_model.dart';
import '../../models/works/work_model.dart';
import '../../models/works/work_payment.dart';
import '../../models/works/works_payment.dart';
import '../../models/works/works_sales.dart';
import '../../routes.dart';

abstract class WorkController extends GetxController {
  getWorks();
  addWork({required String workName});
  closeWork({required int workId});
  updateTotal({required String workId, required double total});
  getlastWork();
  search(String searchName);
  getBillsSum({required String workId, required int isBack});
  getWorkItems({required String workId});
  getCasheirs();
  addWorkPayment({required String workName, required String workId});
  getWorkPayment({required String workId});
  deleteWorkPayment({required String paymentId});
  updateWorkPayment({
    required String workId,
    required String total, //required Work work
  });
}

class WorkControllerImp extends WorkController {
  List<Work> lastWork = <Work>[].obs;
  List<Work> worksList = <Work>[].obs;
  List<Work> worksListReversed = <Work>[].obs;
  List<Work> worksSearchList = <Work>[].obs;
  List<Item> worksItemsList = <Item>[].obs;
  List<WorkPayment> worksPaymentList = <WorkPayment>[].obs;
  List<Emp> casheirslist = <Emp>[].obs;
  var selectedJop = ''.obs;
  var selectedBillKind = ''.obs;
  GlobalKey<FormState> workKey = GlobalKey<FormState>();
  var worksSalesSum = 0.obs;
  var worksPaymentSum = 0.obs;

  var sum = 0.obs;
  var count = 0.obs;
  var sumLabel = MyStrings.currentValue.obs;
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;
  var billsTotal = 0.obs;
  MyService myService = Get.find();
  late TextEditingController workSearch;
  late TextEditingController workNotes;
  late TextEditingController workPayment;

  bool isShown = true;
  var isLoading = false.obs;

  @override
  void onInit() {
    workSearch = TextEditingController();
    workNotes = TextEditingController();
    workPayment = TextEditingController();
    getWorks();
    getCasheirs();
    getlastWork();
    super.onInit();
  }

  @override
  void dispose() {
    workSearch.dispose();
    workNotes.dispose();
    workPayment.dispose();
    super.dispose();
  }

  @override
  getWorks() async {
    isLoading(true);
    var work = await Crud.postRequest(
      MyStrings.apiGetWorks,
      {},
      workModelFromJson,
    );
    try {
      if (work.status == 'fail') {
        isLoading(false);
        update();
      } else if (work.status == 'suc') {
        isLoading(false);
        worksList.addAll(work.data);
        worksListReversed = worksList.reversed.toList();
        update();
      }
    } catch (_) {}
  }

  @override
  addWork({required String workName}) async {
    isLoading.value = true;
    var addWork = await Crud.postRequest(
      MyStrings.apiAddWork,
      {
        'work_name': workName,
      },
      statusModelFromJson,
    );
    try {
      if (addWork.status == "suc") {
        isLoading(false);
        getlastWork();
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchWorkScreen],
        );
        update();
      } else if (addWork.status == "fail") {
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
  closeWork({
    required int workId,
  }) async {
    isLoading.value = true;
    try {
      var closeWork = await Crud.postRequest(
        MyStrings.apiColseWork,
        {
          'work_id': workId.toString(),
          'work_end':
              '${formatter.format(now)} ${DateTime.now().hour}:${DateTime.now().minute}:00',
          'work_closed': '1',
        },
        statusModelFromJson,
      );
      if (closeWork.status == "suc") {
        getlastWork();
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchWorkScreen],
        );
        isLoading(false);
        update();
      } else if (closeWork.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  updateTotal({
    required String workId,
    required double total,
  }) async {
    isLoading.value = true;
    try {
      var update = await Crud.postRequest(
        MyStrings.apiUpdateTotalWork,
        {
          'work_id': workId,
          'work_total': total.toString(),
        },
        statusModelFromJson,
      );
      if (update.status == "suc") {
        isLoading(false);
        update();
      } else if (update.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  getlastWork() async {
    isLoading(true);
    var work = await Crud.postRequest(
      MyStrings.apiGetLastWork,
      {},
      workModelFromJson,
    );
    try {
      if (work.status == 'fail') {
        isLoading(false);
        update();
      } else if (work.status == 'suc') {
        isLoading(false);
        lastWork.addAll(work.data);
        update();
      }
    } catch (_) {}
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    worksSearchList = worksList.where(
      (work) {
        var workId = work.workId.toString();
        var workName = work.workName.toString();
        var workTotal = work.workTotal.toString();

        return workId.contains(searchName) ||
            workName.contains(searchName) ||
            workTotal.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  getWorkItems({required String workId}) async {
    isLoading(true);
    var work = await Crud.postRequest(
      MyStrings.apiGetWorkItems,
      {'work_id': workId},
      itemModelFromJson,
    );
    try {
      if (work.status == 'fail') {
        isLoading(false);
        update();
      } else if (work.status == 'suc') {
        isLoading(false);
        worksItemsList.addAll(work.data);
        update();
      }
    } catch (_) {}
  }

  @override
  getBillsSum({required String workId, required int isBack}) async {
    isLoading(true);
    try {
      var sumR = await Crud.postRequest(
        MyStrings.apiGetSumWork,
        {
          'work_num': workId,
          'is_back': isBack.toString(),
        },
        sumBillModelFromJson,
      );
      if (sumR.status == 'fail') {
        isLoading(false);
        update();
      } else if (sumR.status == 'suc') {
        if (sumR.data[0].sumBillTotal == null) {
          sum.value = 0;
          isLoading(false);
          update();
        } else {
          sum.value = sumR.data[0].sumBillTotal;
          isLoading(false);
          update();
        }
      }
    } catch (_) {}
  }

  @override
  getCasheirs() async {
    isLoading(true);
    var emp = await Crud.postRequest(
      MyStrings.apiViewbyJop,
      {
        'emp_jop': MyStrings.cashier,
      },
      empModelFromJson,
    );
    try {
      if (emp.status == 'fail') {
        isLoading(false);
        update();
      } else if (emp.status == 'suc') {
        isLoading(false);
        casheirslist.addAll(emp.data);
        update();
      }
    } catch (_) {}
  }

  @override
  addWorkPayment({
    required String workName,
    required String workId,
  }) async {
    var formData = workKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      try {
        var addWork = await Crud.postRequest(
          MyStrings.apiAddWorkPayment,
          {
            'work_name': workName,
            'work_id': workId,
            'notes': workNotes.text,
            'payment_total': workPayment.text,
          },
          statusModelFromJson,
        );
        if (addWork.status == "suc") {
          isLoading(false);
          getlastWork();
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.searchWorkScreen],
          );
          update();
        } else if (addWork.status == "fail") {
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
  getWorkPayment({required String workId}) async {
    isLoading(true);
    var work = await Crud.postRequest(
      MyStrings.apiGetWorkPayment,
      {'work_id': workId},
      workPaymentModelFromJson,
    );
    try {
      if (work.status == 'fail') {
        isLoading(false);
        update();
      } else if (work.status == 'suc') {
        isLoading(false);
        worksPaymentList.addAll(work.data);
        update();
      }
    } catch (_) {}
  }

  @override
  deleteWorkPayment({
    required String paymentId,
  }) async {
    var addWork = await Crud.postRequest(
      MyStrings.apiDeleteWorkPayment,
      {
        'payment_id': paymentId,
      },
      statusModelFromJson,
    );
    if (addWork.status == "suc") {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [AppRoutes.searchWorkScreen],
      );
      update();
    } else if (addWork.status == "fail") {
      isLoading(false);
      update();
    }
    try {} catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  updateWorkPayment({
    required String workId,
    required String total,
    // required Work work,
  }) async {
    isLoading.value = true;
    var addWork = await Crud.postRequest(
      MyStrings.apiUpdateWorkPayment,
      {
        'work_id': workId,
        'work_payment': total,
      },
      statusModelFromJson,
    );
    if (addWork.status == "suc") {
      isLoading(false);
      getlastWork();
      update();
    } else if (addWork.status == "fail") {
      isLoading(false);
      update();
    }
    try {} catch (_) {
      isLoading(false);
      update();
    }
  }

  sumWorkSales({required String start, required String end}) async {
    {
      var getSum = await Crud.postRequest(
        MyStrings.apiGetWorksSales,
        {
          'start_date': '$start 00:00:00',
          'end_date': '$end 23:59:00',
        },
        worksSalesFromJson,
      );
      if (getSum.status == 'fail') {
        isLoading(false);
        update();
      } else if (getSum.status == 'suc') {
        if (getSum.data[0].sumWorkTotal == null) {
          worksSalesSum.value = 0;
          isLoading(false);
          update();
        } else {
          worksSalesSum.value = getSum.data[0].sumWorkTotal;
          isLoading(false);
          update();
        }
      }
      try {} catch (_) {}
    }
  }

  sumWorkPayment({required String start, required String end}) async {
    {
      var getSum = await Crud.postRequest(
        MyStrings.apiGetWorksPayment,
        {
          'start_date': '$start 00:00:00',
          'end_date': '$end 23:59:00',
        },
        worksPaymentFromJson,
      );
      if (getSum.status == 'fail') {
        isLoading(false);
        update();
      } else if (getSum.status == 'suc') {
        if (getSum.data[0].sumWorkPayment == null) {
          worksPaymentSum.value = 0;
          isLoading(false);
          update();
        } else {
          worksPaymentSum.value = getSum.data[0].sumWorkPayment;
          isLoading(false);
          update();
        }
      }
      try {} catch (_) {}
    }
  }
}
