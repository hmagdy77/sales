import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../controllers/works/work_controller.dart';
import '../../../controllers/works/work_item_controller.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../models/bills/bill_model.dart';
import '../../../models/works/work_model.dart';
import '../../../routes.dart';
import '../../widgets/items/table_ciel.dart';
import '../../widgets/public/colors_details_widget.dart';
import '../../widgets/public/label_text.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';
import '../../widgets/works/work_bill.dart';

class WorkDetailsScreen extends StatelessWidget {
  WorkDetailsScreen({super.key});
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());
  final WorkControllerImp workController = Get.put(WorkControllerImp());
  final BillOutItemControllerImp billOutItemController =
      Get.put(BillOutItemControllerImp());
  final WorkItemControllerImp workItemsController =
      Get.put(WorkItemControllerImp());
  final Work work = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (billOutController.isLoading.value ||
              workController.isLoading.value) {
            return const Center(
              child: MyLottieLoading(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // back button
                        Row(
                          children: [
                            MyButton(
                              text: MyStrings.back,
                              minWidth: AppSizes.w3,
                              onPressed: () {
                                workController.getlastWork();
                                Get.offAllNamed(AppRoutes.searchWorkScreen);
                              },
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Center(
                              child: LabelText(
                                label: work.workClosed == 1
                                    ? MyStrings.doneCloseWorke
                                    : MyStrings.currentWork,
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h04,
                        ),
                        //work id and date and numberOfitems
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  ' ${MyStrings.workeNum} : ${work.workId.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                //for height
                                SizedBox(
                                  height: AppSizes.h04,
                                ),

                                Text(
                                  ' ${MyStrings.cashierName} : ${work.workName}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  ' ${MyStrings.numberOfBills} : ${billOutController.workBillsList.length}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                //for height
                                SizedBox(
                                  height: AppSizes.h04,
                                ),
                                Text(
                                  '${MyStrings.startWorke} :  ${DateFormat.yMMMEd().format(work.workStart)}  ${DateFormat.jm().format(work.workEnd)}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  ' ${MyStrings.safy} : ${work.workTotal}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                //for height
                                SizedBox(
                                  height: AppSizes.h04,
                                ),
                                work.workClosed == 1
                                    ? Text(
                                        '${MyStrings.endWorke} :  ${DateFormat.yMMMEd().format(work.workEnd)}  ${DateFormat.jm().format(work.workEnd)}',
                                        style: context.textTheme.bodyMedium,
                                      )
                                    : Text(
                                        MyStrings.currentWork,
                                        style: context.textTheme.bodyMedium,
                                      ),
                              ],
                            ),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h04,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: MyTextField(
                                controller:
                                    billOutController.billOutSearchController,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label:
                                    '${MyStrings.billNumper}  او  ${MyStrings.agentName}  او  ${MyStrings.agentPhone}  او  ${MyStrings.billTotal}',
                                onChange: (val) {
                                  billOutController.searchWorkBills(val);
                                },
                                onSubmit: (val) {
                                  billOutController.searchWorkBills(val);
                                },
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Text(
                              '${MyStrings.billKind} : ',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                      workController.selectedBillKind.value,
                                      style: context.textTheme.bodySmall),
                                  items: MyStrings.billKindList
                                      .map(
                                          (package) => DropdownMenuItem<String>(
                                                value: package,
                                                child: Text(package,
                                                    style: context
                                                        .textTheme.bodySmall),
                                              ))
                                      .toList(),
                                  onChanged: (value) {
                                    workController.selectedBillKind.value =
                                        value.toString();
                                    switch (value) {
                                      case MyStrings.billOut:
                                        workController.sumLabel.value =
                                            MyStrings.billOut;
                                        workController.getBillsSum(
                                            isBack: 0,
                                            workId: work.workId.toString());
                                        billOutController.searchKind('0');
                                        break;
                                      case MyStrings.backBillOut:
                                        workController.sumLabel.value =
                                            MyStrings.backBillOut;
                                        workController.getBillsSum(
                                            isBack: 1,
                                            workId: work.workId.toString());
                                        billOutController.searchKind('1');
                                        break;
                                      case MyStrings.bikesSales:
                                        workController.sumLabel.value =
                                            MyStrings.bikesSales;
                                        workController.getBillsSum(
                                            isBack: 4,
                                            workId: work.workId.toString());
                                        billOutController.searchKind('4');
                                        break;
                                      case MyStrings.bikesBackSales:
                                        workController.sumLabel.value =
                                            MyStrings.bikesBackSales;
                                        workController.getBillsSum(
                                            isBack: 5,
                                            workId: work.workId.toString());
                                        billOutController.searchKind('5');
                                        break;
                                      case MyStrings.rent:
                                        workController.sumLabel.value =
                                            MyStrings.rent;
                                        workController.getBillsSum(
                                            isBack: 2,
                                            workId: work.workId.toString());
                                        billOutController.searchKind('2');
                                        break;
                                      case MyStrings.fix:
                                        workController.sumLabel.value =
                                            MyStrings.fix;
                                        workController.getBillsSum(
                                            isBack: 3,
                                            workId: work.workId.toString());
                                        billOutController.searchKind('3');
                                        break;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        //bills
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: billOutController.workBillsList.isEmpty
                                    ? Text(
                                        MyStrings.emptyList,
                                        style: context.textTheme.titleSmall,
                                      )
                                    : billOutController
                                            .billsOutSearchList.isEmpty
                                        ? Column(
                                            children: [
                                              Expanded(
                                                child: GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent:
                                                          AppSizes.h25,
                                                    ),
                                                    itemBuilder:
                                                        (context, index) {
                                                      Bill bill = billOutController
                                                              .billsOutSearchList[
                                                          index];
                                                      return GestureDetector(
                                                        onTap: () async {
                                                          await billOutItemController
                                                              .getItemsByIndex(bill
                                                                  .billId
                                                                  .toString());
                                                          Get.toNamed(
                                                            AppRoutes
                                                                .showBillOutScreen,
                                                            arguments: [
                                                              bill,
                                                              work
                                                            ],
                                                          );
                                                        },
                                                        child: WorkBill(
                                                          bill: bill,
                                                        ),
                                                      );
                                                    },
                                                    itemCount: billOutController
                                                        .billsOutSearchList
                                                        .length),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Expanded(
                                                child: GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent:
                                                          AppSizes.h25,
                                                    ),
                                                    itemBuilder:
                                                        (context, index) {
                                                      Bill bill = billOutController
                                                              .billsOutSearchList[
                                                          index];
                                                      return GestureDetector(
                                                        onTap: () async {
                                                          await billOutItemController
                                                              .getItemsByIndex(bill
                                                                  .billId
                                                                  .toString());
                                                          Get.toNamed(
                                                            AppRoutes
                                                                .showBillOutScreen,
                                                            arguments: [
                                                              bill,
                                                              work
                                                            ],
                                                          );
                                                        },
                                                        child: WorkBill(
                                                          bill: bill,
                                                        ),
                                                      );
                                                    },
                                                    itemCount: billOutController
                                                        .billsOutSearchList
                                                        .length),
                                              ),
                                            ],
                                          ),
                              ),
                              SizedBox(
                                width: AppSizes.h1,
                              ),
                              // worksPaymentList
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: AppColorManger.black),
                                  ),
                                  child: workController.worksPaymentList.isEmpty
                                      ? Center(
                                          child: Text(
                                            ' ${MyStrings.workPayment} : ${MyStrings.notFound}',
                                            style: context.textTheme.bodyMedium,
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Text(
                                              MyStrings.workPayment,
                                              style:
                                                  context.textTheme.bodyMedium,
                                            ),
                                            Divider(
                                              thickness: 2,
                                              color: AppColorManger.black,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: workController
                                                    .worksPaymentList.length,
                                                itemBuilder: (context, index) {
                                                  var payment = workController
                                                      .worksPaymentList[index];
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      MyCiel(
                                                        text: payment
                                                            .paymentTotal
                                                            .toString()
                                                            .maxLength(5),
                                                        isBack: false,
                                                        isHeader: false,
                                                        width: 1,
                                                      ),
                                                      MyCiel(
                                                        text: payment.notes,
                                                        isBack: false,
                                                        isHeader: false,
                                                        width: 3,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          workController
                                                              .deleteWorkPayment(
                                                                  paymentId: payment
                                                                      .paymentId
                                                                      .toString()
                                                                      .maxLength(
                                                                          25));
                                                          workController.updateWorkPayment(
                                                              workId: payment
                                                                  .workId,
                                                              total: (-payment
                                                                      .paymentTotal)
                                                                  .toString());
                                                          workController
                                                              .updateTotal(
                                                            total: double.parse(
                                                                payment
                                                                    .paymentTotal
                                                                    .toString()),
                                                            workId: work.workId
                                                                .toString(),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: AppColorManger
                                                              .primary,
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            Divider(
                                              thickness: 2,
                                              color: AppColorManger.black,
                                            ),
                                            Text(
                                              ' ${MyStrings.total} : ${work.workPayment.toString()}',
                                              style:
                                                  context.textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // salesDetailsWork
                            const ColorsDetailsWidget(kind: 1),
                            Expanded(
                              child: MyButton(
                                text: MyStrings.salesDetailsWork,
                                onPressed: () {
                                  workItemsController.getWorkItems(
                                      workId: work.workId.toString());
                                  Get.offAllNamed(
                                    AppRoutes.workItemsScreen,
                                    arguments: [work],
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: MyButton(
                                text: MyStrings.addPayment,
                                onPressed: () {
                                  Get.offAllNamed(
                                    AppRoutes.addWorkPaymentScreen,
                                    arguments: [work],
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ' ${workController.sumLabel}  :  ${workController.sum.value == 0 ? MyStrings.noValue : workController.sum}',
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
