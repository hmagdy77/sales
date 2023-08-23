import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/users/add_user_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({super.key});
  final AddUserControllerImp userController = Get.put(AddUserControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: userController.addUserKey,
        child: Obx(
          () {
            if (userController.isLoading.value) {
              return const MyLottieLoading();
            } else {
              return Column(
                children: [
                  UpperWidget(isAdminScreen: false, onPressed: () {}),
                  MyContainer(
                    content: Column(
                      children: [
                        Text(
                          MyStrings.addUser,
                          style: context.textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller: userController.userName,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.userName,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Expanded(
                              child: MyTextField(
                                controller: userController.password,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdminNum,
                                    val: val,
                                  );
                                },
                                label: MyStrings.password,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              MyStrings.jopTitle,
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: AppSizes.w05,
                            ),
                            Expanded(
                              // width: AppSizes.w5,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(userController.selectedJop.value,
                                      style: context.textTheme.bodySmall),
                                  items: MyStrings.primsions
                                      .map((jop) => DropdownMenuItem<String>(
                                            value: jop,
                                            child: Text(jop,
                                                style: context
                                                    .textTheme.bodySmall),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    userController.selectedJop.value =
                                        value.toString();
                                    switch (value) {
                                      case MyStrings.employ:
                                        userController.jopKind.value = 0;
                                        break;
                                      case MyStrings.manger:
                                        userController.jopKind.value = 1;
                                        break;
                                      case MyStrings.supManger:
                                        userController.jopKind.value = 2;
                                        break;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        MyButton(
                          // minWidth: true,
                          text: MyStrings.add,
                          onPressed: () {
                            if (userController.selectedJop.isEmpty) {
                              MySnackBar.snack(MyStrings.mustChoseJop, '');
                            } else {
                              userController.addUser(
                                  userController.jopKind.value.toString());
                            }
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
