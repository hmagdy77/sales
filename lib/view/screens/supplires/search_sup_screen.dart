import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/supplires/edit_sup_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../routes.dart';
import '../../widgets/lottie/my_lottie_empty.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/text_fields/my_text_field.dart';
import '../../widgets/sup/sup_widget.dart';

class SearchSupScreen extends StatelessWidget {
  SearchSupScreen({super.key});
  final EditSupControllerImp editSupController =
      Get.put(EditSupControllerImp());
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
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: editSupController.name,
                          validate: (val) {
                            return validInput(
                              max: 50,
                              min: 0,
                              type: AppStrings.validateAdmin,
                              val: val,
                            );
                          },
                          label: MyStrings.supName,
                          onChange: (val) {
                            editSupController.search(val);
                          },
                          onSubmit: (val) {
                            editSupController.search(val);
                          },
                        ),
                      ),
                      SizedBox(
                        width: AppSizes.w05,
                      ),
                      MyButton(
                        text: MyStrings.addSup,
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.addSupScreen);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.h05,
                  ),
                  Expanded(
                    child: Obx(
                      () {
                        if (editSupController.isLoading.value) {
                          return const MyLottieLoading();
                        } else {
                          if (editSupController.searchSupList.isEmpty &&
                              editSupController.name.text.isNotEmpty) {
                            return const MyLottieEmpty();
                          } else {
                            return ListView.separated(
                              itemCount: editSupController.searchSupList.length,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 2,
                                );
                              },
                              itemBuilder: (context, index) {
                                var sup =
                                    editSupController.searchSupList[index];
                                return GestureDetector(
                                  onTap: () {
                                    editSupController.name.text = sup.supName;
                                    editSupController.tel.text = sup.supTel;
                                    Get.offAndToNamed(
                                      AppRoutes.editSupScreen,
                                      arguments: [sup],
                                    );
                                  },
                                  child: MySupWidget(
                                    sup: sup,
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
