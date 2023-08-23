import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/emp/attend_controller.dart';
import '../../../controllers/emp/emp_controller.dart';
import '../../../controllers/emp/salery_controller.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/emp/emp_model.dart';
import '../../../routes.dart';
import '../items/table_ciel.dart';

class MyTableEmp extends StatelessWidget {
  MyTableEmp({super.key, @required this.emp, required this.isHeader});
  final Emp? emp;
  final bool isHeader;
  final EmpControllerImp empController = Get.find<EmpControllerImp>();
  final AttendControllerImp attendController = Get.put(AttendControllerImp());
  final SaleryControllerImp saleryController = Get.put(SaleryControllerImp());

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return Center(
        child: Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 1,
              text: MyStrings.theNum,
              style: context.textTheme.bodySmall,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: MyStrings.empName,
              style: context.textTheme.bodySmall,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.jopTitle,
              style: context.textTheme.bodySmall,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.empTel,
              style: context.textTheme.bodySmall,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.empWts,
              style: context.textTheme.bodySmall,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.empNationalId,
              style: context.textTheme.bodySmall,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 1,
              text: MyStrings.empSalery,
              style: context.textTheme.bodySmall,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 1,
              text: MyStrings.edit,
              style: context.textTheme.bodySmall,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 1,
              text: MyStrings.log,
              style: context.textTheme.bodySmall,
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
            text: emp!.empId.toString(),
            style: context.textTheme.bodySmall,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 3,
            text: emp!.empName,
            style: context.textTheme.bodySmall,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: emp!.empJop,
            style: context.textTheme.bodySmall,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: emp!.empTel1,
            style: context.textTheme.bodySmall,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: emp!.empTel2,
            style: context.textTheme.bodySmall,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: emp!.empNatid,
            style: context.textTheme.bodySmall,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                saleryController.selectMonth(
                    forEmp: true, context: context, emp: emp!);
              },
              child: Container(
                margin: EdgeInsets.only(left: AppSizes.h01 / 2),
                padding: EdgeInsets.symmetric(vertical: AppSizes.h02),
                color: AppColorManger.primary,
                child: const Icon(Icons.attach_money),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                empController.nameText.text = emp!.empName;
                empController.tel1Text.text = emp!.empTel1;
                empController.tel2Text.text = emp!.empTel2;
                empController.natIdText.text = emp!.empNatid;
                empController.saleryText.text = emp!.empSal.toString();
                empController.hoursText.text = emp!.empHours.toString();
                empController.addressText.text = emp!.empAddress;
                empController.datebirth.value =
                    empController.formatter.format(emp!.empBirth);
                empController.startWork.value =
                    empController.formatter.format(emp!.empWorkStart);
                emp!.empStopped == 0
                    ? empController.endWork.value = MyStrings.stillInJop
                    : empController.endWork.value =
                        empController.formatter.format(emp!.empWorkEnd);
                Get.offAndToNamed(
                  AppRoutes.editEmpScreen,
                  arguments: [emp],
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: AppSizes.h01 / 2, right: AppSizes.h01 / 2),
                padding: EdgeInsets.symmetric(vertical: AppSizes.h02),
                color: AppColorManger.primary,
                child: const Icon(Icons.edit),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                attendController.selectMonth(
                    forEmp: true, context: context, emp: emp!);
              },
              child: Container(
                margin: EdgeInsets.only(right: AppSizes.h01 / 2),
                padding: EdgeInsets.symmetric(vertical: AppSizes.h02),
                color: AppColorManger.primary,
                child: const Icon(Icons.calendar_month),
              ),
            ),
          ),
        ],
      );
    }
  }
}
