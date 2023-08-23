import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../controllers/bill_in/bill_in_item_controller.dart';

import '../../../controllers/supplires/edit_sup_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../routes.dart';
import '../../widgets/bills_in/bills_in_item.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_empty.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';

class SearchBillInScreen extends StatelessWidget {
  SearchBillInScreen({super.key});
  final BillInControllerImp billInController = Get.put(BillInControllerImp());
  final EditSupControllerImp supController = Get.put(EditSupControllerImp());
  final BillInItemControllerImp itemsController =
      Get.put(BillInItemControllerImp());
  final BillInCartControllerImp cartController =
      Get.put(BillInCartControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (billInController.isLoading.value ||
              supController.isLoading.value ||
              itemsController.isLoading.value ||
              cartController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            return Column(
              children: [
                UpperWidget(
                  isAdminScreen: false,
                  onPressed: () {},
                ),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MyStrings.editBillsIn,
                          style: context.textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: MyTextField(
                                controller:
                                    billInController.billInSearchController,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.billNumper,
                                onChange: (val) {
                                  billInController.search(val);
                                },
                                onSubmit: (val) {
                                  billInController.search(val);
                                },
                              ),
                            ),
                            // for width
                            SizedBox(
                              width: AppSizes.w02,
                            ),
                            Text(
                              ' ${MyStrings.supName} : ',
                              style: context.textTheme.bodyMedium,
                            ),
                            Expanded(child: dropDownForSup(context)),
                          ],
                        ),
                        Expanded(
                          child: Obx(
                            () {
                              if (billInController.isLoading.value) {
                                return const MyLottieLoading();
                              } else {
                                if (billInController
                                        .billsInSearchList.isEmpty &&
                                    billInController.billInSearchController.text
                                        .isNotEmpty) {
                                  return const MyLottieEmpty();
                                } else {
                                  return ListView.separated(
                                    itemCount: billInController
                                        .billsInSearchList
                                        .toSet()
                                        .length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 2,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      var billIn = billInController
                                          .billsInSearchList.reversed
                                          .toSet()
                                          .toList()[index];
                                      if (billIn.billSup == MyStrings.supName ||
                                          billIn.billSup.isEmpty) {
                                        return Container();
                                      } else {
                                        return GestureDetector(
                                          onTap: () async {
                                            await itemsController
                                                .getItemsByIndex(
                                                    billIn.billId.toString());
                                            await cartController.addAllToCarts(
                                                itemsController
                                                    .billsInItemsList);
                                            billInController.billPayment.text =
                                                billIn.billPayment.toString();
                                            billInController.billNotes.text =
                                                billIn.billNotes.toString();
                                            Get.toNamed(
                                                AppRoutes.editBillInScreen,
                                                arguments: [billIn]);
                                          },
                                          child: BillInItem(bill: billIn),
                                        );
                                      }
                                    },
                                  );
                                }
                              }
                            },
                          ),
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

  DropdownButtonHideUnderline dropDownForSup(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(supController.selectedSup.value,
            style: context.textTheme.bodySmall),
        items: supController.supList
            .map((sup) => DropdownMenuItem<String>(
                  value: sup.supName,
                  child: Text(sup.supName, style: context.textTheme.bodySmall),
                ))
            .toList(),
        onChanged: (value) {
          billInController.search(value.toString());
          supController.selectedSup.value = value as String;
          // print(supController.selectedSup.value.isNotEmpty);
        },
      ),
    );
  }
}

 
  




//  Obx(
//                       () {
//                         if (billInController.isLoading.value) {
//                           return Text(
//                             'loading',
//                             style: context.textTheme.headline1,
//                           );
//                         } else {
//                           if (billInController.billsInSearchList.isEmpty &&
//                               billInController.name.text.isEmpty) {
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               itemCount:
//                                   billInController.billsInList.length - 1,
//                               itemBuilder: (context, index) {
//                                 var billIn =
//                                     billInController.billsInList[index];
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Get.toNamed(AppRoutes.editbillInScreen,
//                                         arguments: [billIn]);
//                                   },
//                                   child: BillInItem(bill: billIn),
//                                 );
//                               },
//                             );
//                           } else {
//                             return ListView.builder(
//                               itemCount:
//                                   billInController.billsInSearchList.length - 1,
//                               separatorBuilder: (context, index) {
//                                 return const Divider(
//                                   thickness: 2,
//                                 );
//                               },
//                               itemBuilder: (context, index) {
//                                 var billIn =
//                                     billInController.billsInSearchList[index];
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Get.toNamed(AppRoutes.editbillInScreen,
//                                         arguments: [billIn]);
//                                   },
//                                   child: Container(
//                                     color: AppColorManger.grey,
//                                     height: AppSizes.h05,
//                                     margin: EdgeInsets.symmetric(
//                                         horizontal: AppSizes.w01, vertical: 5),
//                                     child: BillInItem(bill: billIn),
//                                   ),
//                                 );
//                               },
//                             );
//                           }
//                         }
//                       },
//                     ),
                