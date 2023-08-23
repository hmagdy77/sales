import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/emp/attend_controller.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/emp/day_model.dart';

class DayWidget extends StatelessWidget {
  DayWidget({super.key, this.day, required this.forEmp});
  final Day? day;
  final bool forEmp;
  final AttendControllerImp attendController = Get.find<AttendControllerImp>();

  @override
  Widget build(BuildContext context) {
    if (forEmp) {
      if (day!.empHoliday == 1) {
        return Container(
          decoration: BoxDecoration(
            color: AppColorManger.rentColor,
            borderRadius: BorderRadius.circular(AppSizes.w02),
          ),
          margin: EdgeInsets.symmetric(horizontal: AppSizes.h01),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${MyStrings.day} : ${DateFormat.d().format(day!.empAttend)}',
                style: context.textTheme.bodyMedium,
              ),
              Text(
                MyStrings.holiday,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        );
      } else if (day!.empAbsence == 1) {
        return Container(
          decoration: BoxDecoration(
            color: AppColorManger.primary,
            borderRadius: BorderRadius.circular(AppSizes.w02),
          ),
          margin: EdgeInsets.symmetric(horizontal: AppSizes.h01),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${MyStrings.day} : ${DateFormat.d().format(day!.empAttend)}',
                style: context.textTheme.bodyMedium,
              ),
              Text(
                MyStrings.absence,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.all(AppSizes.h01),
          decoration: BoxDecoration(
            color:
                day!.isExit == 1 ? AppColorManger.grey : AppColorManger.pinkClr,
            borderRadius: BorderRadius.circular(AppSizes.w02),
          ),
          child: Column(
            children: [
              Text(
                '${MyStrings.day} : ${DateFormat.d().format(day!.empAttend)}',
                style: context.textTheme.bodyMedium,
              ),
              //attendTime
              Text(
                '${MyStrings.attendTime} : ${DateFormat.jm().format(day!.empAttend)}',
                style: context.textTheme.displayMedium,
              ),
              // exitTime
              day!.isExit == 0
                  ? Text(
                      MyStrings.didNotGo,
                      style: context.textTheme.displayMedium,
                    )
                  : Text(
                      '${MyStrings.exitTime} : ${DateFormat.jm().format(day!.empExit)}',
                      style: context.textTheme.displayMedium,
                    ),
              // empTimeWork
              Text(
                '${MyStrings.empTimeWork} : ${attendController.convertMinutesToHoures(minutes: day!.minutes)}',
                style: context.textTheme.displayMedium,
              ),
              // exept &&  rest
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  day!.exept == 0
                      ? Text(
                          '${MyStrings.discount} : ${MyStrings.notFound}',
                          style: context.textTheme.displayMedium,
                        )
                      : Text(
                          '${MyStrings.discount} : ${day!.exept}',
                          style: context.textTheme.displayMedium,
                        ),
                  day!.empRest == 0
                      ? Text(
                          '${MyStrings.rest} : ${MyStrings.notFound}',
                          style: context.textTheme.displayMedium,
                        )
                      : Text(
                          '${MyStrings.rest} : ${day!.empRest}',
                          style: context.textTheme.displayMedium,
                        ),
                ],
              ),
              // payment &&  bouns
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  day!.payment == 0
                      ? Text(
                          '${MyStrings.payment} : ${MyStrings.notFound}',
                          style: context.textTheme.displayMedium,
                        )
                      : Text(
                          '${MyStrings.payment} : ${day!.payment}',
                          style: context.textTheme.displayMedium,
                        ),
                  // 5
                  day!.bouns == 0
                      ? Text(
                          '${MyStrings.bouns} : ${MyStrings.notFound}',
                          style: context.textTheme.displayMedium,
                        )
                      : Text(
                          '${MyStrings.bouns} : ${day!.bouns}',
                          style: context.textTheme.displayMedium,
                        ),
                ],
              ),

              //notes
              day!.empNotes.isEmpty
                  ? Text(
                      '${MyStrings.notes} : ${MyStrings.notFound}',
                      style: context.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      '${MyStrings.notes} : ${day!.empNotes}',
                      style: context.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
        );
      }
    } else {
      if (day!.empHoliday == 1) {
        return Container(
          decoration: BoxDecoration(
            color: AppColorManger.rentColor,
            borderRadius: BorderRadius.circular(AppSizes.w02),
          ),
          padding: EdgeInsets.all(AppSizes.w02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${MyStrings.empNum} : ${day!.empId}'),
              Text('${MyStrings.empName} : ${day!.empName}'),
              Text('${MyStrings.jopTitle} : ${day!.empJop}'),
              const Text(MyStrings.holiday),
            ],
          ),
        );
      } else if (day!.empAbsence == 1) {
        return Container(
          decoration: BoxDecoration(
            color: AppColorManger.primary,
            borderRadius: BorderRadius.circular(AppSizes.w02),
          ),
          padding: EdgeInsets.all(AppSizes.w02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${MyStrings.empNum} : ${day!.empId}'),
              Text('${MyStrings.empName} : ${day!.empName}'),
              Text('${MyStrings.jopTitle} : ${day!.empJop}'),
              const Text(MyStrings.absence),
            ],
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w02, vertical: AppSizes.w02),
          decoration: BoxDecoration(
            color:
                day!.isExit == 1 ? AppColorManger.grey : AppColorManger.pinkClr,
            borderRadius: BorderRadius.circular(AppSizes.w02),
          ),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text('${MyStrings.empNum} : ${day!.empId}')),
                      Expanded(
                          child:
                              Text('${MyStrings.empName} : ${day!.empName}')),
                      Expanded(
                        child: day!.empNotes.isEmpty
                            ? const Text(
                                '${MyStrings.notes} : ${MyStrings.notFound}')
                            : Text('${MyStrings.notes} : ${day!.empNotes}'),
                      ),
                      const Expanded(child: Text(''))
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            '${MyStrings.attendTime} : ${DateFormat.jm().format(day!.empAttend)}'),
                      ),
                      Expanded(
                        child: day!.isExit == 0
                            ? const Text(MyStrings.didNotGo)
                            : Text(
                                '${MyStrings.exitTime} : ${DateFormat.jm().format(day!.empExit)}'),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                                '${MyStrings.time} : ${attendController.convertMinutesToHoures(minutes: day!.minutes)}'),
                            SizedBox(
                              width: AppSizes.w05,
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: Text(''))
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: day!.empRest == 0
                            ? const Text(
                                '${MyStrings.rest} : ${MyStrings.notFound}')
                            : Text(
                                '${MyStrings.rest} :  ${attendController.convertMinutesToHoures(minutes: day!.empRest)}'),
                      ),
                      Expanded(
                        child: day!.exept == 0
                            ? const Text(
                                '${MyStrings.discount} : ${MyStrings.notFound}')
                            : Text('${MyStrings.discount} : ${day!.exept}'),
                      ),
                      Expanded(
                        child: day!.payment == 0
                            ? const Text(
                                '${MyStrings.payment} : ${MyStrings.notFound}')
                            : Text('${MyStrings.payment} : ${day!.payment}'),
                      ),
                      Expanded(
                        child: day!.bouns == 0
                            ? const Text(
                                '${MyStrings.bouns} : ${MyStrings.notFound}')
                            : Text('${MyStrings.bouns} : ${day!.bouns}'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }
    }
  }
}
