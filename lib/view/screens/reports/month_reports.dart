import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../core/class/pdf_report_in.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/public/table_widget.dart';

class MonthScreen extends StatelessWidget {
  MonthScreen({super.key});
  final BillInControllerImp billInController = Get.put(BillInControllerImp());
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(
            isAdminScreen: true,
            onPressed: () {},
          ),
          MyContainer(
            content: Obx(
              () {
                if (billInController.isLoading.value) {
                  return const MyLottieLoading();
                } else {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              MyStrings.billInReports,
                              style: context.textTheme.titleSmall,
                            ),
                            //for height
                            SizedBox(
                              height: AppSizes.h02,
                            ),
                            //buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: MyButton(
                                    text: MyStrings.selectStartDate,
                                    onPressed: () {
                                      billInController.getDate(
                                          context: context,
                                          end: false,
                                          start: true);
                                      billInController.billsStockTotal.value =
                                          0;
                                      billInController.billsbackTotal.value = 0;
                                      billInController.billsStockPayment.value =
                                          0;
                                      billInController.billsbackPayment.value =
                                          0;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: MyButton(
                                    text: MyStrings.selectendtDate,
                                    onPressed: () {
                                      billInController.getDate(
                                          context: context,
                                          end: true,
                                          start: false);
                                      billInController.billsStockTotal.value =
                                          0;
                                      billInController.billsbackTotal.value = 0;
                                      billInController.billsStockPayment.value =
                                          0;
                                      billInController.billsbackPayment.value =
                                          0;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: MyButton(
                                    text: MyStrings.getData,
                                    onPressed: () async {
                                      if (billInController.startDate.isEmpty) {
                                        MySnackBar.snack(
                                            MyStrings.mustChoseStartDate, '');
                                      } else if (billInController
                                          .endDate.isEmpty) {
                                        MySnackBar.snack(
                                            MyStrings.mustChoseEndDate, '');
                                      } else {
                                        await billInController.getBillsInSum(
                                            kind: 0);
                                        await billInController.getBillsInSum(
                                            kind: 1);
                                        await billInController
                                            .getBillsInPaymentSum(kind: 0);
                                        await billInController
                                            .getBillsInPaymentSum(kind: 1);
                                        await billInController.getBillsInSum(
                                            kind: 4);
                                        await billInController.getBillsInSum(
                                            kind: 5);
                                        await billInController
                                            .getBillsInPaymentSum(kind: 4);
                                        await billInController
                                            .getBillsInPaymentSum(kind: 5);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            //for height
                            SizedBox(
                              height: AppSizes.h02,
                            ),
                            //dates
                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                  '${MyStrings.startDate}  :  ${billInController.startDate.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                Text(
                                  '${MyStrings.endtDate}  :  ${billInController.endDate.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                const Spacer(),
                              ],
                            ),
                            //for height
                            SizedBox(
                              height: AppSizes.h05,
                            ),
                            //table
                            Container(
                              color: Colors.white,
                              padding:
                                  EdgeInsets.symmetric(horizontal: AppSizes.w1),
                              child: Table(
                                border: TableBorder.all(
                                    color: Colors.black, width: 1),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 3),
                                        shape: BoxShape.rectangle),
                                    children: const [
                                      TableWidget(
                                        text: MyStrings.reportKind,
                                      ),
                                      TableWidget(
                                        text: MyStrings.theValue,
                                      ),
                                      TableWidget(
                                        text: MyStrings.billPayment,
                                      ),
                                      TableWidget(
                                        text: MyStrings.total,
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      const TableWidget(
                                        text: MyStrings.billIn,
                                      ),
                                      TableWidget(
                                        text: billInController.billsStockTotal
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text: billInController.billsStockPayment
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text:
                                            '${billInController.billsStockPayment.value + billInController.billsStockTotal.value}',
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      const TableWidget(
                                        text: MyStrings.backBillIn,
                                      ),
                                      TableWidget(
                                        text: billInController.billsbackTotal
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text: billInController.billsbackPayment
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text:
                                            '${billInController.billsbackTotal.value + billInController.billsbackPayment.value}',
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      const TableWidget(
                                        text: MyStrings.billInBike,
                                      ),
                                      TableWidget(
                                        text: billInController.billsBikesTotal
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text: billInController.billsBikesPayment
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text:
                                            '${billInController.billsBikesPayment.value + billInController.billsBikesTotal.value}',
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      const TableWidget(
                                        text: MyStrings.backBillInBike,
                                      ),
                                      TableWidget(
                                        text: billInController
                                            .billsbackBikesTotal
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text: billInController
                                            .billsbackBikesPayment
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text:
                                            '${billInController.billsbackBikesTotal.value + billInController.billsbackBikesPayment.value}',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // for Height
                            SizedBox(
                              height: AppSizes.h02,
                            ),
                            //print Button
                            MyButton(
                              text: MyStrings.print,
                              onPressed: () {
                                printreportIn(
                                  startDate:
                                      billInController.startDate.toString(),
                                  endDate: billInController.endDate.toString(),
                                  kind: MyStrings.billInReports,
                                  date:
                                      '${MyStrings.printDate} ${billInController.formatter.format(DateTime.now())}',
                                  fristRow: [
                                    '${billInController.billsStockPayment.value + billInController.billsStockTotal.value}',
                                    billInController.billsStockPayment
                                        .toString(),
                                    billInController.billsStockTotal.toString(),
                                    MyStrings.billIn
                                  ],
                                  secondRow: [
                                    '${billInController.billsbackTotal.value + billInController.billsbackPayment.value}',
                                    billInController.billsbackPayment
                                        .toString(),
                                    billInController.billsbackTotal.toString(),
                                    MyStrings.backBillIn,
                                  ],
                                  thirdRow: [
                                    '${billInController.billsBikesPayment.value + billInController.billsBikesTotal.value}',
                                    billInController.billsBikesPayment
                                        .toString(),
                                    billInController.billsBikesTotal.toString(),
                                    MyStrings.billInBike,
                                  ],
                                  forthRow: [
                                    '${billInController.billsbackBikesTotal.value + billInController.billsbackBikesPayment.value}',
                                    billInController.billsbackBikesPayment
                                        .toString(),
                                    billInController.billsbackBikesTotal
                                        .toString(),
                                    MyStrings.backBillInBike,
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              MyStrings.billOutReports,
                              style: context.textTheme.titleSmall,
                            ),
                            SizedBox(
                              height: AppSizes.h05,
                            ),
                            //buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MyButton(
                                  text: MyStrings.selectStartDate,
                                  onPressed: () {
                                    billOutController.getDate(
                                        context: context,
                                        end: false,
                                        start: true);
                                    billOutController.billsStockTotal.value = 0;
                                    billOutController.billsbackTotal.value = 0;
                                    billOutController.billsRentTotal.value = 0;
                                    billOutController.billsfixTotal.value = 0;
                                  },
                                ),
                                MyButton(
                                  text: MyStrings.selectendtDate,
                                  onPressed: () {
                                    billOutController.getDate(
                                        context: context,
                                        end: true,
                                        start: false);
                                    billOutController.billsStockTotal.value = 0;
                                    billOutController.billsbackTotal.value = 0;
                                    billOutController.billsRentTotal.value = 0;
                                    billOutController.billsfixTotal.value = 0;
                                  },
                                ),
                                MyButton(
                                  text: MyStrings.getData,
                                  onPressed: () async {
                                    if (billOutController.startDate.isEmpty) {
                                      MySnackBar.snack(
                                          MyStrings.mustChoseStartDate, '');
                                    } else if (billOutController
                                        .endDate.isEmpty) {
                                      MySnackBar.snack(
                                          MyStrings.mustChoseEndDate, '');
                                    } else if (billOutController
                                            .billsStockTotal.value !=
                                        0) {
                                    } else {
                                      await billOutController.getBillsOutSum(
                                          kind: 0);
                                      await billOutController.getBillsOutSum(
                                          kind: 1);
                                      await billOutController.getBillsOutSum(
                                          kind: 2);
                                      await billOutController.getBillsOutSum(
                                          kind: 3);
                                      billOutController.safy.value =
                                          billOutController
                                                  .billsStockTotal.value -
                                              billOutController
                                                  .billsbackTotal.value;

                                      billOutController.stockRentFix.value =
                                          billOutController.safy.value +
                                              billOutController
                                                  .billsRentTotal.value +
                                              billOutController
                                                  .billsfixTotal.value;
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.h02,
                            ),
                            //dates
                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                  '${MyStrings.startDate}  :  ${billOutController.startDate.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                Text(
                                  '${MyStrings.endtDate}  :  ${billOutController.endDate.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                const Spacer(),
                              ],
                            ),
                            //for height
                            SizedBox(
                              height: AppSizes.h02,
                            ),
                            //table
                            Container(
                              color: Colors.white,
                              margin:
                                  EdgeInsets.symmetric(horizontal: AppSizes.w1),
                              child: Table(
                                border: TableBorder.all(
                                    color: Colors.black, width: 1),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 3),
                                        shape: BoxShape.rectangle),
                                    children: const [
                                      TableWidget(
                                        text: MyStrings.reportKind,
                                      ),
                                      TableWidget(
                                        text: MyStrings.billOut,
                                      ),
                                      TableWidget(
                                        text: MyStrings.backBillOut,
                                      ),
                                      TableWidget(
                                        text: MyStrings.safy,
                                      ),
                                      TableWidget(
                                        text: MyStrings.rent,
                                      ),
                                      TableWidget(
                                        text: MyStrings.fix,
                                      ),
                                      TableWidget(
                                        text: MyStrings.total,
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      const TableWidget(
                                        text: MyStrings.theValue,
                                      ),
                                      TableWidget(
                                        text: billOutController.billsStockTotal
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text: billOutController.billsbackTotal
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text: billOutController.safy.toString(),
                                      ),
                                      TableWidget(
                                        text: billOutController.billsRentTotal
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text: billOutController.billsfixTotal
                                            .toString(),
                                      ),
                                      TableWidget(
                                        text: billOutController
                                            .stockRentFix.value
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // // for Height
                            // SizedBox(
                            //   height: AppSizes.h1,
                            // ),
                            // //print Button
                            // MyButton(
                            //   text: MyStrings.print,
                            //   onPressed: () {
                            //     printreportOut(
                            //       startDate:
                            //           billOutController.startDate.toString(),
                            //       endDate: billOutController.endDate.toString(),
                            //       kind: MyStrings.billOutReports,
                            //       date:
                            //           '${MyStrings.printDate} ${billOutController.formatter.format(
                            //         DateTime.now(),
                            //       )}',
                            //       billOut: billOutController.billsStockTotal
                            //           .toString(),
                            //       backBillOut: billOutController.billsbackTotal
                            //           .toString(),
                            //       fix: billOutController.billsfixTotal
                            //           .toString(),
                            //       rent: billOutController.billsRentTotal
                            //           .toString(),
                            //       safy: billOutController.safy.toString(),
                            //       total: billOutController.stockRentFix.value
                            //           .toString(),
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
