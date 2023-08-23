import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/supplires/add_sup_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';

class AddSupScreen extends StatelessWidget {
  AddSupScreen({super.key});
  final AddSupControllerImp addSupController = Get.put(AddSupControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: addSupController.addSupKey,
        child: Obx(
          () {
            if (addSupController.isLoading.value) {
              return const MyLottieLoading();
            } else {
              return Column(
                children: [
                  UpperWidget(isAdminScreen: false, onPressed: () {}),
                  MyContainer(
                    content: Column(
                      children: [
                        Text(
                          MyStrings.addSup,
                          style: context.textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller: addSupController.name,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.supName,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Expanded(
                              child: MyTextField(
                                controller: addSupController.tel,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdminNum,
                                    val: val,
                                  );
                                },
                                label: MyStrings.supTel,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        MyButton(
                          // minWidth: true,
                          text: MyStrings.addSup,
                          onPressed: () {
                            addSupController.addSup();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
