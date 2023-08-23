import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../core/class/pdf_bill_out.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../models/bills/bill_model.dart';
import '../../../models/works/work_model.dart';
import '../../../routes.dart';
import '../../widgets/bills_out/price_container.dart';
import '../../widgets/items/my_table_item.dart';
import '../../widgets/public/label_text.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';

class ShowBillOutScreen extends StatelessWidget {
  ShowBillOutScreen({super.key});
  //billsOut
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());
  final BillOutItemControllerImp billOutItemController =
      Get.put(BillOutItemControllerImp());
  final BillOutCartControllerImp cartController =
      Get.put(BillOutCartControllerImp());
//items

  final Bill bill = Get.arguments[0];
  final Work work = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (billOutItemController.isLoading.value ||
              billOutController.isLoading.value) {
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
                              onPressed: () async {
                                await billOutController
                                    .getItemsByIndex(work.workId.toString());
                                Get.toNamed(AppRoutes.workDetailsScreen,
                                    arguments: [work]);
                              },
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Center(
                              child: LabelText(
                                label: bill.isBack == 1
                                    ? MyStrings.backSalesWork
                                    : MyStrings.salesWork,
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
                        //bill id and date and numberOfitems
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  ' ${MyStrings.billNumper} : ${bill.billId.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                SizedBox(
                                  height: AppSizes.h04,
                                ),
                                Text(
                                  ' ${MyStrings.numberOfitems} : ${bill.billItems.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${MyStrings.billDate} : ${DateFormat.yMEd().format(bill.billTimestamp)}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                SizedBox(
                                  height: AppSizes.h04,
                                ),
                                Text(
                                  '${MyStrings.agentName} : ${bill.agentName}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${MyStrings.billTime} : ${DateFormat.jm().format(bill.billTimestamp)}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                SizedBox(
                                  height: AppSizes.h04,
                                ),
                                Text(
                                  '${MyStrings.agentPhone} :  ${bill.agentPhone}',
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
                        // prices Taple
                        Row(
                          children: [
                            const Spacer(),
                            Column(
                              children: [
                                // bill total && discount  && totalAfterDiscount
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // bill total
                                    Row(
                                      children: [
                                        const PriceContainer(
                                          isConst: true,
                                          text: MyStrings.billTotal,
                                        ), // totalController
                                        PriceContainer(
                                            isConst: false,
                                            text: bill.billTotal
                                                .toString()
                                                .maxLength(12)),
                                      ],
                                    ),
                                    // for width
                                    SizedBox(
                                      width: AppSizes.w01,
                                    ),
                                    //  discount
                                    Row(
                                      children: [
                                        const PriceContainer(
                                          isConst: true,
                                          text: MyStrings.discount,
                                        ),
                                        //  discountController
                                        PriceContainer(
                                          isConst: false,
                                          text: bill.billDiscount.toString(),
                                        ),
                                      ],
                                    ),
                                    // for width
                                    SizedBox(
                                      width: AppSizes.w01,
                                    ),
                                    // totalAfterDiscount
                                    Row(
                                      children: [
                                        const PriceContainer(
                                          isConst: true,
                                          text: MyStrings.totalAfterDiscount,
                                        ),
                                        PriceContainer(
                                            isConst: false,
                                            text: bill.billAfterAiscount
                                                .toStringAsFixed(2)
                                                .maxLength(12)),
                                      ],
                                    ),
                                    // for width
                                    SizedBox(
                                      width: AppSizes.w01,
                                    ),
                                    // paidController
                                    Row(
                                      children: [
                                        const PriceContainer(
                                          isConst: true,
                                          text: MyStrings.paid,
                                        ),

                                        PriceContainer(
                                          isConst: false,
                                          text: bill.billPaid.toString(),
                                        ),
                                        //   .
                                      ],
                                    ),
                                  ],
                                ),
                                // for height
                                SizedBox(
                                  height: AppSizes.w01,
                                ),
                                // paid && unPaid && notes
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // unPaid
                                    Row(
                                      children: [
                                        const PriceContainer(
                                          isConst: true,
                                          text: MyStrings.unPaid,
                                        ),
                                        // unPaid
                                        PriceContainer(
                                            isConst: false,
                                            text: bill.billUnpaid
                                                .toStringAsFixed(2)
                                                .maxLength(12)),

                                        // for width
                                      ],
                                    ),
                                    // for width
                                    SizedBox(
                                      width: AppSizes.w01,
                                    ),
                                    // notes
                                    Row(
                                      children: [
                                        const PriceContainer(
                                          isConst: true,
                                          text: MyStrings.notes,
                                        ),
                                        // unPaid
                                        PriceContainer(
                                          isConst: false,
                                          text: bill.billNotes.maxLength(110),
                                          width: AppSizes.w5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //for height
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h04,
                        ),
                        //cart items
                        MyTableItem(isHeader: true, isStock: false, bill: bill),
                        Expanded(
                          flex: 3,
                          child: billOutItemController.billsOutItemsList.isEmpty
                              ? Text(
                                  MyStrings.emptyList,
                                  style: context.textTheme.titleSmall,
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: AppSizes.h02),
                                            child: MyTableItem(
                                                item: billOutItemController
                                                    .billsOutItemsList[index],
                                                isHeader: false,
                                                isStock: false,
                                                bill: bill),
                                          );
                                        },
                                        itemCount: billOutItemController
                                            .billsOutItemsList.length,
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: GridView.builder(
                                    //     gridDelegate:
                                    //         SliverGridDelegateWithMaxCrossAxisExtent(
                                    //       maxCrossAxisExtent: AppSizes.h25,
                                    //     ),
                                    //     itemBuilder: (context, index) {
                                    //       return Padding(
                                    //         padding: EdgeInsets.only(
                                    //             bottom: AppSizes.h02),
                                    //         child: BillItem(
                                    //             item: billOutItemController
                                    //                 .billsOutItemsList[index],
                                    //             isBack: bill.isBack),
                                    //       );
                                    //     },
                                    //     itemCount: billOutItemController
                                    //         .billsOutItemsList.length,
                                    //   ),
                                    // ),
                                  ],
                                ),
                        ),
                        // print buttons
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //print button
                              MyButton(
                                text: MyStrings.print,
                                minWidth: AppSizes.w3,
                                onPressed: () {
                                  printFunction();
                                },
                              ),
                            ],
                          ),
                        )
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

  void printFunction() {
    cartController.items.clear();
    if (bill.isBack == 4 || bill.isBack == 5) {
      List items = billOutItemController.billsOutItemsList;
      for (int i = 0; i < items.length; i++) {
        cartController.items.add(
          [
            items[i].itemName,
            items[i].itemNum,
            items[i].bikeKind,
            items[i].bikeModel,
            items[i].bikeColor,
            items[i].bikeCondition,
            items[i].itemPriceOut.toString(),
          ],
        );
      }
      printBillOut(
        isBack: bill.isBack,
        casherName: work.workName,
        workNum: work.workId.toString(),
        agentName: billOutController.agentNameController.text,
        agentPhone: billOutController.agentPhoneController.text,
        billDate: DateFormat.yMEd().format(DateTime.now()),
        billTime: DateFormat.jm().format(DateTime.now()),
        billLenth: cartController.myCarts.length.toString(),
        billNumber: bill.billId.toString(),
        items: cartController.items,
        billTotal:
            bill.billTotal == 0 ? 0 : double.parse(bill.billTotal.toString()),
        billDiscount: bill.billDiscount == 0
            ? 0
            : double.parse(bill.billDiscount.toString()),
        billPaid:
            bill.billPaid == 0 ? 0 : double.parse(bill.billPaid.toString()),
      );
    } else {
      List items = billOutItemController.billsOutItemsList;
      for (int i = 0; i < items.length; i++) {
        cartController.items.add(
          [
            (items[i].itemCount * items[i].itemPriceOut).toString(),
            items[i].itemCount.toString(),
            items[i].itemPriceOut.toString(),
            items[i].itemName,
          ],
        );
      }
      printBillOut(
        isBack: bill.isBack,
        casherName: bill.workName,
        workNum: bill.workNum,
        agentName: bill.agentName,
        agentPhone: bill.agentPhone,
        billDate: DateFormat.yMEd().format(bill.billTimestamp),
        billTime: DateFormat.jm().format(bill.billTimestamp),
        billLenth: bill.billItems.toString(),
        billNumber: bill.billId.toString(),
        items: cartController.items,
        billTotal:
            bill.billTotal == 0 ? 0 : double.parse(bill.billTotal.toString()),
        billDiscount: bill.billDiscount == 0
            ? 0
            : double.parse(bill.billDiscount.toString()),
        billPaid:
            bill.billPaid == 0 ? 0 : double.parse(bill.billPaid.toString()),
      );
    }
  }
}
