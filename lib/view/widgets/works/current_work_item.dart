import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/works/work_controller.dart';
import '../../../controllers/works/work_item_controller.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/service/services.dart';
import '../../../models/works/work_model.dart';
import '../../../routes.dart';
import '../login/snackbar.dart';
import '../public/my_button.dart';

class CurentWorkItem extends StatelessWidget {
  CurentWorkItem({super.key, required this.work});
  final Work work;
  final WorkControllerImp workController = Get.find<WorkControllerImp>();
  final WorkItemControllerImp workItemsController =
      Get.put(WorkItemControllerImp());
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());
  final BillOutCartControllerImp cartController =
      Get.put(BillOutCartControllerImp());
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.h02),
      height: AppSizes.w25,
      decoration: BoxDecoration(
        color: AppColorManger.greyLight,
        borderRadius: BorderRadius.circular(
          AppSizes.w02,
        ),
        border: Border.all(
          width: 2,
          color: AppColorManger.black,
        ),
      ),
      child: work.workClosed == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //currentWorke && cashierName
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('${MyStrings.currentWork} : ${work.workId}'),
                    Text('${MyStrings.cashierName} : ${work.workName}'),
                  ],
                ),

                //startWorke && salesWorke
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${MyStrings.startWorke} : ${DateFormat.yMEd().format(work.workStart)} ${DateFormat.jm().format(work.workStart)}'),
                    myService.sharedPreferences.getInt(MyStrings.adminKey) == 1
                        ? Text('${MyStrings.salesWork} : ${work.workTotal}')
                        : const Text('')
                  ],
                ),

                //closeWorke MyButton
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyButton(
                      text: MyStrings.closeWork,
                      onPressed: () {
                        workController.closeWork(workId: work.workId);
                      },
                    ),
                    myService.sharedPreferences.getInt(MyStrings.adminKey) == 1
                        ? MyButton(
                            text: MyStrings.workDetails,
                            onPressed: () async {
                              await workController.getWorkPayment(
                                  workId: work.workId.toString());
                              await billOutController
                                  .getItemsByIndex(work.workId.toString());
                              await cartController.addAllBillsToCarts(
                                  billOutController.workBillsList);
                              Get.toNamed(AppRoutes.workDetailsScreen,
                                  arguments: [work]);
                            },
                          )
                        : MyButton(
                            text: MyStrings.addPayment,
                            onPressed: () {
                              Get.offAllNamed(
                                AppRoutes.addWorkPaymentScreen,
                                arguments: [work],
                              );
                            },
                          ),
                  ],
                ),
              ],
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.w03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(MyStrings.noCurrentWork),
                  //for height
                  SizedBox(
                    height: AppSizes.h01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => SizedBox(
                          width: AppSizes.w5,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(workController.selectedJop.value,
                                  style: context.textTheme.bodySmall),
                              items: workController.casheirslist
                                  .map((emp) => DropdownMenuItem<String>(
                                        value: emp.empName,
                                        child: Text(emp.empName,
                                            style: context.textTheme.bodySmall),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                workController.selectedJop.value = value!;
                              },
                            ),
                          ),
                        ),
                      ), //for width
                      SizedBox(
                        width: AppSizes.w2,
                      ),
                      MyButton(
                        text: MyStrings.openWork,
                        onPressed: () {
                          if (workController.selectedJop.value.isEmpty) {
                            MySnackBar.snack(MyStrings.choseaCshierName, '');
                          } else {
                            workController.addWork(
                                workName: workController.selectedJop.value);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
