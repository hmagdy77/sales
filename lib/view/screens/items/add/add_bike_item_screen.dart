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

class AddBikeItemScreen extends StatelessWidget {
  AddBikeItemScreen({super.key});
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
                          Text('${MyStrings.addItems} ${MyStrings.bikes}',
                              style: context.textTheme.titleSmall),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //name textfield and code textfield
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
                              //cadr textfield
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
                                  label: MyStrings.bikeNum,
                                  hint: 'P18129898',
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //kind textfield and model textfield
                          Row(
                            children: [
                              //bikeKind textfield
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.bikeKind,
                                  validate: (val) {
                                    return validInput(
                                      max: 80,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.bikeKind,
                                ),
                              ),
                              //for width
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              //bikeModel textfield
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.bikeModel,
                                  validate: (val) {
                                    return validInput(
                                      max: 80,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.bikeModel,
                                  hint: 'P18129898',
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //bikeColor textfield &&  bike condition
                          Row(
                            children: [
                              //bikeColor textfield
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.bikeColor,
                                  validate: (val) {
                                    return validInput(
                                      max: 80,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.bikeColor,
                                ),
                              ),
                              //for width
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              // bike condition
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${MyStrings.condition} : ',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                              itemController
                                                  .selectedBikeCondtion.value,
                                              style:
                                                  context.textTheme.bodySmall),
                                          items: MyStrings.conditionList
                                              .map((package) =>
                                                  DropdownMenuItem<String>(
                                                    value: package,
                                                    child: Text(package,
                                                        style: context.textTheme
                                                            .bodySmall),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            itemController.selectedBikeCondtion
                                                .value = value as String;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
                                  label: MyStrings.itemPriceIn,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyNumberField(
                                  controller: itemController.priceOut,
                                  label: MyStrings.itemPriceOut,
                                  hint: '',
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // supName
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
                                  .selectedBikeCondtion.value.isEmpty) {
                                MySnackBar.snack(
                                    MyStrings.choeseBikeCondition, '');
                              } else if (itemController.priceIn.text.isEmpty ||
                                  itemController.priceOut.text.isEmpty) {
                                MySnackBar.snack(
                                    MyStrings.pleaseEnterWantedValues, '');
                              } else {
                                itemController.addItem(
                                  sup: sup,
                                  kind: 4,
                                  bikeColor: itemController.bikeColor.text,
                                  bikeModel: itemController.bikeModel.text,
                                  bikeKind: itemController.bikeKind.text,
                                  bikeCondition:
                                      itemController.selectedBikeCondtion.value,
                                );
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
