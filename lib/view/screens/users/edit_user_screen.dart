import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/users/edit_user_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../models/auth/user_model.dart';
import '../../../routes.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/dialouge.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';

class EditUserScreen extends StatelessWidget {
  EditUserScreen({super.key});

  final User user = Get.arguments[0];

  final EdituserControllerImp editUserController =
      Get.find<EdituserControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: editUserController.editUserKey,
      child: Obx(() {
        if (editUserController.isLoading.value) {
          return const Center(
            child: MyLottieLoading(),
          );
        } else {
          return Column(
            children: [
              UpperWidget(
                isAdminScreen: true,
                onPressed: () {
                  Get.offAllNamed(AppRoutes.searchUserScreen);
                },
              ),
              Expanded(
                child: MyContainer(
                  content: ListView(
                    children: [
                      //edit users label
                      Text(
                        MyStrings.editUsers,
                        style: context.textTheme.titleSmall,
                      ),
                      //for height
                      SizedBox(
                        height: AppSizes.h05,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${MyStrings.idNumber} : ${user.userId}',
                            style: context.textTheme.bodyLarge,
                          ),
                          user.userAdmin == 1
                              ? Text(
                                  '${MyStrings.primison} : ${MyStrings.manger}',
                                  style: context.textTheme.bodyLarge,
                                )
                              : user.userAdmin == 1
                                  ? Text(
                                      '${MyStrings.primison} : ${MyStrings.supManger}',
                                      style: context.textTheme.bodyLarge,
                                    )
                                  : Text(
                                      '${MyStrings.primison} : ${MyStrings.employ}',
                                      style: context.textTheme.bodyLarge,
                                    ),
                        ],
                      ),
                      //for height
                      SizedBox(
                        height: AppSizes.h05,
                      ),

                      //textfields
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller: editUserController.userName,
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
                              controller: editUserController.password,
                              validate: (val) {
                                return validInput(
                                  max: 50,
                                  min: 0,
                                  type: AppStrings.validateAdmin,
                                  val: val,
                                );
                              },
                              label: MyStrings.password,
                            ),
                          ),
                        ],
                      ),
                      //for height
                      SizedBox(
                        height: AppSizes.h05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyButton(
                            text: MyStrings.editUser,
                            onPressed: () {
                              editUserController
                                  .editUser(user.userId.toString());
                            },
                          ),
                          MyButton(
                            // minWidth: true,
                            text: MyStrings.deleteUser,
                            onPressed: () {
                              myDialuge(
                                  cancel: () {
                                    Get.back();
                                  },
                                  confirmTitle: MyStrings.confirm,
                                  cancelTitle: MyStrings.cancel,
                                  confirm: () {
                                    editUserController
                                        .deleteUser(user.userId.toString());
                                  },
                                  title: MyStrings.deleteUser,
                                  middleText: '');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    ));
  }
}
