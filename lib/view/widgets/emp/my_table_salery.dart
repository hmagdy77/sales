import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/emp/salery_controller.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/emp/emp_salery.dart';
import '../../../routes.dart';
import '../items/table_ciel.dart';

class MyTableSalery extends StatelessWidget {
  MyTableSalery({
    super.key,
    @required this.salery,
    required this.isHeader,
    this.pickedDate,
    this.days,
  });
  final EmpSalery? salery;
  final bool isHeader;
  final SaleryControllerImp saleryController = Get.put(SaleryControllerImp());
  DateTime? pickedDate;
  int? days;

  @override
  Widget build(BuildContext context) {
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
              width: 3,
              text: MyStrings.empName,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.jopTitle,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.empSalery,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.attend,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.absence,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.holiday,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.safy,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.theDetails,
            ),
          ],
        ),
      );
    } else {
      return Row(
        children: [
          MyCiel(
              isBack: false,
              isHeader: false,
              width: 1,
              text: salery!.empId.toString()),
          MyCiel(
              isBack: false, isHeader: false, width: 3, text: salery!.empName),
          MyCiel(
              isBack: false, isHeader: false, width: 2, text: salery!.empJop),
          MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: salery!.empSal.toString()),
          MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: salery!.attend.toString()),
          MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: salery!.absence.toString()),
          MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: salery!.holiday.toString()),
          MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: saleryController
                  .calucalateSalery(empSalery: salery!)
                  .toString()),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () async {
                await saleryController.saleryForEmp(
                  empId: salery!.empId.toString(),
                  date: pickedDate!,
                );
                Get.toNamed(
                  AppRoutes.empSaleryScreen,
                  arguments: [
                    pickedDate,
                    days,
                    saleryController.empSaleryList.first,
                    saleryController.emptyEmp,
                  ],
                );
                // saleryController.selectMonth(
                // forEmp: true,
                // context: context,
                // empId: salery!.empId.toString());
              },
              child: Container(
                margin: EdgeInsets.only(left: AppSizes.h02 / 2),
                padding: EdgeInsets.symmetric(vertical: AppSizes.h02),
                color: AppColorManger.primary,
                child: const Icon(Icons.attach_money),
              ),
            ),
          ),
        ],
      );
    }
  }
}
