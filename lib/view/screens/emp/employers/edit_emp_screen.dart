import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/emp/emp_controller.dart';
import '../../../../core/constants/app_color_manger.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../../models/emp/emp_model.dart';
import '../../../../routes.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class EditEmpScreen extends StatelessWidget {
  EditEmpScreen({super.key});

  final Emp emp = Get.arguments[0];

  final EmpControllerImp empController = Get.find<EmpControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: empController.empKey,
        child: Obx(
          () {
            if (empController.isLoading.value) {
              return const MyLottieLoading();
            } else {
              return ListView(
                children: [
                  UpperWidget(
                    isAdminScreen: false,
                    onPressed: () {},
                  ),
                  MyContainer(
                    content: Column(
                      children: [
                        Text(
                          MyStrings.editEmp,
                          style: context.textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller: empController.nameText,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.empName,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Expanded(
                              child: MyTextField(
                                controller: empController.natIdText,
                                validate: (val) {
                                  return validInput(
                                    max: 14,
                                    min: 14,
                                    type: AppStrings.validateAdminNum,
                                    val: val,
                                  );
                                },
                                label: MyStrings.empNationalId,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller: empController.tel1Text,
                                validate: (val) {
                                  return validInput(
                                    max: 11,
                                    min: 8,
                                    type: AppStrings.validateAdminNum,
                                    val: val,
                                  );
                                },
                                label: MyStrings.empTel,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Expanded(
                              child: MyTextField(
                                controller: empController.tel2Text,
                                validate: (val) {
                                  return validInput(
                                    max: 11,
                                    min: 11,
                                    type: AppStrings.validateAdminNum,
                                    val: val,
                                  );
                                },
                                label: MyStrings.empWts,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller: empController.saleryText,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdminNum,
                                    val: val,
                                  );
                                },
                                label: MyStrings.empSalery,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Expanded(
                              child: MyTextField(
                                controller: empController.hoursText,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdminNum,
                                    val: val,
                                  );
                                },
                                label: MyStrings.empNumperOfHours,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller: empController.addressText,
                                validate: (val) {
                                  return validInput(
                                    max: 150,
                                    min: 0,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.empAddress,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    '${MyStrings.jopTitle} : ',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        hint: Text(
                                            empController.selectedJop.value,
                                            style: context.textTheme.bodySmall),
                                        items: MyStrings.jopsList
                                            .map((package) =>
                                                DropdownMenuItem<String>(
                                                  value: package,
                                                  child: Text(package,
                                                      style: context
                                                          .textTheme.bodySmall),
                                                ))
                                            .toList(),
                                        value: emp.empJop,
                                        onChanged: (value) {
                                          empController.selectedJop.value =
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
                        SizedBox(
                          height: AppSizes.h03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      empController.getDate(
                                        context: context,
                                        birth: true,
                                        end: false,
                                        start: false,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.perm_contact_calendar,
                                      color: AppColorManger.primary,
                                      size: AppSizes.w05,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppSizes.w02,
                                  ),
                                  Text(
                                    '${MyStrings.dateOfBirth} : ${empController.datebirth.value}',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      empController.getDate(
                                        context: context,
                                        birth: false,
                                        end: false,
                                        start: true,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.perm_contact_calendar,
                                      color: AppColorManger.primary,
                                      size: AppSizes.w05,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppSizes.w02,
                                  ),
                                  Text(
                                    '${MyStrings.dateOfStartWork} : ${empController.startWork.value}',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      empController.getDate(
                                        context: context,
                                        birth: false,
                                        end: true,
                                        start: false,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.perm_contact_calendar,
                                      color: AppColorManger.primary,
                                      size: AppSizes.w05,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppSizes.w02,
                                  ),
                                  Text(
                                    '${MyStrings.dateOfEndtWork} : ${empController.endWork.value}',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h03,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            MyButton(
                              text: MyStrings.edit,
                              onPressed: () {
                                if (empController.selectedJop.isEmpty) {
                                  MySnackBar.snack(MyStrings.mustChosejop, '');
                                } else {
                                  if (empController.endWork.value ==
                                      MyStrings.stillInJop) {
                                    empController.editEmp(
                                        empId: emp.empId.toString(),
                                        isStopped: 0);
                                  } else {
                                    empController.editEmp(
                                        empId: emp.empId.toString(),
                                        isStopped: 1);
                                  }
                                }
                              },
                            ),
                            const Spacer(),
                            MyButton(
                              text: MyStrings.deleteEmp,
                              onPressed: () {
                                empController.deleteEmp(
                                  empId: emp.empId.toString(),
                                );
                              },
                            ),
                            const Spacer(),
                            MyButton(
                              text: MyStrings.back,
                              onPressed: () {
                                Get.offAllNamed(AppRoutes.searchEmpScreen);
                              },
                            ),
                            const Spacer(),
                          ],
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
