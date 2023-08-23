import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/emp/attend_controller.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../models/emp/day_model.dart';
import '../../../routes.dart';
import '../items/table_ciel.dart';
import '../public/my_button.dart';

class MyTableAttend extends StatelessWidget {
  MyTableAttend({
    super.key,
    this.day,
    this.empId,
    required this.isHeader,
    required this.isAbsence,
  });

  final Day? day;
  final String? empId;
  final bool isHeader;
  final bool isAbsence;

  final AttendControllerImp attendController = Get.put(AttendControllerImp());

  @override
  Widget build(BuildContext context) {
    if (isAbsence) {
      if (isHeader) {
        return Center(
          child: Row(
            children: const [
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 1,
                text: MyStrings.theNum,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 2,
                text: MyStrings.empName,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 1,
                text: MyStrings.attend,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 1,
                text: MyStrings.holiday,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 1,
                text: MyStrings.other,
              ),
            ],
          ),
        );
      } else {
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  MyCiel(
                    isBack: false,
                    isHeader: false,
                    width: 1,
                    text: day!.empId.toString(),
                  ),
                  MyCiel(
                      isBack: false,
                      isHeader: false,
                      width: 2,
                      text: day!.empName.maxLength(15)),
                ],
              ),
            ),
            // attend
            Expanded(
              flex: 1,
              child: MyButton(
                onPressed: () {
                  attendController.attend(day: day!, holiday: '0');
                },
                text: MyStrings.attend,
                color: AppColorManger.grey,
              ),
            ),
            // holiday
            Expanded(
              flex: 1,
              child: MyButton(
                onPressed: () {
                  attendController.attend(day: day!, holiday: '1');
                },
                text: MyStrings.holiday,
                color: AppColorManger.rentColor,
              ),
            ),

            Expanded(
              flex: 1,
              child: MyButton(
                onPressed: () {
                  attendController.bounsText.text = day!.bouns.toString();
                  attendController.paymentText.text = day!.payment.toString();
                  attendController.discountText.text = day!.exept.toString();
                  attendController.restText.text = day!.empRest.toString();
                  attendController.notesText.text = day!.empNotes.toString();
                  Get.toNamed(AppRoutes.toDayScreen, arguments: [
                    day!,
                  ]);
                },
                text: MyStrings.other,
                child: const Icon(
                  Icons.person,
                  color: AppColorManger.white,
                ),
              ),
            )
          ],
        );
      }
    } else {
      if (isHeader) {
        return Center(
          child: Row(
            children: const [
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 1,
                text: MyStrings.theNum,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 2,
                text: MyStrings.empName,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 1,
                text: MyStrings.attend,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 1,
                text: MyStrings.exit,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 1,
                text: MyStrings.other,
              ),
            ],
          ),
        );
      } else {
        if (day!.empHoliday == 1) {
          return Row(
            children: [
              MyCiel(
                isBack: false,
                isHeader: false,
                width: 1,
                text: day!.empId.toString(),
              ),
              MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 2,
                  text: day!.empName.toString().maxLength(15)),
              const MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 2,
                  text: MyStrings.holiday),
              Expanded(
                flex: 1,
                child: MyButton(
                  onPressed: () {
                    attendController.bounsText.text = day!.bouns.toString();
                    attendController.paymentText.text = day!.payment.toString();
                    attendController.discountText.text = day!.exept.toString();
                    attendController.restText.text = day!.empRest.toString();
                    attendController.notesText.text = day!.empNotes.toString();
                    Get.toNamed(AppRoutes.toDayScreen, arguments: [day!]);
                  },
                  text: MyStrings.other,
                  child: const Icon(
                    Icons.person,
                    color: AppColorManger.white,
                  ),
                ),
              )
            ],
          );
        } else if (day!.empAbsence == 1) {
          return Row(
            children: [
              MyCiel(
                isBack: false,
                isHeader: false,
                width: 1,
                text: day!.empId.toString(),
              ),
              MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 2,
                  text: day!.empName.toString().maxLength(15)),
              const MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 2,
                  text: MyStrings.absence),
              Expanded(
                flex: 1,
                child: MyButton(
                  onPressed: () {
                    attendController.bounsText.text = day!.bouns.toString();
                    attendController.paymentText.text = day!.payment.toString();
                    attendController.discountText.text = day!.exept.toString();
                    attendController.restText.text = day!.empRest.toString();
                    attendController.notesText.text = day!.empNotes.toString();
                    Get.toNamed(AppRoutes.toDayScreen, arguments: [day!]);
                  },
                  text: MyStrings.other,
                  child: const Icon(
                    Icons.person,
                    color: AppColorManger.white,
                  ),
                ),
              )
            ],
          );
        } else {
          return Row(
            children: [
              MyCiel(
                isBack: false,
                isHeader: false,
                width: 1,
                text: day!.empId.toString(),
              ),
              MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 2,
                  text: day!.empName.toString().maxLength(15)),
              MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 1,
                  text: DateFormat.jm().format(day!.empAttend).toString()),
              Expanded(
                flex: 1,
                child: day!.isExit == 1
                    ? MyCiel(
                        isBack: false,
                        isHeader: false,
                        width: 1,
                        text: DateFormat.jm().format(day!.empExit).toString())
                    : Expanded(
                        flex: 1,
                        child: MyButton(
                          onPressed: () {
                            DateTime dt2 = attendController.exitFormatter
                                .parse("${day!.empAttend}");
                            DateTime dt1 = attendController.exitFormatter
                                .parse("${DateTime.now()}");
                            Duration diff = dt1.difference(dt2);
                            attendController.exit(
                                dayId: day!.dayId.toString(),
                                minutes: diff.inMinutes.toString(),
                                exitTime: DateTime.now().toString(),
                                empId: empId!);
                          },
                          text: MyStrings.exit,
                          color: Colors.black,
                        ),
                      ),
              ),
              Expanded(
                flex: 1,
                child: MyButton(
                  onPressed: () {
                    attendController.bounsText.text = day!.bouns.toString();
                    attendController.paymentText.text = day!.payment.toString();
                    attendController.discountText.text = day!.exept.toString();
                    attendController.restText.text = day!.empRest.toString();
                    attendController.notesText.text = day!.empNotes.toString();
                    Get.toNamed(AppRoutes.toDayScreen,
                        arguments: [day!, empId]);
                  },
                  text: MyStrings.other,
                  child: const Icon(
                    Icons.person,
                    color: AppColorManger.white,
                  ),
                ),
              )
            ],
          );
        }
      }
    }
  }
}
