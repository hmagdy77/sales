import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/supplires/edit_sup_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_number_field.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class AddStockItemScreen extends StatelessWidget {
  AddStockItemScreen({super.key});
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final EditSupControllerImp editSupController =
      Get.put(EditSupControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(isAdminScreen: false, onPressed: () {}),
          Expanded(
            child: Form(
              key: itemController.addItemKey,
              child: Obx(
                () {
                  if (itemController.isLoading.value) {
                    return const MyLottieLoading();
                  } else {
                    return MyContainer(
                      content: ListView(
                        children: [
                          Text('${MyStrings.addItems} ${MyStrings.stock}',
                              style: context.textTheme.titleSmall),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          Row(
                            children: [
                              //name textfield
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.name,
                                  validate: (val) {
                                    return validInput(
                                      max: 80,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.itemName,
                                ),
                              ),
                              //for width
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              //code textfield
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.num,
                                  validate: (val) {
                                    return validInput(
                                      max: 80,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.itemNum,
                                  hint: 'P18129898',
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //priceIn textfield and priceout textfield
                          Row(
                            children: [
                              Expanded(
                                child: MyNumberField(
                                  controller: itemController.priceIn,
                                  // validate: (val) {
                                  //   return validInput(
                                  //     max: 50,
                                  //     min: 1,
                                  //     type: AppStrings.validateAdminNum,
                                  //     val: val,
                                  //   );
                                  // },
                                  label: MyStrings.itemPriceIn,
                                  // onChange: (value) {
                                  //   // MyNumberField
                                  //   if (value.isEmpty) {
                                  //     MySnackBar.snack(
                                  //         MyStrings.itemPriceIn, '');
                                  //   }
                                  // },
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyNumberField(
                                  controller: itemController.priceOut,
                                  // validate: (val) {
                                  //   return validInput(
                                  //     max: 50,
                                  //     min: 1,
                                  //     type: AppStrings.validateAdminNum,
                                  //     val: val,
                                  //   );
                                  // },
                                  label: MyStrings.itemPriceOut,
                                  hint: '',
                                  // onChange: (value) {
                                  //   if (value.isEmpty) {
                                  //     MySnackBar.snack(
                                  //         MyStrings.itemPriceOut, '');
                                  //   }
                                  // },
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //priceIn textfield and priceout textfield
                          Row(
                            children: [
                              Expanded(
                                child: MyNumberField(
                                  controller: itemController.min,
                                  label: MyStrings.min,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyNumberField(
                                  controller: itemController.max,
                                  label: MyStrings.max,
                                  hint: '',
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // select package and numper of picees
                          Row(
                            children: [
                              Expanded(
                                child: MyNumberField(
                                  controller: itemController.quant,
                                  label: MyStrings.startedQuant,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyNumberField(
                                  controller: itemController.numberOfpices,
                                  // validate: (val) {
                                  //   return validInput(
                                  //     max: 50,
                                  //     min: 1,
                                  //     type: AppStrings.validateAdminNum,
                                  //     val: val,
                                  //   );
                                  // },
                                  label: MyStrings.numberOfPices,
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // select sup
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${MyStrings.supName} : ',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                              editSupController
                                                  .selectedSup.value,
                                              style:
                                                  context.textTheme.bodyMedium),
                                          items: editSupController.supList
                                              .map((sup) =>
                                                  DropdownMenuItem<String>(
                                                    value: sup.supName,
                                                    child: Text(
                                                      sup.supName,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            editSupController.selectedSup
                                                .value = value as String;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${MyStrings.packageKind} : ',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                              itemController
                                                  .selectedPackage.value,
                                              style:
                                                  context.textTheme.bodySmall),
                                          items: MyStrings.packageList
                                              .map((package) =>
                                                  DropdownMenuItem<String>(
                                                    value: package,
                                                    child: Text(package,
                                                        style: context.textTheme
                                                            .bodySmall),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            itemController.selectedPackage
                                                .value = value as String;
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //add button
                          MyButton(
                            // minWidth: true,
                            text: MyStrings.addItems,
                            onPressed: () {
                              var sup = editSupController.selectedSup.value;
                              if (sup.isEmpty) {
                                MySnackBar.snack(MyStrings.choseSup, '');
                              } else if (itemController
                                  .selectedPackage.value.isEmpty) {
                                MySnackBar.snack(MyStrings.packageKind, '');
                              } else if (itemController.priceOut.text.isEmpty ||
                                  itemController.priceIn.text.isEmpty ||
                                  itemController.quant.text.isEmpty ||
                                  itemController.min.text.isEmpty ||
                                  itemController.max.text.isEmpty ||
                                  itemController.numberOfpices.text.isEmpty) {
                                MySnackBar.snack(
                                    MyStrings.pleaseEnterWantedValues, '');
                              } else {
                                itemController.addItem(sup: sup, kind: 0);
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
