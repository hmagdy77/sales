import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/emp/day_model.dart';
import '../../models/emp/emp_model.dart';
import '../../models/status/status_model.dart';
import '../../routes.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../view/widgets/login/snackbar.dart';

abstract class AttendController extends GetxController {
  addAbsence({required Emp emp});
  makeAllAbsence({required List<Emp> empList});
  attend({required Day day, required String holiday});
  edit({required Day day});
  exit(
      {required String dayId,
      required String minutes,
      required String exitTime,
      required String empId});
  attendLogForEmp({
    required String empId,
    required String start,
    required String end,
  });
  getAttendToday({required String date});
  selectMonth({
    required BuildContext context,
    required bool forEmp,
    Emp emp,
  });
  void search(String searchName);
  String convertMinutesToHoures({required int minutes});
  addSalery({required Emp emp, required DateTime date});
  upDateSalery({
    required String empId,
    required DateTime date,
    required String minutes,
    required String rest,
    required String holiday,
    required String absence,
    required String attend,
    required String exept,
    required String payment,
    required String bouns,
  });
}

class AttendControllerImp extends AttendController {
  late TextEditingController searchText;
  var isLoading = false.obs;
  List<Day> toDayList = <Day>[].obs;
  List<Day> searchDayList = <Day>[].obs;
  List<Day> attendLogForEmpList = <Day>[].obs;
  var datebirth = ''.obs;
  var exitFormatter = DateFormat("yyyy-MM-dd hh:mm:ss");
  var dayFormater = DateFormat('yyyy-MM-dd');
  var dayNowFormater = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var timeNowFormatter = DateFormat.jm().format(DateTime.now());
  GlobalKey<FormState> attendKey = GlobalKey<FormState>();
  late TextEditingController restText;
  late TextEditingController paymentText;
  late TextEditingController discountText;
  late TextEditingController bounsText;
  late TextEditingController notesText;
  DateTime? selectedMonth;
  var selectedJop = ''.obs;

  @override
  void onInit() {
    getAttendToday(date: dayNowFormater);
    searchText = TextEditingController();
    restText = TextEditingController();
    paymentText = TextEditingController();
    discountText = TextEditingController();
    bounsText = TextEditingController();
    notesText = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    searchText.dispose();
    restText.dispose();
    paymentText.dispose();
    discountText.dispose();
    bounsText.dispose();
    notesText.dispose();
    super.dispose();
  }

  @override
  addAbsence({required Emp emp}) async {
    // isLoading.value = true;
    await Crud.postRequest(
        MyStrings.apiAddEmpAbsence,
        {
          'emp_name': emp.empName,
          'emp_jop': emp.empJop,
          'emp_sal': emp.empSal.toString(),
          'emp_hours': emp.empHours.toString(),
          'emp_id': emp.empId.toString(),
          'day': dayNowFormater,
          'emp_absence': '1',
          'emp_notes': '',
        },
        statusModelFromJson);
  }

  @override
  makeAllAbsence({required List<Emp> empList}) {
    isLoading(true);
    update();
    for (int index = 0; index < empList.length; index++) {
      if (empList[index].empStopped == 0) {
        addAbsence(emp: empList[index]);
        addSalery(emp: empList[index], date: DateTime.now());
        upDateSalery(
          empId: empList[index].empId.toString(),
          date: DateTime.now(),
          absence: '0',
          attend: '0',
          bouns: '0',
          exept: '0',
          holiday: '0',
          minutes: '0',
          payment: '0',
          rest: '0',
        );
      }
    }

    isLoading(false);
    update();
  }

  @override
  attend({
    required Day day,
    required String holiday,
  }) async {
    isLoading.value = true;
    var addDay = await Crud.postRequest(
        MyStrings.apiMakeEmpattend,
        {
          'day_id': day.dayId.toString(),
          'emp_attend': DateTime.now().toString(),
          'emp_holiday': holiday,
          'emp_absence': '0',
          'minutes': holiday == '1' ? (day.empHours * 60).toString() : '0',
        },
        statusModelFromJson);
    if (addDay.status == "suc") {
      upDateSalery(
        empId: day.empId.toString(),
        date: DateTime.now(),
        absence: '0',
        attend: '0',
        bouns: '0',
        exept: '0',
        holiday: holiday == '1' ? '1' : '0',
        minutes: holiday == '1' ? (day.empHours * 60).toString() : '0',
        payment: '0',
        rest: '0',
      );
      isLoading(false);
      update();
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [AppRoutes.attendScreen],
      );
    } else if (addDay.status == "fail") {
      isLoading(false);
      update();
    }
    try {} catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  edit({
    required Day day,
  }) async {
    var formData = attendKey.currentState;
    if (formData!.validate()) {
      try {
        isLoading.value = true;
        var edit = await Crud.postRequest(
            MyStrings.apiEditEmpDay,
            {
              'day_id': day.dayId.toString(),
              'emp_notes': notesText.text,
              'exept': discountText.text,
              'emp_rest': restText.text,
              'bouns': bounsText.text,
              'payment': paymentText.text,
            },
            statusModelFromJson);
        if (edit.status == "suc") {
          upDateSalery(
            empId: day.empId.toString(),
            date: DateTime.now(),
            absence: '0',
            attend: '0',
            holiday: '0',
            minutes: '0',
            payment: (int.parse(paymentText.text) - day.payment).toString(),
            rest: (int.parse(restText.text) - day.empRest).toString(),
            bouns: (int.parse(bounsText.text) - day.bouns).toString(),
            exept: (int.parse(discountText.text) - day.exept).toString(),
          );
          isLoading(false);
          update();
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.attendScreen],
          );
        } else if (edit.status == "fail") {
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
  exit(
      {required String dayId,
      required String empId,
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
        upDateSalery(
          empId: empId,
          date: DateTime.now(),
          absence: '0',
          attend: '1',
          holiday: '0',
          minutes: minutes,
          payment: '0',
          rest: '0',
          bouns: '0',
          exept: '0',
        );
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
  attendLogForEmp(
      {required String empId,
      required String start,
      required String end}) async {
    isLoading(true);
    var day = await Crud.postRequest(
      MyStrings.apiViewattendLogForEmp,
      {
        'emp_id': empId,
        'start': start,
        'end': end,
      },
      dayModelFromJson,
    );
    if (day.status == 'fail') {
      isLoading(false);
      update();
    } else if (day.status == 'suc') {
      isLoading(false);
      attendLogForEmpList.addAll(day.data);
      update();
    }
    try {} catch (_) {}
  }

  @override
  getAttendToday({required String date}) async {
    isLoading(true);
    try {
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
    } catch (_) {}
  }

  @override
  selectMonth({
    required BuildContext context,
    required bool forEmp,
    Emp? emp,
  }) {
    showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      locale: const Locale('ar'),
    ).then(
      (pickedDate) async {
        if (pickedDate == null) {
          return;
        } else {
          int year = pickedDate.year;
          int month = pickedDate.month;
          if (forEmp) {
            DateTime thisMonth = DateTime(year, month, 1);
            DateTime nextMonth = DateTime(year, month + 1, 0);
            isLoading(true);
            attendLogForEmp(
              empId: emp!.empId.toString(),
              start: dayFormater.format(thisMonth),
              end: dayFormater.format(nextMonth),
            );
            isLoading(false);
            Get.toNamed(
              AppRoutes.empMonthViewScreen,
              arguments: [pickedDate, emp],
            );
          } else {
            DateTime thisMonth; //= DateTime(year, month, 0);
            DateTime nextMonth; //= DateTime(year, month + 1, 0);
            if (month == DateTime.april) {
              thisMonth = DateTime(year, month, 0);
              nextMonth = DateTime(year, month + 1, 1);
            } else {
              thisMonth = DateTime(year, month, 0);
              nextMonth = DateTime(year, month + 1, 0);
            }
            int days = nextMonth.difference(thisMonth).inDays;
            Get.offAllNamed(
              AppRoutes.monthViewScreen,
              arguments: [pickedDate, days],
            );
          }
        }
      },
    );
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
  addSalery({required Emp emp, required DateTime date}) async {
    isLoading(true);
    var monthSalery = await Crud.postRequest(
        MyStrings.apiAddEmpSalery,
        {
          'emp_id': emp.empId.toString(),
          'emp_name': emp.empName,
          'emp_jop': emp.empJop,
          'emp_sal': emp.empSal.toString(),
          'emp_hours': emp.empHours.toString(),
          'year': date.year.toString(),
          'month': date.month.toString(),
        },
        statusModelFromJson);
    if (monthSalery.status == 'fail') {
      isLoading(false);
      update();
    } else if (monthSalery.status == 'suc') {
      isLoading(false);
      update();
    }
    try {} catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  upDateSalery({
    required String empId,
    required DateTime date,
    required String minutes,
    required String rest,
    required String holiday,
    required String absence,
    required String attend,
    required String exept,
    required String payment,
    required String bouns,
  }) async {
    isLoading(true);
    var monthSalery = await Crud.postRequest(
        MyStrings.apiUpdateEmpSalery,
        {
          'emp_id': empId.toString(),
          'year': date.year.toString(),
          'month': date.month.toString(),
          'minutes_rest': rest,
          'minutes': minutes,
          'holiday': holiday,
          'absence': absence,
          'attend': attend,
          'exept': exept,
          'payment': payment,
          'bouns': bouns,
        },
        statusModelFromJson);
    if (monthSalery.status == 'fail') {
      isLoading(false);
      update();
    } else if (monthSalery.status == 'suc') {
      isLoading(false);
      update();
    }
    try {} catch (_) {
      isLoading(false);
      update();
    }
  }
}
