import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/emp/attend_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/emp/day_model.dart';
import '../../../models/emp/emp_model.dart';
import '../../../models/emp/emp_salery.dart';

class EmpDetails extends StatelessWidget {
  EmpDetails(
      {super.key, this.day, required this.forEmp, this.empSalery, this.emp});
  final Day? day;
  final Emp? emp;
  final EmpSalery? empSalery;
  final bool forEmp;
  final AttendControllerImp attendController = Get.find<AttendControllerImp>();
  @override
  Widget build(BuildContext context) {
    if (forEmp) {
      return emp!.empId == 0
          ? Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    Text(
                      ' ${MyStrings.idNumber} : ${empSalery!.empId.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    Text(
                      '${MyStrings.empNumperOfHours} :  ${empSalery!.empHours.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      ' ${MyStrings.empName} : ${empSalery!.empName.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    Text(
                      ' ${MyStrings.empSalery} : ${empSalery!.empSal.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      ' ${MyStrings.jopTitle} : ${empSalery!.empJop.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    Text(
                      ' ',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                Column(
                  children: [
                    Text(
                      ' ${MyStrings.idNumber} : ${emp!.empId.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    Text(
                      '${MyStrings.empNumperOfHours} :  ${emp!.empHours.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      ' ${MyStrings.empName} : ${emp!.empName.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    Text(
                      ' ${MyStrings.empSalery} : ${emp!.empSal.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      ' ${MyStrings.jopTitle} : ${emp!.empJop.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    Text(
                      ' ${MyStrings.dateOfStartWork} : ${attendController.dayFormater.format(emp!.empWorkStart)}',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      ' ${MyStrings.empTel} : ${emp!.empTel1.toString()}',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    emp!.empStopped == 0
                        ? Text(
                            '${MyStrings.dateOfEndtWork} : ${MyStrings.stillInJop}',
                            style: context.textTheme.bodyMedium,
                          )
                        : Text(
                            ' ${MyStrings.dateOfEndtWork} : ${attendController.dayFormater.format(emp!.empWorkEnd)}',
                            style: context.textTheme.bodyMedium,
                          )
                  ],
                ),
                const Spacer(),
              ],
            );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Spacer(),
          Column(
            children: [
              Text(
                ' ${MyStrings.idNumber} : ${day!.empId.toString()}',
                style: context.textTheme.bodyMedium,
              ),
              SizedBox(
                height: AppSizes.h03,
              ),
              day!.empHoliday == 1
                  ? Text(
                      MyStrings.holiday,
                      style: context.textTheme.bodyMedium,
                    )
                  : day!.empAbsence == 1
                      ? Text(
                          MyStrings.absence,
                          style: context.textTheme.bodyMedium,
                        )
                      : Text(
                          ' ${MyStrings.attendTime} : ${DateFormat.jm().format(day!.empAttend).toString()}',
                          style: context.textTheme.bodyMedium,
                        ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                ' ${MyStrings.empName} : ${day!.empName.toString()}',
                style: context.textTheme.bodyMedium,
              ),
              SizedBox(
                height: AppSizes.h03,
              ),
              day!.empHoliday == 1
                  ? Text(
                      ' ',
                      style: context.textTheme.bodyMedium,
                    )
                  : day!.empAbsence == 1
                      ? Text(
                          ' ',
                          style: context.textTheme.bodyMedium,
                        )
                      : day!.isExit == 1
                          ? Text(
                              ' ${MyStrings.exitTime} : ${DateFormat.jm().format(day!.empExit).toString()}',
                              style: context.textTheme.bodyMedium,
                            )
                          : Text(
                              MyStrings.didNotGo,
                              style: context.textTheme.bodyMedium,
                            ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                '${MyStrings.date} : ${DateFormat.yMEd().format(day!.day).toString()}',
                style: context.textTheme.bodyMedium,
              ),
              SizedBox(
                height: AppSizes.h03,
              ),
              day!.isExit == 1
                  ? Text(
                      ' ${MyStrings.empNumperOfHours} : ${attendController.convertMinutesToHoures(minutes: day!.minutes)}',
                      style: context.textTheme.bodyMedium,
                    )
                  : const Text(''),
            ],
          ),
          const Spacer(),
        ],
      );
    }
  }
}
