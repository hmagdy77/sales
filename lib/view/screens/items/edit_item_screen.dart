import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/edit_sup_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../models/items/item_model.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/dialouge.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';

class EditItemScreen extends StatelessWidget {
  EditItemScreen({super.key});
  final Item myItem = Get.arguments[0];
  final int kind = Get.arguments[1];
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final EditSupControllerImp editSupController =
      Get.put(EditSupControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(
            isAdminScreen: false,
            onPressed: () {},
          ),
          Expanded(
            child: Form(
              key: itemController.editItemKey,
              child: Obx(
                () {
                  if (itemController.isLoading.value) {
                    return const MyLottieLoading();
                  } else if (kind == 2) {
                    return MyContainer(
                      content: ListView(
                        children: [
                          Text(MyStrings.rent,
                              style: context.textTheme.titleSmall),
                          //for height
                          SizedBox(
                            height: AppSizes.w1,
                          ),
                          // idNumber
                          Text(
                            '${MyStrings.idNumber} : ${myItem.itemId}',
                            style: context.textTheme.bodyMedium,
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //name and pincode
                          Row(
                            children: [
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
                              SizedBox(
                                width: AppSizes.w1,
                              ),
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
                          //pricein and priceout
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.priceOut,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.thePrice,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${MyStrings.time} : ',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                              itemController.selectedTime.value,
                                              style:
                                                  context.textTheme.bodySmall),
                                          items: MyStrings.rentList
                                              .map((package) =>
                                                  DropdownMenuItem<String>(
                                                    value: package,
                                                    child: Text(package,
                                                        style: context.textTheme
                                                            .bodySmall),
                                                  ))
                                              .toList(),
                                          value: myItem.itemPakage,
                                          onChanged: (value) {
                                            itemController.selectedTime.value =
                                                value as String;
                                            myItem.itemPakage = value;
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
                          //edit and delete buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //edit sup
                              MyButton(
                                // minWidth: true,
                                text: MyStrings.editItem,
                                onPressed: () {
                                  var time = itemController.selectedTime.value;
                                  if (time.isEmpty) {
                                    MySnackBar.snack(MyStrings.time, '');
                                  } else {
                                    itemController.editItem(
                                      item: myItem,
                                    );
                                  }
                                },
                              ),
                              //delete item
                              MyButton(
                                // minWidth: true,
                                text: MyStrings.deleteItem,
                                onPressed: () {
                                  myDialuge(
                                      cancel: () {
                                        Get.back();
                                      },
                                      confirmTitle: MyStrings.confirm,
                                      cancelTitle: MyStrings.cancel,
                                      confirm: () {
                                        itemController.deleteItem(
                                            myItem.itemId.toString());
                                      },
                                      title: MyStrings.deleteItem,
                                      middleText: '');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (kind == 3) {
                    return MyContainer(
                      content: ListView(
                        children: [
                          Text(MyStrings.fix,
                              style: context.textTheme.titleSmall),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // idNumber
                          Text(
                            '${MyStrings.idNumber} : ${myItem.itemId}',
                            style: context.textTheme.bodyMedium,
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //name and pincode
                          Row(
                            children: [
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
                              SizedBox(
                                width: AppSizes.w1,
                              ),
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
                          //pricein and priceout
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.priceOut,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.thePrice,
                                  hint: '',
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              const Spacer(),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //edit and delete buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //edit sup
                              MyButton(
                                // minWidth: true,
                                text: MyStrings.editItem,
                                onPressed: () {
                                  itemController.editItem(
                                    item: myItem,
                                  );
                                },
                              ),
                              //delete item
                              MyButton(
                                // minWidth: true,
                                text: MyStrings.deleteItem,
                                onPressed: () {
                                  myDialuge(
                                      cancel: () {
                                        Get.back();
                                      },
                                      confirmTitle: MyStrings.confirm,
                                      cancelTitle: MyStrings.cancel,
                                      confirm: () {
                                        itemController.deleteItem(
                                            myItem.itemId.toString());
                                      },
                                      title: MyStrings.deleteItem,
                                      middleText: '');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (kind == 0) {
                    return MyContainer(
                      content: ListView(
                        children: [
                          Text(MyStrings.stock,
                              style: context.textTheme.titleSmall),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // idNumber
                          Text(
                            '${MyStrings.idNumber} : ${myItem.itemId}',
                            style: context.textTheme.bodyMedium,
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //name and pincode
                          Row(
                            children: [
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
                              SizedBox(
                                width: AppSizes.w1,
                              ),
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
                          //pricein and priceout
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.priceIn,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.itemPriceIn,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.priceOut,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
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
                          //pricein and priceout
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.min,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.min,
                                  hint: '',
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.max,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.max,
                                ),
                              )
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
                                child: MyTextField(
                                  controller: itemController.numberOfpices,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdminNum,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.numberOfPices,
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
                                          value: myItem.itemPakage.toString(),
                                          onChanged: (value) {
                                            itemController.selectedPackage
                                                .value = value as String;
                                            myItem.itemPakage = value;
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
                          //dropDown for  supName

                          Row(
                            children: [
                              Text(
                                '${MyStrings.supName}  :  ',
                                style: context.textTheme.bodyMedium,
                              ),
                              SizedBox(
                                width: AppSizes.w01,
                              ),
                              SizedBox(
                                width: AppSizes.w5,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: Text(
                                        editSupController.selectedSup.value,
                                        style: context.textTheme.bodySmall),
                                    items: editSupController.supList
                                        .map(
                                          (sup) => DropdownMenuItem<String>(
                                            value: sup.supName,
                                            child: Text(
                                              sup.supName,
                                              style:
                                                  context.textTheme.bodySmall,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    value: myItem.itemSup.toString(),
                                    onChanged: (value) {
                                      editSupController.selectedSup.value =
                                          value as String;
                                      myItem.itemSup = value;
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      height: 40,
                                      width: 140,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //edit and delete buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //edit sup
                              MyButton(
                                // minWidth: true,
                                text: MyStrings.editItem,
                                onPressed: () {
                                  var sup = editSupController.selectedSup.value;
                                  if (sup.isEmpty) {
                                    MySnackBar.snack(MyStrings.choseSup, '');
                                  } else {
                                    itemController.editItem(
                                      item: myItem,
                                      sup: sup,
                                    );
                                  }
                                },
                              ),
                              //delete item
                              MyButton(
                                // minWidth: true,
                                text: MyStrings.deleteItem,
                                onPressed: () {
                                  myDialuge(
                                      cancel: () {
                                        Get.back();
                                      },
                                      confirmTitle: MyStrings.confirm,
                                      cancelTitle: MyStrings.cancel,
                                      confirm: () {
                                        itemController.deleteItem(
                                            myItem.itemId.toString());
                                      },
                                      title: MyStrings.deleteItem,
                                      middleText: '');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return MyContainer(
                      content: ListView(
                        children: [
                          Text(MyStrings.bikes,
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
                                          value: myItem.bikeCondition,
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
                                child: MyTextField(
                                  controller: itemController.priceIn,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdminNum,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.itemPriceIn,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.priceOut,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 1,
                                      type: AppStrings.validateAdminNum,
                                      val: val,
                                    );
                                  },
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
                                          value: myItem.itemSup,
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
