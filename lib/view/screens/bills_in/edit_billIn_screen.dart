import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../controllers/bill_in/bill_in_controller.dart';

import '../../../controllers/bill_in/bill_in_item_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/edit_sup_controller.dart';
import '../../../core/class/pdf_bill_in.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

import '../../../core/functions/sub_string.dart';
import '../../../models/bills/bill_model.dart';
import '../../../routes.dart';
import '../../widgets/public/dialouge.dart';
import '../../widgets/bills_in/bill_in_cart_item.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/public/label_text.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_number_field.dart';
import '../../widgets/text_fields/my_text_field.dart';

class EditBillInScreen extends StatelessWidget {
  EditBillInScreen({super.key});

  final BillInItemControllerImp billInItemController =
      Get.put(BillInItemControllerImp());
  final EditSupControllerImp supController = Get.put(EditSupControllerImp());
  final BillInCartControllerImp cartController =
      Get.put(BillInCartControllerImp());
  final BillInControllerImp billInController = Get.put(BillInControllerImp());
  final ItemControllerImp itemController = Get.put(ItemControllerImp());

  final Bill bill = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (billInItemController.isLoading.value ||
          supController.isLoading.value ||
          billInController.isLoading.value ||
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
                    Row(
                      children: [
                        MyButton(
                          text: MyStrings.back,
                          minWidth: AppSizes.w3,
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.searchBillInScreen);
                            cartController.myCarts.clear();
                            cartController.controllers!.clear();
                          },
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Center(
                          child: LabelText(
                              label: bill.isBack == 1
                                  ? MyStrings.editBackBillsIn
                                  : bill.isBack == 0
                                      ? MyStrings.editBillsIn
                                      : bill.isBack == 4
                                          ? MyStrings.editBillInBike
                                          : MyStrings.editBackBillInBike),
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
                        Text(
                          ' ${MyStrings.billNumper} : ${bill.billId.toString()}',
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          ' ${MyStrings.numberOfitems} : ${cartController.myCarts.length}',
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          '${MyStrings.billDate} : ${DateFormat.yMEd().format(bill.billTimestamp)}',
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          '${MyStrings.billTime} : ${DateFormat.jm().format(bill.billTimestamp)}',
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    //for height
                    SizedBox(
                      height: AppSizes.h04,
                    ),

                    //select items and sup
                    Row(
                      children: [
                        SizedBox(
                          width: AppSizes.w05,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text(
                                ' ${MyStrings.supName} : ',
                                style: context.textTheme.bodyMedium,
                              ),
                              Text(
                                ' ${bill.billSup}  ',
                                style: context.textTheme.bodyMedium,
                              ),
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: Text(supController.selectedSup.value,
                                        style: context.textTheme.bodySmall),
                                    items: supController.supList
                                        .map(
                                          (sup) => DropdownMenuItem<String>(
                                            value: sup.supName,
                                            child: Text(sup.supName,
                                                style: context
                                                    .textTheme.bodySmall),
                                          ),
                                        )
                                        .toList(),
                                    // value: editSupController.selectedSup.value,
                                    //  bill.billSup,

                                    onChanged: (value) {
                                      itemController.searchInList(
                                          searchName: value.toString(),
                                          kind: 0);
                                      supController.selectedSup.value =
                                          value as String;
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
                        Expanded(
                          flex: 3,
                          child: MyTextField(
                            controller: billInController.billNotes,
                            label: MyStrings.notes,
                            onChange: (discount) {},
                            validate: () {},
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.w02,
                        ),
                        Expanded(
                          flex: 1,
                          child: MyNumberField(
                            controller: billInController.billPayment,
                            label: MyStrings.billPayment,
                            onChange: (discount) {},
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
                      // height: AppSizes.h18,

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
                                      maxCrossAxisExtent: AppSizes.h25,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: AppSizes.h02),
                                        child: BillInCartItem(
                                          // isOvered: false,
                                          isBack: false,
                                          inEdit: true,
                                          index: index,
                                          billInItem: cartController
                                              .myCarts.keys
                                              .toList()[index],
                                          quantity: cartController
                                              .myCarts.values
                                              .toList()[index],
                                        ),
                                      );
                                    },
                                    itemCount: cartController.myCarts.length,
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
                              var sup = supController.selectedSup.value;
                              List items = cartController.myCarts.keys.toList();
                              if (sup.isEmpty) {
                                MySnackBar.snack(MyStrings.choseSup, '');
                              } else {
                                for (int i = 0; i < items.length; i++) {
                                  await billInItemController.editItems(
                                    itemId: items[i].itemId.toString(),
                                    billId: bill.billId.toString(),
                                    itemName: items[i].itemName,
                                    itemNum: items[i].itemNum,
                                    itemsup: items[i].itemSup,
                                    itemCount: cartController.myCarts.values
                                        .toList()[i]
                                        .toString(),
                                    itemPrice: items[i].itemPriceIn.toString(),
                                  );
                                  int diffrence = (int.parse(cartController
                                          .myCarts.values
                                          .toList()[i]
                                          .toString()) -
                                      int.parse(items[i].itemCount.toString()));
                                  if (bill.isBack == 1) {
                                    itemController.stock(
                                        items[i].stockId.toString(),
                                        (-diffrence).toString());
                                  } else {
                                    itemController.stock(
                                        items[i].stockId.toString(),
                                        diffrence.toString());
                                  }
                                }
                                billInController.editBillIn(
                                    id: bill.billId.toString(),
                                    sup: sup,
                                    total: cartController.total.toString(),
                                    numberOfItems: cartController.myCarts.length
                                        .toString());
                                cartController.myCarts.clear();
                                cartController.controllers!.clear();
                              }
                            },
                          ),
                          MyButton(
                            text: MyStrings.print,
                            minWidth: AppSizes.w3,
                            onPressed: () {
                              cartController.items.clear();
                              List items = cartController.myCarts.keys.toList();
                              for (int i = 0; i < items.length; i++) {
                                cartController.items.add(
                                  [
                                    (cartController.myCarts.values.toList()[i] *
                                            items[i].itemPriceIn)
                                        .toString(),
                                    cartController.myCarts.values
                                        .toList()[i]
                                        .toString(),
                                    items[i].itemPriceIn.toString(),
                                    items[i].itemName,
                                  ],
                                );
                              }
                              printBillIn(
                                isBack: bill.isBack == 1 ? 1 : 0,
                                supName: bill.billSup,
                                billDate: DateFormat.yMEd()
                                    .format(bill.billTimestamp),
                                billTime:
                                    DateFormat.jm().format(bill.billTimestamp),
                                billLenth:
                                    cartController.myCarts.length.toString(),
                                billNumber: bill.billId.toString(),
                                items: cartController.items,
                                billTotal: double.parse(
                                    cartController.total.toString()),
                                billPayment:
                                    billInController.billPayment.text.isEmpty
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
                                    List items =
                                        cartController.myCarts.keys.toList();
                                    if (bill.isBack == 0) {
                                      for (int i = 0; i < items.length; i++) {
                                        itemController.stock(
                                            items[i].stockId.toString(),
                                            (-items[i].itemCount).toString());
                                      }
                                    } else {
                                      for (int i = 0; i < items.length; i++) {
                                        itemController.stock(
                                            items[i].stockId.toString(),
                                            items[i].itemCount.toString());
                                      }
                                    }
                                    billInItemController
                                        .deleteItems(bill.billId.toString());
                                    billInController
                                        .deleteBill(bill.billId.toString());
                                    cartController.myCarts.clear();
                                    cartController.controllers!.clear();
                                    Get.offAndToNamed(AppRoutes.splashScreen);
                                  },
                                  title: MyStrings.deleteBill,
                                  middleText: '');
                            },
                          ),

                          Text(
                            '${MyStrings.billTotal} : ${cartController.total.toString().maxLength(12)}',
                            style: context.textTheme.bodyMedium,
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
    }));
  }
}
