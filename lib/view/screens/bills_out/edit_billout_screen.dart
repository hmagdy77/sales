import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/works/work_controller.dart';
import '../../../controllers/works/work_item_controller.dart';
import '../../../core/class/pdf_bill_out.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

import '../../../core/functions/sub_string.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../models/bills/bill_model.dart';
import '../../../routes.dart';
import '../../widgets/bills_out/bill_out_cart_item.dart';
import '../../widgets/bills_out/price_container.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/public/dialouge.dart';
import '../../widgets/public/label_text.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_number_field.dart';
import '../../widgets/text_fields/my_text_field.dart';

class EditBillOutScreen extends StatelessWidget {
  EditBillOutScreen({super.key});
  //billsOut
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());
  final BillOutItemControllerImp billOutItemController =
      Get.put(BillOutItemControllerImp());
  final BillOutCartControllerImp cartController =
      Get.put(BillOutCartControllerImp());
//items
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
//work
  final WorkControllerImp workController = Get.put(WorkControllerImp());
  final WorkItemControllerImp workItemController =
      Get.put(WorkItemControllerImp());
  final Bill bill = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (billOutItemController.isLoading.value ||
              billOutController.isLoading.value ||
              itemController.isLoading.value) {
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
                                Get.offAllNamed(AppRoutes.searchBillOutScreen);
                                cartController.myCarts.clear();
                                cartController.controllers!.clear();
                                cartController.isOverd!.clear();
                              },
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Center(
                              child: LabelText(
                                  label: bill.isBack == 0
                                      ? MyStrings.editBillsOut
                                      : bill.isBack == 1
                                          ? MyStrings.editBackBillsOut
                                          : bill.isBack == 2
                                              ? MyStrings.editBillsOutRent
                                              : bill.isBack == 3
                                                  ? MyStrings.editBillsOutFix
                                                  : bill.isBack == 4
                                                      ? MyStrings
                                                          .editBillOutBike
                                                      : MyStrings
                                                          .editBackBillOutBike),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${MyStrings.workeNum} : ${bill.workNum}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                Text(
                                  '${MyStrings.billDate} : ${DateFormat.yMEd().format(DateTime.now())}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${MyStrings.billNumper} : ${bill.billId.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                Text(
                                  '${MyStrings.billTime} : ${DateFormat.jm().format(bill.billTimestamp)}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              ' ${MyStrings.numberOfitems} : ${cartController.myCarts.length}',
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h04,
                        ),
                        //agent name and phone
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller:
                                    billOutController.agentNameController,
                                validate: (val) {
                                  return validInput(
                                    max: 80,
                                    min: 1,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.agentName,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w01,
                            ),
                            Expanded(
                              child: MyTextField(
                                controller:
                                    billOutController.agentPhoneController,
                                validate: (val) {
                                  return validInput(
                                    max: 80,
                                    min: 1,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.agentPhone,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w01,
                            ),
                            Expanded(
                              child: MyTextField(
                                controller:
                                    billOutController.billNotesController,
                                validate: (val) {
                                  return validInput(
                                    max: 80,
                                    min: 1,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.notes,
                              ),
                            ),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h03,
                        ),
                        //cart items
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: cartController.myCarts.isEmpty
                                    ? Text(
                                        MyStrings.emptyList,
                                        style: context.textTheme.titleSmall,
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
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: AppSizes.h02),
                                                  child: BillOutCartItem(
                                                    isBack: false,
                                                    inEdit: true,
                                                    index: index,
                                                    billOutItem: cartController
                                                        .myCarts.keys
                                                        .toList()[index],
                                                    quantity: cartController
                                                        .myCarts.values
                                                        .toList()[index],
                                                  ),
                                                );
                                              },
                                              itemCount:
                                                  cartController.myCarts.length,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              // prices table
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Spacer(),
                                        // bill total
                                        Row(
                                          children: [
                                            const PriceContainer(
                                              isConst: true,
                                              text: MyStrings.billTotal,
                                            ), // totalController
                                            PriceContainer(
                                                isConst: false,
                                                text: cartController.total
                                                    .toString()
                                                    .maxLength(12)),
                                          ],
                                        ),
                                        // for height
                                        SizedBox(
                                          height: AppSizes.h01,
                                        ),
                                        //  discount
                                        Row(
                                          children: [
                                            const PriceContainer(
                                              isConst: true,
                                              text: MyStrings.discount,
                                            ),
                                            //  discountController
                                            SizedBox(
                                              width: AppSizes.w15,
                                              height: AppSizes.h06,
                                              child: MyNumberField(
                                                controller: billOutController
                                                    .discountController,
                                                label: MyStrings.discount,
                                                onChange: (discount) {
                                                  if (discount.isNotEmpty) {
                                                    billOutController
                                                            .discountValue
                                                            .value =
                                                        int.parse(discount);
                                                  } else {
                                                    billOutController
                                                        .discountValue
                                                        .value = 0;
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        // for height
                                        SizedBox(
                                          height: AppSizes.h01,
                                        ),
                                        // totalAfterDiscount
                                        Row(
                                          children: [
                                            const PriceContainer(
                                              isConst: true,
                                              text:
                                                  MyStrings.totalAfterDiscount,
                                            ),
                                            // afterDiscount
                                            PriceContainer(
                                                isConst: false,
                                                text: billOutController
                                                    .afterDiscount(
                                                        total: double.parse(
                                                            cartController.total
                                                                .toString()))
                                                    .toStringAsFixed(2)
                                                    .maxLength(12)),
                                          ],
                                        ),
                                        // for height
                                        SizedBox(
                                          height: AppSizes.h01,
                                        ),
                                        // paid
                                        Row(
                                          children: [
                                            const PriceContainer(
                                              isConst: true,
                                              text: MyStrings.paid,
                                            ),
                                            // paidController
                                            SizedBox(
                                              width: AppSizes.w15,
                                              height: AppSizes.h06,
                                              child: MyNumberField(
                                                controller: billOutController
                                                    .paidController,
                                                label: MyStrings.paid,
                                                onChange: (paid) {
                                                  if (paid.isNotEmpty) {
                                                    billOutController
                                                            .paidValue.value =
                                                        int.parse(paid);
                                                  } else {
                                                    billOutController
                                                        .paidValue.value = 0;
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        // for height
                                        SizedBox(
                                          height: AppSizes.h01,
                                        ),
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
                                                text: billOutController
                                                    .unPaid(
                                                        afterDiscount: billOutController
                                                            .afterDiscount(
                                                                total: double.parse(
                                                                    cartController
                                                                        .total
                                                                        .toString())))
                                                    .toStringAsFixed(2)
                                                    .maxLength(12)),
                                          ],
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // //save and print buttons
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //save button
                              MyButton(
                                text: MyStrings.save,
                                minWidth: AppSizes.w3,
                                onPressed: () async {
                                  await saveFunction();
                                },
                              ),
                              //print button
                              MyButton(
                                text: MyStrings.print,
                                minWidth: AppSizes.w3,
                                onPressed: () {
                                  printFunction();
                                },
                              ),
                              //do dialouge
                              MyButton(
                                text: MyStrings.deleteBill,
                                minWidth: AppSizes.w3,
                                onPressed: () {
                                  myDialuge(
                                      cancel: () {
                                        Get.back();
                                        cartController.myCarts.clear();
                                        cartController.controllers!.clear();
                                      },
                                      confirmTitle: MyStrings.confirm,
                                      cancelTitle: MyStrings.cancel,
                                      confirm: () {
                                        List items = cartController.myCarts.keys
                                            .toList();
                                        if (bill.isBack == 0) {
                                          for (int i = 0;
                                              i < items.length;
                                              i++) {
                                            itemController.stock(
                                                items[i].stockId.toString(),
                                                (items[i].itemCount)
                                                    .toString());
                                            workItemController.editItems(
                                                item: items[i],
                                                itemCount: (-items[i].itemCount)
                                                    .toString(),
                                                workId: items[i].workId,
                                                isBack: '0');
                                          }
                                        } else {
                                          for (int i = 0;
                                              i < items.length;
                                              i++) {
                                            itemController.stock(
                                                items[i].stockId.toString(),
                                                (items[i].itemCount)
                                                    .toString());
                                            workItemController.editItems(
                                                item: items[i],
                                                itemCount: (-items[i].itemCount)
                                                    .toString(),
                                                workId: items[i].workId,
                                                isBack: '1');
                                          }
                                        }
                                        // update work total
                                        if (bill.isBack == 0) {
                                          workController.updateTotal(
                                              workId: bill.workNum.toString(),
                                              total: -double.parse(bill
                                                  .billAfterAiscount
                                                  .toString()));
                                        } else {
                                          workController.updateTotal(
                                              workId: bill.workNum.toString(),
                                              total: double.parse(bill
                                                  .billAfterAiscount
                                                  .toString()));
                                        }
                                        billOutItemController.deleteItems(
                                            bill.billId.toString());
                                        billOutController
                                            .deleteBill(bill.billId.toString());
                                        cartController.myCarts.clear();
                                        cartController.controllers!.clear();
                                      },
                                      title: MyStrings.deleteBill,
                                      middleText: '');
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

  Future<void> saveFunction() async {
    if (billOutController.paidValue.value == 0) {
      MySnackBar.snack(MyStrings.pleaseEnterPaid, '');
    } else if (billOutController.unPaid(
            afterDiscount: billOutController.afterDiscount(
                total: double.parse(cartController.total))) <
        0) {
      MySnackBar.snack(MyStrings.paidLessWanted, '');
    } else {
      List items = cartController.myCarts.keys.toList();
      for (int i = 0; i < items.length; i++) {
        await billOutItemController.editItems(
          billId: bill.billId.toString(),
          item: items[i],
          itemCount: cartController.myCarts.values.toList()[i].toString(),
        );
        int stockDiffrence =
            (int.parse(cartController.myCarts.values.toList()[i].toString()) -
                int.parse(items[i].itemCount.toString()));
        //stock
        if (bill.isBack == 0) {
          itemController.stock(
              items[i].stockId.toString(), (-stockDiffrence).toString());
          workItemController.editItems(
              item: items[i],
              itemCount: (stockDiffrence).toString(),
              workId: items[i].workId,
              isBack: '0');
        } else {
          workItemController.editItems(
              item: items[i],
              itemCount: (stockDiffrence).toString(),
              workId: items[i].workId,
              isBack: '1');
          itemController.stock(
              items[i].stockId.toString(), (-stockDiffrence).toString());
        }
      }
      //update work total
      double workDiffrence = double.parse((bill.billAfterAiscount -
              (double.parse(cartController.total.toString()) -
                  billOutController.discountValue.value))
          .toString());
      if (bill.isBack == 0) {
        workController.updateTotal(
            workId: bill.workNum.toString(), total: -workDiffrence);
      } else {
        workController.updateTotal(
          workId: bill.workNum.toString(),
          total: workDiffrence,
        );
      }
      billOutController.editBillOut(
        id: bill.billId.toString(),
        total: cartController.total.toString(),
        numberOfItems: cartController.myCarts.length.toString(),
      );
      cartController.myCarts.clear();
      cartController.controllers!.clear();
    }
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
        casherName: bill.workName,
        workNum: bill.workNum,
        agentName: billOutController.agentNameController.text,
        agentPhone: billOutController.agentPhoneController.text,
        billDate: DateFormat.yMEd().format(DateTime.now()),
        billTime: DateFormat.jm().format(DateTime.now()),
        billLenth: cartController.myCarts.length.toString(),
        billNumber: bill.billId.toString(),
        items: cartController.items,
        billTotal:
            cartController.total == 0 ? 0 : double.parse(cartController.total),
        billDiscount: billOutController.discountController.text.isEmpty
            ? 0
            : (double.parse(billOutController.discountController.text)),
        billPaid: billOutController.paidController.text.isEmpty
            ? 0
            : (double.parse(billOutController.paidController.text)),
      );
    } else {
      cartController.items.clear();
      List items = cartController.myCarts.keys.toList();
      for (int i = 0; i < items.length; i++) {
        cartController.items.add(
          [
            (cartController.myCarts.values.toList()[i] * items[i].itemPriceOut)
                .toString(),
            cartController.myCarts.values.toList()[i].toString(),
            items[i].itemPriceOut.toString(),
            items[i].itemName,
          ],
        );
      }
      printBillOut(
        isBack: bill.isBack,
        casherName: bill.workName,
        workNum: bill.workNum,
        agentName: billOutController.agentNameController.text,
        agentPhone: billOutController.agentPhoneController.text,
        billDate: DateFormat.yMEd().format(bill.billTimestamp),
        billTime: DateFormat.jm().format(bill.billTimestamp),
        billLenth: cartController.myCarts.length.toString(),
        billNumber: bill.billId.toString(),
        items: cartController.items,
        billTotal:
            cartController.total == 0 ? 0 : double.parse(cartController.total),
        billDiscount: billOutController.discountController.text.isEmpty
            ? 0
            : (double.parse(billOutController.discountController.text)),
        billPaid: billOutController.paidController.text.isEmpty
            ? 0
            : (double.parse(billOutController.paidController.text)),
      );
    }
  }
}
