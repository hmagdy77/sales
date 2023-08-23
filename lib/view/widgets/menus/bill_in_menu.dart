import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes.dart';

class BillInMenu extends StatelessWidget {
  BillInMenu({
    super.key,
  });
  final List bodyItems = [
    MyStrings.addBillIn,
    MyStrings.backBillIn,
    MyStrings.editBillsIn,
    MyStrings.billInReports,
  ];
  final BillInControllerImp billInController = Get.put(BillInControllerImp());

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          MyStrings.billIn,
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
            case MyStrings.addBillIn:
              Get.offAllNamed(AppRoutes.addBillInScreen);
              break;
            case MyStrings.backBillIn:
              Get.offAllNamed(AppRoutes.addBackBillInScreen);
              break;
            case MyStrings.billInReports:
              Get.offAllNamed(AppRoutes.reportBillInScreen);
              break;
            case MyStrings.editBillsIn:
              Get.offAllNamed(AppRoutes.searchBillInScreen);
              break;
            default:
              Get.offAllNamed(AppRoutes.mainScreen);
          }
        },
      ),
    );
  }
}
