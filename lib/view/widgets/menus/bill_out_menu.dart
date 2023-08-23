import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes.dart';

class BillOutMenu extends StatelessWidget {
  BillOutMenu({super.key});

  final List bodyItems = [
    MyStrings.addBillOut,
    MyStrings.backBillOut,
    MyStrings.editBillsOut,
    MyStrings.billOutReports,
  ];
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(MyStrings.billOut, style: context.textTheme.displayLarge),
        items: // mainController.supList
            bodyItems
                .map(
                  (sup) => DropdownMenuItem<String>(
                    value: sup,
                    child: Text(sup, style: context.textTheme.displayLarge),
                  ),
                )
                .toList(),
        onChanged: (value) async {
          switch (value) {
            case MyStrings.addBillOut:
              Get.offAllNamed(AppRoutes.addBillOutScreen);
              break;
            case MyStrings.backBillOut:
              Get.offAllNamed(AppRoutes.addBackBillOutScreen);
              break;
            case MyStrings.billOutReports:
              Get.offAllNamed(AppRoutes.reportBillOutScreen);
              break;
            case MyStrings.editBillsOut:
              Get.offAllNamed(AppRoutes.searchBillOutScreen);
              break;
            default:
              Get.offAllNamed(AppRoutes.mainScreen);
          }
        },
      ),
    );

    // Expanded(
    //   flex: 1,
    //   child: ExpandablePanel(
    //     header: Center(
    //       child: Text(
    //         MyStrings.sale,
    //         style: context.textTheme.titleMedium,
    //       ),
    //     ),
    //     collapsed: const Text(
    //       '',
    //     ),
    //     expanded: Container(
    //       color: AppColorManger.primary,
    //       width: double.infinity,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           TextButton(
    //             onPressed: () {
    //               mainController.selectedBody.value = MyStrings.addSale;
    //             },
    //             child: Text(
    //               MyStrings.addSale,
    //               style: context.textTheme.bodyText1,
    //             ),
    //           ),
    //           const Divider(
    //             color: AppColorManger.white,
    //             thickness: 2,
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               mainController.selectedBody.value = MyStrings.editSale;
    //             },
    //             child: Text(
    //               MyStrings.editSale,
    //               style: context.textTheme.bodyText1,
    //             ),
    //           ),
    //           const Divider(
    //             color: AppColorManger.white,
    //             thickness: 2,
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               mainController.selectedBody.value =
    //                   MyStrings.editSalesReports;
    //             },
    //             child: Text(
    //               MyStrings.editSalesReports,
    //               style: context.textTheme.bodyText1,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
