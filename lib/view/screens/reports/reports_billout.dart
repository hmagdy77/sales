// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/works/work_controller.dart';
import '../../../core/class/pdf_report_out.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/public/table_widget.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';

class ReportsBillOutScreen extends StatelessWidget {
  ReportsBillOutScreen({super.key});
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());

  final WorkControllerImp workController = Get.put(WorkControllerImp());

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
                if (billOutController.isLoading.value) {
                  return const MyLottieLoading();
                } else {
                  return Column(
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
                          Expanded(
                            child: MyButton(
                              text: MyStrings.selectStartDate,
                              onPressed: () {
                                billOutController.getDate(
                                    context: context, end: false, start: true);
                                billOutController.billsStockTotal.value = 0;
                                billOutController.billsbackTotal.value = 0;
                                billOutController.billsRentTotal.value = 0;
                                billOutController.billsfixTotal.value = 0;
                                billOutController.bikesTotal.value = 0;
                                billOutController.bikesBackTotal.value = 0;
                                workController.worksSalesSum.value = 0;
                                workController.worksPaymentSum.value = 0;
                              },
                            ),
                          ),
                          Expanded(
                            child: MyButton(
                              text: MyStrings.selectendtDate,
                              onPressed: () {
                                billOutController.getDate(
                                    context: context, end: true, start: false);
                                billOutController.billsStockTotal.value = 0;
                                billOutController.billsbackTotal.value = 0;
                                billOutController.billsRentTotal.value = 0;
                                billOutController.billsfixTotal.value = 0;
                                billOutController.bikesTotal.value = 0;
                                billOutController.bikesBackTotal.value = 0;
                                workController.worksSalesSum.value = 0;
                                workController.worksPaymentSum.value = 0;
                              },
                            ),
                          ),
                          Expanded(
                            child: MyButton(
                              text: MyStrings.getData,
                              onPressed: () async {
                                if (billOutController.startDate.isEmpty) {
                                  MySnackBar.snack(
                                      MyStrings.mustChoseStartDate, '');
                                } else if (billOutController.endDate.isEmpty) {
                                  MySnackBar.snack(
                                      MyStrings.mustChoseEndDate, '');
                                } else if (billOutController
                                        .billsStockTotal.value !=
                                    0) {
                                } else {
                                  billOutController.getBillsOutSum(kind: 0);
                                  billOutController.getBillsOutSum(kind: 1);
                                  billOutController.getBillsOutSum(kind: 2);
                                  billOutController.getBillsOutSum(kind: 3);
                                  billOutController.getBillsOutSum(kind: 4);
                                  billOutController.getBillsOutSum(kind: 5);
                                  workController.sumWorkSales(
                                    start: billOutController.startDate.value
                                        .toString(),
                                    end: billOutController.endDate.value
                                        .toString(),
                                  );

                                  workController.sumWorkPayment(
                                    start: billOutController.startDate.value
                                        .toString(),
                                    end: billOutController.endDate.value
                                        .toString(),
                                  );
                                  // billOutController.safy.value =
                                  //     billOutController.billsStockTotal.value -
                                  //         billOutController.billsbackTotal.value;
                                  // billOutController.stockRentFix.value =
                                  //     billOutController.safy.value +
                                  //         billOutController.billsRentTotal.value +
                                  //         billOutController.billsfixTotal.value;
                                }
                              },
                            ),
                          ),
                          //print Button
                          Expanded(
                            child: MyButton(
                              text: MyStrings.print,
                              onPressed: () {
                                printreportOut(
                                  startDate:
                                      billOutController.startDate.toString(),
                                  endDate: billOutController.endDate.toString(),
                                  kind: MyStrings.billOutReports,
                                  date:
                                      '${MyStrings.printDate} ${billOutController.formatter.format(
                                    DateTime.now(),
                                  )}',
                                  billOut: billOutController.billsStockTotal
                                      .toString(),
                                  backBillOut: billOutController.billsbackTotal
                                      .toString(),
                                  fix: billOutController.billsfixTotal
                                      .toString(),
                                  rent: billOutController.billsRentTotal
                                      .toString(),
                                  bikesSales: billOutController.bikesTotal.value
                                      .toString(),
                                  bikesBackSales: billOutController
                                      .bikesBackTotal.value
                                      .toString(),
                                  workesSafy: workController.worksSalesSum.value
                                      .toString(),
                                  workesPayment: workController
                                      .worksPaymentSum.value
                                      .toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.h05,
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
                        height: AppSizes.h05,
                      ),
                      //frist table
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(horizontal: AppSizes.w1),
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
                                  text: MyStrings.billOut,
                                ),
                                TableWidget(
                                  text: MyStrings.backBillOut,
                                ),
                                // TableWidget(
                                //   text: MyStrings.safy,
                                // ),
                                TableWidget(
                                  text: MyStrings.bikesSales,
                                ),
                                TableWidget(
                                  text: MyStrings.bikesBackSales,
                                ),
                                // TableWidget(
                                //   text: MyStrings.total,
                                // ),
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
                                  text: billOutController.bikesTotal.toString(),
                                ),
                                TableWidget(
                                  text: billOutController.bikesBackTotal
                                      .toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // for Height
                      SizedBox(
                        height: AppSizes.h05,
                      ),

                      //second table
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(horizontal: AppSizes.w1),
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
                                  text: MyStrings.rent,
                                ),
                                TableWidget(
                                  text: MyStrings.fix,
                                ),
                                TableWidget(
                                  text: MyStrings.workesSafy,
                                ),
                                TableWidget(
                                  text: MyStrings.workesPayment,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableWidget(
                                  text: MyStrings.theValue,
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
                                  text: workController.worksSalesSum.value
                                      .toString(),
                                ),
                                TableWidget(
                                  text: workController.worksPaymentSum.value
                                      .toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // for Height
                      SizedBox(
                        height: AppSizes.h1,
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
