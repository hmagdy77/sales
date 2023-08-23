import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/supplires/edit_sup_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../models/items/sup_model.dart';
import '../../../routes.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/dialouge.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/text_fields/my_text_field.dart';

class EditSupScreen extends StatelessWidget {
  EditSupScreen({super.key});

  final Sup mySup = Get.arguments[0];

  final EditSupControllerImp editSupController =
      Get.find<EditSupControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       editSupController.goToMainScreen();
      //     },
      //     icon: const Icon(Icons.arrow_back),
      //   ),
      // ),
      body: Form(
        key: editSupController.editSupKey,
        child: Column(
          children: [
            UpperWidget(
              isAdminScreen: true,
              onPressed: () {
                Get.offAllNamed(AppRoutes.searchSupScreen);
              },
            ),
            Expanded(
              child: MyContainer(
                content: ListView(
                  children: [
                    Text(MyStrings.editSup,
                        style: context.textTheme.titleSmall),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    Text(
                      '${MyStrings.idNumber} : ${mySup.supId}',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: AppSizes.h1,
                    ),
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
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.w1,
                        ),
                        Expanded(
                          child: MyTextField(
                            controller: editSupController.tel,
                            validate: (val) {
                              return validInput(
                                max: 50,
                                min: 0,
                                type: AppStrings.validateAdmin,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyButton(
                          text: MyStrings.editSup,
                          onPressed: () {
                            editSupController.editSup(mySup.supId.toString());
                          },
                        ),
                        MyButton(
                          // minWidth: true,
                          text: MyStrings.deleteSup,
                          onPressed: () {
                            myDialuge(
                                cancel: () {
                                  Get.back();
                                },
                                confirmTitle: MyStrings.confirm,
                                cancelTitle: MyStrings.cancel,
                                confirm: () {
                                  editSupController
                                      .deleteSub(mySup.supId.toString());
                                  Get.offAndToNamed(AppRoutes.splashScreen);
                                },
                                title: MyStrings.deleteSup,
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
        ),
      ),
    );
  }

  Future init() async {
    editSupController.name.text = mySup.supName;
    editSupController.tel.text = mySup.supTel;
  }
}
