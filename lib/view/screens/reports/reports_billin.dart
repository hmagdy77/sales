import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../core/class/pdf_report_in.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/public/table_widget.dart';

class ReportsBillInScreen extends StatelessWidget {
  ReportsBillInScreen({super.key});
  final BillInControllerImp billInController = Get.put(BillInControllerImp());
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
                  return Column(
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
                                    context: context, end: false, start: true);
                                billInController.billsStockTotal.value = 0;
                                billInController.billsbackTotal.value = 0;
                                billInController.billsStockPayment.value = 0;
                                billInController.billsbackPayment.value = 0;
                              },
                            ),
                          ),
                          Expanded(
                            child: MyButton(
                              text: MyStrings.selectendtDate,
                              onPressed: () {
                                billInController.getDate(
                                    context: context, end: true, start: false);
                                billInController.billsStockTotal.value = 0;
                                billInController.billsbackTotal.value = 0;
                                billInController.billsStockPayment.value = 0;
                                billInController.billsbackPayment.value = 0;
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
                                } else if (billInController.endDate.isEmpty) {
                                  MySnackBar.snack(
                                      MyStrings.mustChoseEndDate, '');
                                } else {
                                  await billInController.getBillsInSum(kind: 0);
                                  await billInController.getBillsInSum(kind: 1);
                                  await billInController.getBillsInPaymentSum(
                                      kind: 0);
                                  await billInController.getBillsInPaymentSum(
                                      kind: 1);
                                  await billInController.getBillsInSum(kind: 4);
                                  await billInController.getBillsInSum(kind: 5);
                                  await billInController.getBillsInPaymentSum(
                                      kind: 4);
                                  await billInController.getBillsInPaymentSum(
                                      kind: 5);
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
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.w1),
                        child: Table(
                          border:
                              TableBorder.all(color: Colors.black, width: 1),
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
                                  text: billInController.billsbackBikesTotal
                                      .toString(),
                                ),
                                TableWidget(
                                  text: billInController.billsbackBikesPayment
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
                            startDate: billInController.startDate.toString(),
                            endDate: billInController.endDate.toString(),
                            kind: MyStrings.billInReports,
                            date:
                                '${MyStrings.printDate} ${billInController.formatter.format(DateTime.now())}',
                            fristRow: [
                              '${billInController.billsStockPayment.value + billInController.billsStockTotal.value}',
                              billInController.billsStockPayment.toString(),
                              billInController.billsStockTotal.toString(),
                              MyStrings.billIn
                            ],
                            secondRow: [
                              '${billInController.billsbackTotal.value + billInController.billsbackPayment.value}',
                              billInController.billsbackPayment.toString(),
                              billInController.billsbackTotal.toString(),
                              MyStrings.backBillIn,
                            ],
                            thirdRow: [
                              '${billInController.billsBikesPayment.value + billInController.billsBikesTotal.value}',
                              billInController.billsBikesPayment.toString(),
                              billInController.billsBikesTotal.toString(),
                              MyStrings.billInBike,
                            ],
                            forthRow: [
                              '${billInController.billsbackBikesTotal.value + billInController.billsbackBikesPayment.value}',
                              billInController.billsbackBikesPayment.toString(),
                              billInController.billsbackBikesTotal.toString(),
                              MyStrings.backBillInBike,
                            ],
                          );
                        },
                      ),
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
