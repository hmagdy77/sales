import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/users/edit_user_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../routes.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_empty.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';
import '../../widgets/users/user_widget.dart';

class SearchUserScreen extends StatelessWidget {
  SearchUserScreen({super.key});
  final EdituserControllerImp editUserController =
      Get.put(EdituserControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(isAdminScreen: false, onPressed: () {}),
          Expanded(
            child: MyContainer(
              content: Column(
                children: [
                  MyTextField(
                    controller: editUserController.searchController,
                    validate: (val) {
                      return validInput(
                        max: 50,
                        min: 0,
                        type: AppStrings.validateAdmin,
                        val: val,
                      );
                    },
                    label: MyStrings.userName,
                    onChange: (val) {
                      editUserController.search(val);
                    },
                    onSubmit: (val) {
                      editUserController.search(val);
                    },
                  ),
                  SizedBox(
                    height: AppSizes.h05,
                  ),
                  Expanded(
                    child: Obx(
                      () {
                        if (editUserController.isLoading.value) {
                          return const MyLottieLoading();
                        } else {
                          if (editUserController.searchUsersList.isEmpty &&
                              editUserController
                                  .searchController.text.isNotEmpty) {
                            return const MyLottieEmpty();
                          } else {
                            return ListView.separated(
                              itemCount:
                                  editUserController.searchUsersList.length,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 2,
                                );
                              },
                              itemBuilder: (context, index) {
                                var user =
                                    editUserController.searchUsersList[index];
                                return GestureDetector(
                                  onTap: () {
                                    editUserController.userName.text =
                                        user.userName;
                                    editUserController.password.text =
                                        user.userPassword;
                                    Get.offAndToNamed(
                                      AppRoutes.editUserScreen,
                                      arguments: [user],
                                    );
                                  },
                                  child: UserWidget(
                                    user: user,
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
