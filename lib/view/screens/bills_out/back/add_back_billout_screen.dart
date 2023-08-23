import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/bill_out/bill_out_cart.dart';
import '../../../../controllers/bill_out/bill_out_controller.dart';
import '../../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/supplires/edit_sup_controller.dart';
import '../../../../controllers/works/work_controller.dart';
import '../../../../controllers/works/work_item_controller.dart';
import '../../../../core/class/pdf_bill_out.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/sub_string.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../../models/bills/bill_model.dart';
import '../../../../models/works/work_model.dart';
import '../../../widgets/bills_out/bill_out_cart_item.dart';
import '../../../widgets/bills_out/price_container.dart';
import '../../../widgets/items/item_widget.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_empty.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_number_field.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class AddBackBillOutScreen extends StatelessWidget {
  AddBackBillOutScreen({super.key});
//itrms
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final EditSupControllerImp supController = Get.put(EditSupControllerImp());
//bills
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());
  final BillOutItemControllerImp billOutItemController =
      Get.put(BillOutItemControllerImp());
  final BillOutCartControllerImp cartController =
      Get.put(BillOutCartControllerImp());
//works
  final WorkControllerImp workController = Get.put(WorkControllerImp());
  final WorkItemControllerImp workItemController =
      Get.put(WorkItemControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (itemController.isLoading.value ||
              supController.isLoading.value ||
              billOutController.isLoading.value ||
              billOutItemController.isLoading.value ||
              workController.isLoading.value ||
              cartController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var bill = billOutController.billsOutListReversed[0];
            var work = workController.worksListReversed[0];
            return Form(
              key: billOutController.billOutKey,
              child: Column(
                children: [
                  UpperWidget(isAdminScreen: true, onPressed: () {}),
                  Expanded(
                    child: MyContainer(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //work details
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${MyStrings.currentWork} : ${work.workId}',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    '${MyStrings.billOutBackNumper} : ${bill.billId}',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${MyStrings.cashierName} : ${work.workName}',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    ' ${MyStrings.numberOfitems} : ${cartController.myCarts.length}',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              Text(
                                '${MyStrings.billDate} : ${DateFormat.yMEd().format(DateTime.now())}',
                                style: context.textTheme.bodyMedium,
                              ),
                              const Spacer(),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h04,
                          ),
                          //agent phone and number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // agentNameController
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
                              //  for width
                              SizedBox(
                                width: AppSizes.w02,
                              ),
                              //  agentPhoneController
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
                              //  for width
                              SizedBox(
                                width: AppSizes.w02,
                              ),
                              //  billNotesController
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
                              //  for width
                              SizedBox(
                                width: AppSizes.w02,
                              ),
                              // bill kind
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${MyStrings.billKind} : ',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                              itemController.selectedKind.value,
                                              style:
                                                  context.textTheme.bodySmall),
                                          items: MyStrings.billInkindList
                                              .map((package) =>
                                                  DropdownMenuItem<String>(
                                                    value: package,
                                                    child: Text(package,
                                                        style: context.textTheme
                                                            .bodySmall),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            itemController.selectedKind.value =
                                                value.toString();
                                            switch (value) {
                                              case MyStrings.stock:
                                                cartController.myCarts.clear();
                                                cartController.controllers!
                                                    .clear();
                                                cartController.isOverd!.clear();
                                                itemController.searchKind('0');
                                                itemController.usedKind.value =
                                                    1;
                                                break;
                                              case MyStrings.bikes:
                                                cartController.myCarts.clear();
                                                cartController.controllers!
                                                    .clear();
                                                cartController.isOverd!.clear();
                                                itemController.searchKind('4');
                                                itemController.usedKind.value =
                                                    5;
                                                break;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ), //for height
                          SizedBox(
                            height: AppSizes.h02,
                          ),
                          //search  items and cart items
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //search  items
                                      SizedBox(
                                        width: AppSizes.h6,
                                        child: MyTextField(
                                          controller: itemController.name,
                                          validate: (val) {
                                            return validInput(
                                              max: 50,
                                              min: 0,
                                              type: AppStrings.validateAdmin,
                                              val: val,
                                            );
                                          },
                                          label: MyStrings.itemName,
                                          onChange: (val) {
                                            switch (itemController
                                                .selectedKind.value) {
                                              case MyStrings.stock:
                                                itemController.searchInList(
                                                    searchName: val, kind: 0);
                                                break;
                                              case MyStrings.bikes:
                                                itemController.searchInList(
                                                    searchName: val, kind: 4);
                                                break;
                                            }
                                            var list =
                                                itemController.searchItemsList;
                                            if (list.length == 1) {
                                              cartController
                                                  .addToCarts(list[0]);
                                            }
                                          },
                                          onSubmit: (val) {
                                            switch (itemController
                                                .selectedKind.value) {
                                              case MyStrings.stock:
                                                itemController.searchInList(
                                                    searchName: val, kind: 0);
                                                break;
                                              case MyStrings.bikes:
                                                itemController.searchInList(
                                                    searchName: val, kind: 4);
                                                break;
                                            }
                                            var list =
                                                itemController.searchItemsList;
                                            if (list.length == 1) {
                                              cartController
                                                  .addToCarts(list[0]);
                                            }
                                          },
                                        ),
                                      ),
                                      //for height
                                      SizedBox(
                                        height: AppSizes.h02,
                                      ),
                                      //items
                                      Expanded(
                                        child: SizedBox(
                                          width: AppSizes.h6,
                                          // height: AppSizes.h3,
                                          child: Obx(
                                            () {
                                              if (itemController
                                                  .isLoading.value) {
                                                return const MyLottieLoading();
                                              } else {
                                                if (itemController
                                                        .searchItemsList
                                                        .isEmpty &&
                                                    itemController
                                                        .name.text.isNotEmpty) {
                                                  return const MyLottieEmpty();
                                                } else {
                                                  return ListView.separated(
                                                    itemCount: itemController
                                                        .searchItemsList.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return const Divider(
                                                        thickness: 2,
                                                      );
                                                    },
                                                    itemBuilder:
                                                        (context, index) {
                                                      var item = itemController
                                                              .searchItemsList[
                                                          index];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addToCarts(item);
                                                        },
                                                        child: MyItemWidget(
                                                          item: item,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //  for width
                                SizedBox(
                                  width: AppSizes.w01,
                                ),
                                // cart items
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      // cart items
                                      Expanded(
                                        // height: AppSizes.w43,
                                        // width: AppSizes.w5 * 1.5,
                                        child: Obx(
                                          () {
                                            if (cartController
                                                .myCarts.isEmpty) {
                                              return Center(
                                                child: Text(
                                                  MyStrings.emptyList,
                                                  style: context
                                                      .textTheme.titleSmall,
                                                ),
                                              );
                                            } else {
                                              return Column(
                                                children: [
                                                  Expanded(
                                                    child: GridView.builder(
                                                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                            maxCrossAxisExtent:
                                                                AppSizes.w25),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return BillOutCartItem(
                                                            isBack: true,
                                                            inEdit: false,
                                                            index: index,
                                                            billOutItem:
                                                                cartController
                                                                        .myCarts
                                                                        .keys
                                                                        .toList()[
                                                                    index],
                                                            quantity:
                                                                cartController
                                                                        .myCarts
                                                                        .values
                                                                        .toList()[
                                                                    index],
                                                          );
                                                        },
                                                        itemCount:
                                                            cartController
                                                                .myCarts
                                                                .length),
                                                  ),
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //  for width
                                SizedBox(
                                  width: AppSizes.w01,
                                ),
                                // pricesTable
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
                                                text: MyStrings
                                                    .totalAfterDiscount,
                                              ),
                                              // afterDiscount
                                              PriceContainer(
                                                  isConst: false,
                                                  text: billOutController
                                                      .afterDiscount(
                                                          total: double.parse(
                                                              cartController
                                                                  .total
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
                          //save and print buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // save
                              Expanded(
                                child: MyButton(
                                  text: MyStrings.save,
                                  minWidth: AppSizes.w3,
                                  onPressed: () {
                                    saveFunction(work);
                                  },
                                ),
                              ),
                              // print Button
                              Expanded(
                                child: MyButton(
                                  text: MyStrings.print,
                                  minWidth: AppSizes.w3,
                                  onPressed: () {
                                    printFunction(work, bill);
                                  },
                                ),
                              ),
                              // clearCart
                              Expanded(
                                child: MyButton(
                                  text: MyStrings.deleteAll,
                                  minWidth: AppSizes.w3,
                                  onPressed: () {
                                    cartController.clearCart();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void printFunction(Work work, Bill bill) {
    cartController.items.clear();
    if (itemController.usedKind.value == 5) {
      List items = cartController.myCarts.keys.toList();
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
        isBack: itemController.usedKind.value,
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
            cartController.total == 0 ? 0 : double.parse(cartController.total),
        billDiscount: billOutController.discountController.text.isEmpty
            ? 0
            : (double.parse(billOutController.discountController.text)),
        billPaid: billOutController.paidController.text.isEmpty
            ? 0
            : (double.parse(billOutController.paidController.text)),
      );
    } else {
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
        isBack: itemController.usedKind.value,
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

  void saveFunction(Work work) {
    var bill = billOutController.billsOutListReversed[0];
    if (cartController.myCarts.isEmpty) {
      MySnackBar.snack(MyStrings.emptyList, '');
    } else if (billOutController.agentNameController.text.isEmpty) {
      MySnackBar.snack(MyStrings.agentName, '');
    } else if (billOutController.agentPhoneController.text.isEmpty) {
      MySnackBar.snack(MyStrings.agentPhone, '');
    } else if (billOutController.paidValue.value == 0) {
      MySnackBar.snack(MyStrings.pleaseEnterPaid, '');
    } else if (billOutController.unPaid(
            afterDiscount: billOutController.afterDiscount(
                total: double.parse(cartController.total))) <
        0) {
      MySnackBar.snack(MyStrings.paidLessWanted, '');
    } else {
      workController.updateTotal(
        workId: work.workId.toString(),
        total: -((double.parse(cartController.total) -
            billOutController.discountValue.value)),
      );
      billOutController.saveBillOut(
        id: bill.billId.toString(),
        total: cartController.total,
        numberOfItems: cartController.myCarts.length.toString(),
        isBack: itemController.usedKind.value.toString(),
        workNum: work.workId.toString(),
      );
      List items = cartController.myCarts.keys.toList();
      for (int i = 0; i < items.length; i++) {
        billOutItemController.addItems(
          billId: bill.billId.toString(),
          item: items[i],
          itemCount: cartController.myCarts.values.toList()[i],
          isBack: '1',
          workId: work.workId.toString(),
        );
        workItemController.addItems(
          item: items[i],
          itemCount: cartController.myCarts.values.toList()[i].toString(),
          isBack: '1',
          workId: work.workId.toString(),
        );
        itemController.stock(items[i].itemId.toString(),
            cartController.myCarts.values.toList()[i].toString());
      }
      billOutController.addBillOut();
      cartController.myCarts.clear();
    }
  }
}
