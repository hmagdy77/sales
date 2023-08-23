import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../controllers/items/item_controller.dart';
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

class AddRentItemScreen extends StatelessWidget {
  AddRentItemScreen({super.key});
  final ItemControllerImp itemController = Get.put(ItemControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (itemController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            return Form(
              key: itemController.addItemKey,
              child: Column(
                children: [
                  UpperWidget(isAdminScreen: false, onPressed: () {}),
                  MyContainer(
                    content: Column(
                      children: [
                        Text('${MyStrings.addItems} ${MyStrings.rent}',
                            style: context.textTheme.titleSmall),
                        //for height
                        SizedBox(
                          height: AppSizes.w2,
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
                        //price textfield and selectedTime Dropdown
                        Row(
                          children: [
                            Expanded(
                              child: MyNumberField(
                                controller: itemController.priceOut,
                                label: MyStrings.thePrice,
                                hint: '',
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
                                            style: context.textTheme.bodySmall),
                                        items: MyStrings.rentList
                                            .map((package) =>
                                                DropdownMenuItem<String>(
                                                  value: package,
                                                  child: Text(package,
                                                      style: context
                                                          .textTheme.bodySmall),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          itemController.selectedTime.value =
                                              value as String;
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
                        //add button
                        MyButton(
                          text: MyStrings.addItems,
                          onPressed: () {
                            if (itemController.selectedTime.value.isEmpty) {
                              MySnackBar.snack(MyStrings.time, '');
                            } else if (itemController.priceOut.text.isEmpty) {
                              MySnackBar.snack(MyStrings.itemPriceOut, '');
                            } else {
                              itemController.addItem(kind: 2);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
