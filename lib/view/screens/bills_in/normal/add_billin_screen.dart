import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/bill_in/bill_in_cart.dart';
import '../../../../controllers/bill_in/bill_in_controller.dart';
import '../../../../controllers/bill_in/bill_in_item_controller.dart';
import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/supplires/edit_sup_controller.dart';
import '../../../../core/class/pdf_bill_in.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/sub_string.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../widgets/bills_in/bill_in_cart_item.dart';
import '../../../widgets/items/item_widget.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_empty.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_number_field.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class AddBillInScreen extends StatelessWidget {
  AddBillInScreen({super.key});
  final BillInControllerImp billInController = Get.put(BillInControllerImp());
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final EditSupControllerImp supController = Get.put(EditSupControllerImp());
  final BillInItemControllerImp billItemController =
      Get.put(BillInItemControllerImp());
  final BillInCartControllerImp cartController =
      Get.put(BillInCartControllerImp());
  @override
  Widget build(BuildContext context) {
    int? isAdmin =
        cartController.myService.sharedPreferences.getInt(MyStrings.adminKey);
    return Scaffold(
      body: Obx(
        () {
          if (billInController.isLoading.value ||
              itemController.isLoading.value ||
              supController.isLoading.value ||
              billItemController.isLoading.value ||
              cartController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            var bill = billInController.billsInListReversed[0];
            return Column(
              children: [
                UpperWidget(isAdminScreen: false, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              ' ${MyStrings.billInNumper} : ${bill.billId.toString()}',
                              style: context.textTheme.bodyMedium,
                            ),
                            Text(
                              ' ${MyStrings.numberOfitems} : ${cartController.myCarts.length.toString()}',
                              style: context.textTheme.bodyMedium,
                            ),
                            Text(
                              '${MyStrings.billDate} : ${DateFormat.yMEd().format(DateTime.now())}',
                              style: context.textTheme.bodyMedium,
                            ),
                            isAdmin == 1
                                ? Text(
                                    '${MyStrings.billTotal} : ${cartController.total.toString().maxLength(12)}',
                                    style: context.textTheme.bodyMedium,
                                  )
                                : Container(),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h03,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              //textfield for items and dropdown for sup
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // billkind
                                    SizedBox(
                                      width: AppSizes.h6,
                                      child: Row(
                                        children: [
                                          Text(
                                            ' ${MyStrings.billKind} : ',
                                            style: context.textTheme.bodyMedium,
                                          ),
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                hint: Text(
                                                    billInController
                                                        .billKind.value,
                                                    style: context
                                                        .textTheme.bodySmall),
                                                items: MyStrings.billInkindList
                                                    .map(
                                                      (kind) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: kind,
                                                        child: Text(kind,
                                                            style: context
                                                                .textTheme
                                                                .bodySmall),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) {
                                                  billInController.billKind
                                                      .value = value as String;
                                                  switch (billInController
                                                      .billKind.value) {
                                                    case MyStrings.stock:
                                                      itemController
                                                          .searchKind('0');
                                                      break;
                                                    case MyStrings.bikes:
                                                      itemController
                                                          .searchKind('4');
                                                      break;
                                                  }
                                                  cartController.myCarts
                                                      .clear();
                                                  cartController.controllers!
                                                      .clear();
                                                  cartController.isOverd!
                                                      .clear();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //for height
                                    SizedBox(
                                      height: AppSizes.h02,
                                    ),
                                    // choseSup
                                    SizedBox(
                                      width: AppSizes.h6,
                                      child: Row(
                                        children: [
                                          Text(
                                            ' ${MyStrings.supName} : ',
                                            style: context.textTheme.bodyMedium,
                                          ),
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                hint: Text(
                                                    supController
                                                        .selectedSup.value,
                                                    style: context
                                                        .textTheme.bodySmall),
                                                items: supController.supList
                                                    .map(
                                                      (sup) => DropdownMenuItem<
                                                          String>(
                                                        value: sup.supName,
                                                        child: Text(sup.supName,
                                                            style: context
                                                                .textTheme
                                                                .bodySmall),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) {
                                                  supController.selectedSup
                                                      .value = value as String;
                                                  switch (billInController
                                                      .billKind.value) {
                                                    case MyStrings.stock:
                                                      itemController
                                                          .searchInList(
                                                              searchName: value
                                                                  .toString(),
                                                              kind: 0);
                                                      break;
                                                    case MyStrings.bikes:
                                                      itemController
                                                          .searchInList(
                                                              searchName: value
                                                                  .toString(),
                                                              kind: 4);
                                                      break;
                                                  }
                                                  cartController.myCarts
                                                      .clear();
                                                  cartController.controllers!
                                                      .clear();
                                                  cartController.isOverd!
                                                      .clear();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //for height
                                    SizedBox(
                                      height: AppSizes.h02,
                                    ),
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
                                          switch (
                                              billInController.billKind.value) {
                                            case MyStrings.stock:
                                              itemController.searchInList(
                                                  searchName: val.toString(),
                                                  kind: 0);
                                              break;
                                            case MyStrings.bikes:
                                              itemController.searchInList(
                                                  searchName: val.toString(),
                                                  kind: 4);
                                              break;
                                          }
                                          var list =
                                              itemController.searchItemsList;
                                          if (list.length == 1) {
                                            cartController.addToCarts(list[0]);
                                          }
                                        },
                                        onSubmit: (val) {
                                          itemController.searchInList(
                                              searchName: val, kind: 0);
                                          var list =
                                              itemController.searchItemsList;
                                          cartController.addToCarts(list[0]);
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
                                              var list = itemController
                                                  .searchItemsList;
                                              if (list.isEmpty &&
                                                  itemController
                                                      .name.text.isNotEmpty) {
                                                return const MyLottieEmpty();
                                              } else {
                                                return ListView.separated(
                                                  itemCount: list.length,
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const Divider(
                                                      thickness: 2,
                                                    );
                                                  },
                                                  itemBuilder:
                                                      (context, index) {
                                                    var item = list[index];
                                                    return GestureDetector(
                                                      onTap: () {
                                                        if (billInController
                                                                    .billKind
                                                                    .value ==
                                                                MyStrings
                                                                    .bikes &&
                                                            item.bikeKind
                                                                .isNotEmpty) {
                                                          cartController
                                                              .addToCarts(item);
                                                        } else if (billInController
                                                                    .billKind
                                                                    .value ==
                                                                MyStrings
                                                                    .stock &&
                                                            item.bikeKind
                                                                .isEmpty) {
                                                          cartController
                                                              .addToCarts(item);
                                                        } else {
                                                          MySnackBar.snack(
                                                              MyStrings
                                                                  .billKind,
                                                              '');
                                                        }
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
                              SizedBox(
                                width: AppSizes.w02,
                              ),
                              //cart items
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    // cart items
                                    Expanded(
                                      // height: AppSizes.w5 * 1.2,
                                      child: Obx(
                                        () {
                                          if (cartController.myCarts.isEmpty) {
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
                                                      gridDelegate:
                                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                                              maxCrossAxisExtent:
                                                                  AppSizes.w25),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var item = cartController
                                                            .myCarts.keys
                                                            .toList()[index];
                                                        return BillInCartItem(
                                                          isBack: false,
                                                          inEdit: false,
                                                          index: index,
                                                          billInItem: item,
                                                          quantity:
                                                              cartController
                                                                      .myCarts
                                                                      .values
                                                                      .toList()[
                                                                  index],
                                                        );
                                                      },
                                                      itemCount: cartController
                                                          .myCarts.length),
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
                            ],
                          ),
                        ),
                        //save and print buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //clearCart
                            Expanded(
                              child: MyButton(
                                text: MyStrings.deleteAll,
                                minWidth: AppSizes.w3,
                                onPressed: () {
                                  cartController.clearCart();
                                },
                              ),
                            ),
                            //  print button
                            Expanded(
                              child: MyButton(
                                text: MyStrings.print,
                                minWidth: AppSizes.w3,
                                onPressed: () {
                                  cartController.items.clear();
                                  List items =
                                      cartController.myCarts.keys.toList();
                                  for (int i = 0; i < items.length; i++) {
                                    cartController.items.add(
                                      [
                                        (cartController.myCarts.values
                                                    .toList()[i] *
                                                items[i].itemPriceIn)
                                            .toString(),
                                        cartController.myCarts.values
                                            .toList()[i]
                                            .toString(),
                                        items[i].itemPriceIn.toString(),
                                        items[i].itemName
                                      ],
                                    );
                                  }
                                  printBillIn(
                                    isBack: 0,
                                    supName: supController.selectedSup.value,
                                    billDate: DateFormat.yMEd()
                                        .format(DateTime.now()),
                                    billTime:
                                        DateFormat.jm().format(DateTime.now()),
                                    billLenth: cartController.myCarts.length
                                        .toString(),
                                    billNumber: bill.billId.toString(),
                                    items: cartController.items,
                                    billTotal: double.parse(
                                        cartController.total.toString()),
                                    billPayment: billInController
                                            .billPayment.text.isEmpty
                                        ? 0
                                        : double.parse(
                                            billInController.billPayment.text),
                                    billNotes:
                                        billInController.billNotes.text.isEmpty
                                            ? MyStrings.notFound
                                            : billInController.billNotes.text,
                                  );
                                },
                              ),
                            ),
                            // save button
                            Expanded(
                              child: MyButton(
                                text: MyStrings.save,
                                minWidth: AppSizes.w3,
                                onPressed: () async {
                                  var sup = supController.selectedSup.value;
                                  var bill =
                                      billInController.billsInListReversed[0];
                                  if (sup.isEmpty) {
                                    MySnackBar.snack(MyStrings.choseSup, '');
                                  } else if (cartController.total == 0) {
                                    MySnackBar.snack(MyStrings.emptyList, '');
                                  } else {
                                    List items =
                                        cartController.myCarts.keys.toList();
                                    for (int i = 0; i < items.length; i++) {
                                      await billItemController.addBillInItem(
                                        billId: bill.billId.toString(),
                                        item: items[i],
                                        itemCount: cartController.myCarts.values
                                            .toList()[i],
                                      );
                                      itemController.stock(
                                          items[i].itemId.toString(),
                                          cartController.myCarts.values
                                              .toList()[i]
                                              .toString());
                                    }
                                    billInController.saveBillIn(
                                        id: bill.billId.toString(),
                                        sup: supController.selectedSup.value,
                                        total: cartController.total,
                                        numberOfItems: cartController
                                            .myCarts.length
                                            .toString(),
                                        isBack:
                                            billInController.billKind.value ==
                                                    MyStrings.stock
                                                ? '0'
                                                : '4');

                                    billInController
                                        .addBillIn(MyStrings.supName);
                                    cartController.myCarts.clear();
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: MyTextField(
                                controller: billInController.billNotes,
                                label: MyStrings.notes,
                                onChange: (discount) {},
                                validate: () {},
                              ),
                            ),
                            // for width
                            SizedBox(
                              width: AppSizes.w02,
                            ),
                            Expanded(
                              child: MyNumberField(
                                controller: billInController.billPayment,
                                label: MyStrings.billPayment,
                                onChange: (discount) {},
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
