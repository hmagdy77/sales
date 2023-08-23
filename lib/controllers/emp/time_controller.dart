import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/emp/day_model.dart';
import '../../models/emp/emp_model.dart';
import '../../models/status/status_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class TimeController extends GetxController {
  addDay({required Emp emp});
  exit(
      {required String dayId,
      required String minutes,
      required String exitTime});
  getAttendToday({required String date});
  void search(String searchName);
  edit({required String dayId});
  String convertMinutesToHoures({required int minutes});
}

class TimeControllerImp extends TimeController {
  late TextEditingController searchText;
  var isLoading = false.obs;
  List<Day> toDayList = <Day>[].obs;
  List<Day> searchDayList = <Day>[].obs;
  var datebirth = ''.obs;
  var exitFormatter = DateFormat("yyyy-MM-dd hh:mm:ss");
  var dayFormater = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var timeFormatter = DateFormat.jm().format(DateTime.now());
  GlobalKey<FormState> attendKey = GlobalKey<FormState>();

  @override
  void onInit() {
    getAttendToday(date: dayFormater);
    searchText = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  @override
  addDay({required Emp emp}) async {
    isLoading.value = true;
    var addItem = await Crud.postRequest(
        MyStrings.apiAddEmpDay,
        {
          'emp_name': emp.empName,
          'emp_jop': emp.empJop,
          'emp_sal': emp.empSal.toString(),
          'emp_hours': emp.empHours.toString(),
          'emp_id': emp.empId.toString(),
          'day': dayFormater,
          'emp_attend': DateTime.now().toString(),
          'emp_exit': DateTime.now().toString(),
          'emp_holiday': '0',
          'emp_rest': '0',
          'emp_notes': '0',
          'minutes': '0',
          'exept': '0',
        },
        statusModelFromJson);

    try {
      if (addItem.status == "suc") {
        isLoading(false);
        update();
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.attendScreen],
        );
      } else if (addItem.status == "found") {
        MySnackBar.snack(MyStrings.alreadyAttend, '');
        isLoading(false);
        update();
      } else if (addItem.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  exit(
      {required String dayId,
      required String minutes,
      required String exitTime}) async {
    isLoading.value = true;
    var exit = await Crud.postRequest(
        MyStrings.apiExitEmpDay,
        {
          'day_id': dayId,
          'emp_exit': exitTime,
          'minutes': minutes,
        },
        statusModelFromJson);
    try {
      if (exit.status == "suc") {
        isLoading(false);
        update();
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.attendScreen],
        );
      } else if (exit.status == "found") {
        MySnackBar.snack(MyStrings.alreadyExit, '');
        isLoading(false);
        update();
      } else if (exit.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  getAttendToday({required String date}) async {
    isLoading(true);
    var day = await Crud.postRequest(
      MyStrings.apiViewAttendToday,
      {
        'day': date,
      },
      dayModelFromJson,
    );
    if (day.status == 'fail') {
      isLoading(false);
      update();
    } else if (day.status == 'suc') {
      isLoading(false);
      toDayList.addAll(day.data);
      update();
    }
    try {} catch (_) {}
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchDayList = toDayList.where(
      (day) {
        var empId = day.empId.toString();
        var empName = day.empName.toString();
        var empJop = day.empJop.toString();
        var empSal = day.empSal.toString();
        return empId.contains(searchName) ||
            empName.contains(searchName) ||
            empJop.contains(searchName) ||
            empSal.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  String convertMinutesToHoures({required int minutes}) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')} ساعة و ${parts[1].padLeft(2, '0')} دقيقة';
  }

  @override
  edit({required String dayId}) async {
    var formData = attendKey.currentState;
    if (formData!.validate()) {
      try {
        isLoading.value = true;
        var exit = await Crud.postRequest(
            MyStrings.apiEditEmpDay,
            {
              'day_id': dayId,
            },
            statusModelFromJson);
        if (exit.status == "suc") {
          isLoading(false);
          update();
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.attendScreen],
          );
        } else if (exit.status == "fail") {
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
}
