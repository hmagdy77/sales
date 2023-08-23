import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/emp/salery_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../models/emp/emp_model.dart';
import '../../../../models/emp/emp_salery.dart';
import '../../../widgets/emp/emp_details.dart';
import '../../../widgets/items/table_ciel.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';

class EmpSaleryScreen extends StatelessWidget {
  EmpSaleryScreen({super.key});
  final SaleryControllerImp saleryController = Get.put(SaleryControllerImp());
  final DateTime date = Get.arguments[0];
  final int days = Get.arguments[1];
  final EmpSalery salery = Get.arguments[2];
  final Emp emp = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (saleryController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            return Column(
              children: [
                UpperWidget(isAdminScreen: false, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      children: [
                        Text(
                            '${MyStrings.empSalery} ${MyStrings.forMonth} ${DateFormat.MMM("ar").format(date).toString()} ${MyStrings.year} ${DateFormat.y("ar").format(date).toString()}'),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        EmpDetails(
                          forEmp: true,
                          emp: emp,
                          empSalery: salery,
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: const [
                            MyCiel(
                                text: MyStrings.numberOfMonthDays,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: MyStrings.numberOfAttendDays,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: MyStrings.numberOfHolidayDays,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: MyStrings.numberOfAbsenceDays,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                          ],
                        ),
                        Row(
                          children: [
                            MyCiel(
                                text: days.toString(),
                                isHeader: false,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: salery.attend.toString(),
                                isHeader: false,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: salery.holiday.toString(),
                                isHeader: false,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: (days - (salery.attend + salery.holiday))
                                    .toString(), //salery.absence.toString(),
                                isHeader: false,
                                width: 2,
                                isBack: false),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: const [
                            MyCiel(
                                text: MyStrings.attendTimeTotal,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: MyStrings.restTotal,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: MyStrings.bounsTotal,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: MyStrings.paymentTotal,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: MyStrings.discountTotal,
                                isHeader: true,
                                width: 2,
                                isBack: false),
                          ],
                        ),
                        Row(
                          children: [
                            MyCiel(
                                text: saleryController.convertMinutesToHoures(
                                    minutes: salery.minutes),
                                isHeader: false,
                                width: 2,
                                isBack: false),
                            MyCiel(
                              text: saleryController.convertMinutesToHoures(
                                  minutes: salery.minutesRest),
                              isHeader: false,
                              width: 2,
                              isBack: false,
                            ),
                            MyCiel(
                                text: salery.bouns.toString(),
                                isHeader: false,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: salery.payment.toString(),
                                isHeader: false,
                                width: 2,
                                isBack: false),
                            MyCiel(
                                text: salery.exept.toString(),
                                isHeader: false,
                                width: 2,
                                isBack: false),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Text(
                            '${MyStrings.empFinalSalery} : ${saleryController.calucalateSalery(empSalery: salery)}'),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
