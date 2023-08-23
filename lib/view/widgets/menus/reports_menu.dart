import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes.dart';

class ReportsMenu extends StatelessWidget {
  ReportsMenu({
    super.key,
  });
  final List bodyItems = [
    MyStrings.monthReport,
  ];
  final BillInControllerImp billInController = Get.put(BillInControllerImp());

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          MyStrings.reports,
          style: context.textTheme.displayLarge,
        ),
        items: bodyItems
            .map(
              (sup) => DropdownMenuItem<String>(
                value: sup,
                child: Text(sup, style: context.textTheme.displayLarge),
              ),
            )
            .toList(),
        onChanged: (value) async {
          switch (value) {
            case MyStrings.billOutReports:
              Get.offAllNamed(AppRoutes.reportBillOutScreen);
              break;
            case MyStrings.billInReports:
              Get.offAllNamed(AppRoutes.reportBillInScreen);
              break;
            case MyStrings.monthReport:
              Get.offAllNamed(AppRoutes.monthReports);
              break;
            default:
              Get.offAllNamed(AppRoutes.mainScreen);
          }
        },
      ),
    );
  }
}
