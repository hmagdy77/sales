import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/emp/attend_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../../models/emp/day_model.dart';
import '../../../widgets/emp/emp_details.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class ToDayScreen extends StatelessWidget {
  ToDayScreen({super.key});
  final AttendControllerImp attendController = Get.put(AttendControllerImp());
  final Day day = Get.arguments[0];
  // final String empId = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (attendController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            return Column(
              children: [
                UpperWidget(isAdminScreen: false, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: Form(
                      key: attendController.attendKey,
                      child: Column(
                        children: [
                          // for height
                          SizedBox(
                            height: AppSizes.h1,
                          ),
                          EmpDetails(
                            day: day,
                            forEmp: false,
                          ),
                          // for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // rest && discount
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: attendController.restText,
                                  validate: (val) {
                                    return validInput(
                                      max: 8,
                                      min: 0,
                                      type: AppStrings.validateAdminNum,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.empAddRest,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyTextField(
                                  controller: attendController.discountText,
                                  validate: (val) {
                                    return validInput(
                                      max: 8,
                                      min: 0,
                                      type: AppStrings.validateAdminNum,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.empAddDiscount,
                                ),
                              ),
                            ],
                          ),
                          // for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // bouns && payment
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: attendController.bounsText,
                                  validate: (val) {
                                    return validInput(
                                      max: 8,
                                      min: 0,
                                      type: AppStrings.validateAdminNum,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.empAddBouns,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyTextField(
                                  controller: attendController.paymentText,
                                  validate: (val) {
                                    return validInput(
                                      max: 8,
                                      min: 0,
                                      type: AppStrings.validateAdminNum,
                                      val: val,
                                    );
                                  },
                                  label: MyStrings.empAddPayment,
                                ),
                              ),
                            ],
                          ),
                          // for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // notes
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: attendController.notesText,
                                  validate: (val) {},
                                  label: MyStrings.empAddNotes,
                                ),
                              ),
                            ],
                          ),
                          // for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // save button
                          MyButton(
                            text: MyStrings.save,
                            onPressed: () {
                              attendController.edit(day: day);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
