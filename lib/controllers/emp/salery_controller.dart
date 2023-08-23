import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/emp/emp_model.dart';
import '../../models/emp/emp_salery.dart';
import '../../routes.dart';
import 'package:month_year_picker/month_year_picker.dart';

abstract class SaleryController extends GetxController {
  saleryForEmp({required String empId, required DateTime date});
  selectMonth({required BuildContext context, required bool forEmp, Emp emp});
  String calucalateSalery({required EmpSalery empSalery});
  getMonthSalery({required DateTime date});
  void search(String searchName);
  String convertMinutesToHoures({required int minutes});
}

class SaleryControllerImp extends SaleryController {
  late TextEditingController searchText;
  var isLoading = false.obs;
  List<EmpSalery> empSaleryList = <EmpSalery>[].obs;
  List<EmpSalery> monthSaleryList = <EmpSalery>[].obs;
  List<EmpSalery> searchSaleryList = <EmpSalery>[].obs;
  EmpSalery emptySalery = EmpSalery(
    absence: 0,
    attend: 0,
    bouns: 0,
    empHours: 0,
    empId: 0,
    empJop: '0',
    empName: '0',
    empSal: 0,
    exept: 0,
    holiday: 0,
    minutes: 0,
    minutesRest: 0,
    month: '0',
    monthId: 0,
    payment: 0,
    year: '0',
  );
  var datebirth = ''.obs;
  var exitFormatter = DateFormat("yyyy-MM-dd hh:mm:ss");
  var dayNowFormater = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var dayFormater = DateFormat('yyyy-MM-dd');
  var timeNowFormatter = DateFormat.jm().format(DateTime.now());
  GlobalKey<FormState> attendKey = GlobalKey<FormState>();
  var selectedJop = ''.obs;
  final Emp emptyEmp = Emp(
      empId: 0,
      empName: '',
      empTel1: '',
      empTel2: '',
      empBirth: DateTime(2000),
      empNatid: '',
      empAddress: '',
      empJop: '',
      empWorkStart: DateTime(2000),
      empWorkEnd: DateTime(2000),
      empStopped: 0,
      empSal: 0,
      empHours: 0);

  @override
  void onInit() {
    searchText = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    searchText.dispose();

    super.dispose();
  }

  @override
  saleryForEmp({required String empId, required DateTime date}) async {
    isLoading(true);
    var salery = await Crud.postRequest(
      MyStrings.apiGetEmpSalery,
      {
        'year': date.year.toString(),
        'month': date.month.toString(),
        'emp_id': empId,
      },
      empSaleryModelFromJson,
    );
    if (salery.status == 'fail') {
      empSaleryList.add(emptySalery);
      isLoading(false);
      update();
    } else if (salery.status == 'suc') {
      isLoading(false);
      empSaleryList.addAll(salery.data);
      update();
    }
    try {} catch (_) {}
  }

  @override
  selectMonth(
      {required BuildContext context,
      required bool forEmp,
      Emp? emp,
      String? empId}) {
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
            DateTime thisMonth;
            DateTime nextMonth;
            if (month == DateTime.april) {
              thisMonth = DateTime(year, month, 0);
              nextMonth = DateTime(year, month + 1, 1);
            } else {
              thisMonth = DateTime(year, month, 0);
              nextMonth = DateTime(year, month + 1, 0);
            }
            int days = nextMonth.difference(thisMonth).inDays;
            isLoading(true);
            await saleryForEmp(
              empId: empId ?? emp!.empId.toString(),
              date: pickedDate,
            );
            Get.toNamed(
              AppRoutes.empSaleryScreen,
              arguments: [
                pickedDate,
                days,
                empSaleryList.first,
                emp,
              ],
            );
            isLoading(false);
          } else {
            DateTime thisMonth;
            DateTime nextMonth;
            if (month == DateTime.april) {
              thisMonth = DateTime(year, month, 0);
              nextMonth = DateTime(year, month + 1, 1);
            } else {
              thisMonth = DateTime(year, month, 0);
              nextMonth = DateTime(year, month + 1, 0);
            }
            int days = nextMonth.difference(thisMonth).inDays;
            getMonthSalery(date: pickedDate);
            Get.toNamed(
              AppRoutes.monthSaleryScreen,
              arguments: [pickedDate, days],
            );
          }
        }
      },
    );
  }

  @override
  String calucalateSalery({required EmpSalery empSalery}) {
    double saleryMinute = empSalery.empSal / 30 / empSalery.empHours / 60;
    int minutes = empSalery.minutes - empSalery.minutesRest;
    double salery = saleryMinute * minutes;
    int discount = empSalery.exept + empSalery.payment;
    double safy = salery + empSalery.bouns - discount;
    return safy.toStringAsFixed(2);
  }

  @override
  getMonthSalery({required DateTime date}) async {
    isLoading(true);
    var monthSalery = await Crud.postRequest(
        MyStrings.apiGetMonthSalery,
        {
          'year': date.year.toString(),
          'month': date.month.toString(),
        },
        empSaleryModelFromJson);
    if (monthSalery.status == 'fail') {
      isLoading(false);
      update();
    } else if (monthSalery.status == 'suc') {
      isLoading(false);
      monthSaleryList.addAll(monthSalery.data);
      update();
    }
    try {} catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchSaleryList = monthSaleryList.where(
      (monthSalery) {
        var empId = monthSalery.empId.toString();
        var empName = monthSalery.empName.toString();
        var empJop = monthSalery.empJop.toString();
        var empSal = monthSalery.empSal.toString();
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
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../core/functions/crud.dart';
// import '../../../view/widgets/login/snackbar.dart';
// import '../../core/constants/app_strings.dart';
// import '../../models/emp/day_model.dart';
// import '../../models/emp/emp_model.dart';
// import '../../models/emp/emp_salery.dart';
// import '../../models/emp/salery/absence.dart';
// import '../../models/emp/salery/attend.dart';
// import '../../models/emp/salery/bouns.dart';
// import '../../models/emp/salery/discount.dart';
// import '../../models/emp/salery/holiday.dart';
// import '../../models/emp/salery/minutes.dart';
// import '../../models/emp/salery/minutes_rest.dart';
// import '../../models/emp/salery/payment.dart';
// import '../../models/status/status_model.dart';
// import '../../routes.dart';
// import 'package:month_year_picker/month_year_picker.dart';

// abstract class SaleryController extends GetxController {
//   selectMonth({required BuildContext context, Emp emp});
//   void search(String searchName);
//   double calucalateSalery({required EmpSalery empSalery});
//   String convertMinutesToHoures({required int minutes});
// }

// class SaleryControllerImp extends SaleryController {
//   late TextEditingController searchText;
//   var isLoading = false.obs;
//   List<EmpSalery> empSaleryList = <EmpSalery>[].obs;
//   List<EmpSalery> monthSaleryList = <EmpSalery>[].obs;
//   List<EmpSalery> searchSaleryList = <EmpSalery>[].obs;
//   EmpSalery emptySalery = EmpSalery(
//     absence: 0,
//     attend: 0,
//     bouns: 0,
//     empHours: 0,
//     empId: 0,
//     empJop: '0',
//     empName: '0',
//     empSal: 0,
//     exept: 0,
//     holiday: 0,
//     minutes: 0,
//     minutesRest: 0,
//     month: '0',
//     monthId: 0,
//     payment: 0,
//     year: '0',
//   );

//   var startDate = DateTime.now().obs;
//   var endDate = DateTime.now().obs;
//   var exitFormatter = DateFormat("yyyy-MM-dd hh:mm:ss");
//   var dayNowFormater = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   var dayFormater = DateFormat('yyyy-MM-dd');
//   var timeNowFormatter = DateFormat.jm().format(DateTime.now());
//   var selectedJop = ''.obs;
//   var paymentVal = ''.obs;
//   var bounsVal = ''.obs;
//   var attendVal = ''.obs;
//   var abcensVal = ''.obs;
//   var holidayVal = ''.obs;
//   var minutesVal = ''.obs;
//   var restVal = ''.obs;
//   var discountVal = ''.obs;

//   final Emp emptyEmp = Emp(
//       empId: 0,
//       empName: '',
//       empTel1: '',
//       empTel2: '',
//       empBirth: DateTime(2000),
//       empNatid: '',
//       empAddress: '',
//       empJop: '',
//       empWorkStart: DateTime(2000),
//       empWorkEnd: DateTime(2000),
//       empStopped: 0,
//       empSal: 0,
//       empHours: 0);

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   selectMonth({required BuildContext context, Emp? emp}) {
//     showMonthYearPicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2019),
//       lastDate: DateTime(2030),
//       locale: const Locale('ar'),
//     ).then(
//       (pickedDate) async {
//         if (pickedDate == null) {
//           return;
//         } else {
//           int year = pickedDate.year;
//           int month = pickedDate.month;

//           if (month == DateTime.april) {
//             startDate.value = DateTime(year, month, 0);
//             endDate.value = DateTime(year, month + 1, 1);
//           } else {
//             startDate.value = DateTime(year, month, 0);
//             endDate.value = DateTime(year, month + 1, 0);
//           }
//           int days = endDate.value.difference(startDate.value).inDays;
//           isLoading(true);
//           // Get.toNamed(
//           //   AppRoutes.empSaleryScreen,
//           //   arguments: [
//           //     pickedDate,
//           //     days,
//           //     empSaleryList.first,
//           //     emp,
//           //   ],
//           // );
//           getPaymentSum(empId: emp!.empId.toString());
//           isLoading(false);
//         }
//       },
//     );
//   }

//   @override
//   double calucalateSalery({required EmpSalery empSalery}) {
//     double saleryMinute = empSalery.empSal / 30 / empSalery.empHours / 60;
//     int minutes = empSalery.minutes - empSalery.minutesRest;
//     double salery = saleryMinute * minutes;
//     int discount = empSalery.exept + empSalery.payment;
//     double safy = salery + empSalery.bouns - discount;
//     return safy;
//   }

//   @override
//   void search(String searchName) {
//     isLoading(true);
//     searchName = searchName.toLowerCase();
//     searchSaleryList = monthSaleryList.where(
//       (monthSalery) {
//         var empId = monthSalery.empId.toString();
//         var empName = monthSalery.empName.toString();
//         var empJop = monthSalery.empJop.toString();
//         var empSal = monthSalery.empSal.toString();
//         return empId.contains(searchName) ||
//             empName.contains(searchName) ||
//             empJop.contains(searchName) ||
//             empSal.contains(searchName);
//       },
//     ).toList();
//     isLoading(false);
//     update();
//   }

//   @override
//   String convertMinutesToHoures({required int minutes}) {
//     var d = Duration(minutes: minutes);
//     List<String> parts = d.toString().split(':');
//     return '${parts[0].padLeft(2, '0')} ساعة و ${parts[1].padLeft(2, '0')} دقيقة';
//   }

//   @override
//   getPaymentSum({required String empId}) async {
//     try {
//       var getSum = await Crud.postRequest(
//         MyStrings.apiGetSaleryPayment,
//         {
//           'start_date': dayFormater.format(startDate.value),
//           'end_date': dayFormater.format(endDate.value),
//           'emp_id': empId,
//         },
//         saleryPaymentModelFromJson,
//       );
//       if (getSum.status == 'fail') {
//         isLoading(false);
//         update();
//       } else if (getSum.status == 'suc') {
//         if (getSum.data[0].sumPayment == null) {
//           isLoading(false);
//           paymentVal.value = "0";
//           update();
//         } else {
//           isLoading(false);
//           paymentVal.value = getSum.data[0].sumPayment;
//           update();
//         }
//       }
//     } catch (_) {}
//   }

//   @override
//   getSaleryAbsence({required String empId}) async {
//     try {
//       var getSum = await Crud.postRequest(
//         MyStrings.apiGetSaleryAbsence,
//         {
//           'start_date': dayFormater.format(startDate.value),
//           'end_date': dayFormater.format(endDate.value),
//           'emp_id': empId,
//         },
//         saleryAbsenceModelFromJson,
//       );
//       if (getSum.status == 'fail') {
//         isLoading(false);
//         update();
//       } else if (getSum.status == 'suc') {
//         if (getSum.data[0].sumEmpAbsence == null) {
//           isLoading(false);
//           abcensVal.value = "0";
//           update();
//         } else {
//           isLoading(false);
//           abcensVal.value = getSum.data[0].sumEmpAbsence;
//           update();
//         }
//       }
//     } catch (_) {}
//   }

//   @override
//   getSaleryAttend({required String empId}) async {
//     try {
//       var getSum = await Crud.postRequest(
//         MyStrings.apiGetSaleryAttendDays,
//         {
//           'start_date': dayFormater.format(startDate.value),
//           'end_date': dayFormater.format(endDate.value),
//           'emp_id': empId,
//         },
//         saleryAtendModelFromJson,
//       );
//       if (getSum.status == 'fail') {
//         isLoading(false);
//         update();
//       } else if (getSum.status == 'suc') {
//         if (getSum.data[0].sumIsExit == null) {
//           isLoading(false);
//           attendVal.value = "0";
//           update();
//         } else {
//           isLoading(false);
//           attendVal.value = getSum.data[0].sumIsExit;
//           update();
//         }
//       }
//     } catch (_) {}
//   }

//   @override
//   getSaleryBouns({required String empId}) async {
//     try {
//       var getSum = await Crud.postRequest(
//         MyStrings.apiGetSaleryBouns,
//         {
//           'start_date': dayFormater.format(startDate.value),
//           'end_date': dayFormater.format(endDate.value),
//           'emp_id': empId,
//         },
//         saleryBounsModelFromJson,
//       );
//       if (getSum.status == 'fail') {
//         isLoading(false);
//         update();
//       } else if (getSum.status == 'suc') {
//         if (getSum.data[0].sumBouns == null) {
//           isLoading(false);
//           bounsVal.value = "0";
//           update();
//         } else {
//           isLoading(false);
//           bounsVal.value = getSum.data[0].sumBouns;
//           update();
//         }
//       }
//     } catch (_) {}
//   }

//   @override
//   getSaleryDiscount({required String empId}) async {
//     try {
//       var getSum = await Crud.postRequest(
//         MyStrings.apiGetSaleryExept,
//         {
//           'start_date': dayFormater.format(startDate.value),
//           'end_date': dayFormater.format(endDate.value),
//           'emp_id': empId,
//         },
//         saleryExeptModelFromJson,
//       );
//       if (getSum.status == 'fail') {
//         isLoading(false);
//         update();
//       } else if (getSum.status == 'suc') {
//         if (getSum.data[0].sumExept == null) {
//           isLoading(false);
//           discountVal.value = "0";
//           update();
//         } else {
//           isLoading(false);
//           discountVal.value = getSum.data[0].sumExept;
//           update();
//         }
//       }
//     } catch (_) {}
//   }

//   @override
//   getSaleryHoliday({required String empId}) async {
//     try {
//       var getSum = await Crud.postRequest(
//         MyStrings.apiGetSaleryHoliday,
//         {
//           'start_date': dayFormater.format(startDate.value),
//           'end_date': dayFormater.format(endDate.value),
//           'emp_id': empId,
//         },
//         saleryHolidayModelFromJson,
//       );
//       if (getSum.status == 'fail') {
//         isLoading(false);
//         update();
//       } else if (getSum.status == 'suc') {
//         if (getSum.data[0].sumEmpHoliday == null) {
//           isLoading(false);
//           holidayVal.value = "0";
//           update();
//         } else {
//           isLoading(false);
//           holidayVal.value = getSum.data[0].sumEmpHoliday;
//           update();
//         }
//       }
//     } catch (_) {}
//   }

//   @override
//   getSaleryRest({required String empId}) async {
//     try {
//       var getSum = await Crud.postRequest(
//         MyStrings.apiGetSaleryMinutesRest,
//         {
//           'start_date': dayFormater.format(startDate.value),
//           'end_date': dayFormater.format(endDate.value),
//           'emp_id': empId,
//         },
//         saleryRestModelFromJson,
//       );
//       if (getSum.status == 'fail') {
//         isLoading(false);
//         update();
//       } else if (getSum.status == 'suc') {
//         if (getSum.data[0].sumEmpRest == null) {
//           isLoading(false);
//           restVal.value = "0";
//           update();
//         } else {
//           isLoading(false);
//           restVal.value = getSum.data[0].sumEmpRest;
//           update();
//         }
//       }
//     } catch (_) {}
//   }

//   @override
//   getSaleryMinutes({required String empId}) async {
//     try {
//       var getSum = await Crud.postRequest(
//         MyStrings.apiGetSaleryMinutes,
//         {
//           'start_date': dayFormater.format(startDate.value),
//           'end_date': dayFormater.format(endDate.value),
//           'emp_id': empId,
//         },
//         saleryMinutesModelFromJson,
//       );
//       if (getSum.status == 'fail') {
//         isLoading(false);
//         update();
//       } else if (getSum.status == 'suc') {
//         if (getSum.data[0].sumMinutes == null) {
//           isLoading(false);
//           bounsVal.value = "0";
//           update();
//         } else {
//           isLoading(false);
//           bounsVal.value = getSum.data[0].sumMinutes;
//           update();
//         }
//       }
//     } catch (_) {}
//   }
// }
