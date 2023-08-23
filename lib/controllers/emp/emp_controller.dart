import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/emp/emp_model.dart';
import '../../models/status/status_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class EmpController extends GetxController {
  addEmp();
  editEmp({required String empId, required int isStopped});
  deleteEmp({required String empId});
  getEmps();
  void search(String searchName);
  getDate(
      {required context,
      required bool birth,
      required bool start,
      required bool end});
}

class EmpControllerImp extends EmpController {
  late TextEditingController nameText;
  late TextEditingController tel1Text;
  late TextEditingController tel2Text;
  late TextEditingController natIdText;
  late TextEditingController saleryText;
  late TextEditingController hoursText;
  late TextEditingController addressText;
  late TextEditingController searchText;
  GlobalKey<FormState> empKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  List<Emp> empList = <Emp>[].obs;
  List<Emp> searchEmpList = <Emp>[].obs;
  var datebirth = ''.obs;
  var startWork = ''.obs;
  var endWork = ''.obs;
  var formatter = DateFormat('yyyy-MM-dd');
  var selectedJop = ''.obs;

  @override
  void onInit() {
    nameText = TextEditingController();
    tel1Text = TextEditingController();
    tel2Text = TextEditingController();
    natIdText = TextEditingController();
    saleryText = TextEditingController();
    hoursText = TextEditingController();
    addressText = TextEditingController();
    searchText = TextEditingController();
    getEmps();
    super.onInit();
  }

  @override
  void dispose() {
    nameText.dispose();
    tel1Text.dispose();
    tel2Text.dispose();
    natIdText.dispose();
    saleryText.dispose();
    hoursText.dispose();
    addressText.dispose();
    searchText.dispose();
    super.dispose();
  }

  DateTime? selectedMonth;

  @override
  getDate(
      {required context,
      required bool birth,
      required bool start,
      required bool end}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      locale: const Locale('ar'),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        if (birth) {
          datebirth.value = formatter.format(pickedDate);
        } else if (start) {
          startWork.value = formatter.format(pickedDate);
        } else if (end) {
          endWork.value = formatter.format(pickedDate);
        }
      },
    );
  }

  @override
  addEmp() async {
    var formData = empKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var addItem = await Crud.postRequest(
          MyStrings.apiAddEmp,
          {
            'emp_name': nameText.text,
            'emp_tel1': tel1Text.text,
            'emp_tel2': tel2Text.text,
            'emp_birth': datebirth.value,
            'emp_natid': natIdText.text,
            'emp_address': addressText.text,
            'emp_jop': selectedJop.value,
            'emp_work_start': startWork.value,
            'emp_work_end': endWork.value,
            'emp_sal': saleryText.text,
            'emp_hours': hoursText.text,
          },
          statusModelFromJson);
      try {
        if (addItem.status == "suc") {
          isLoading(false);
          update();
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.addEmpScreen],
          );
        } else if (addItem.status == "fail") {
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
  editEmp({required String empId, required int isStopped}) async {
    var formData = empKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var editEmp = await Crud.postRequest(
          MyStrings.apiEditEmp,
          {
            'emp_name': nameText.text,
            'emp_tel1': tel1Text.text,
            'emp_tel2': tel2Text.text,
            'emp_birth': datebirth.value,
            'emp_natid': natIdText.text,
            'emp_address': addressText.text,
            'emp_jop': selectedJop.value,
            'emp_work_start': startWork.value,
            'emp_work_end': endWork.value,
            'emp_stopped': isStopped.toString(),
            'emp_sal': saleryText.text,
            'emp_hours': hoursText.text,
            'emp_id': empId,
          },
          statusModelFromJson);
      try {
        if (editEmp.status == "suc") {
          isLoading(false);
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.searchEmpScreen],
          );
          update();
        } else if (editEmp.status == "fail") {
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
  getEmps() async {
    isLoading(true);
    var emp = await Crud.postRequest(
      MyStrings.apiViewEmp,
      {},
      empModelFromJson,
    );
    try {
      if (emp.status == 'fail') {
        isLoading(false);
        update();
      } else if (emp.status == 'suc') {
        isLoading(false);
        empList.addAll(emp.data);
        update();
      }
    } catch (_) {}
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchEmpList = empList.where(
      (emp) {
        var empName = emp.empName;
        var empId = emp.empId.toString();
        var empTel1 = emp.empTel1.toString();
        var empTel2 = emp.empTel2.toString();
        var empNatid = emp.empNatid.toString();
        var empJop = emp.empJop.toString();

        return empName.contains(searchName) ||
            empId.contains(searchName) ||
            empTel1.contains(searchName) ||
            empTel2.contains(searchName) ||
            empNatid.contains(searchName) ||
            empJop.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deleteEmp({required String empId}) async {
    isLoading(true);
    var emp = await Crud.postRequest(
      MyStrings.apiDeleteEmp,
      {
        'emp_id': empId,
      },
      statusModelFromJson,
    );
    if (emp.status == 'suc') {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [AppRoutes.searchEmpScreen],
      );
      update();
    } else if (emp.status == 'fail') {
      isLoading(false);
      update();
    }
  }
}
