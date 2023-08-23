import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class AddFixItemScreen extends StatelessWidget {
  AddFixItemScreen({super.key});
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
                        Text('${MyStrings.addItems} ${MyStrings.fix}',
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
                        //priceIn textfield and priceout textfield
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
                            const Spacer(),
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
                            if (itemController.priceOut.text.isEmpty) {
                              MySnackBar.snack(MyStrings.itemPriceOut, '');
                            }
                            itemController.addItem(kind: 3);
                          },
                        )
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
