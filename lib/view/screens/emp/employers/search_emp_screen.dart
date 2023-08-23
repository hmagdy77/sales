import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/emp/emp_controller.dart';
import '../../../../controllers/emp/salery_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../../routes.dart';
import '../../../widgets/emp/my_table_emp.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_empty.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class SearchEmpScreen extends StatelessWidget {
  SearchEmpScreen({super.key});
  final EmpControllerImp empController = Get.put(EmpControllerImp());
  final SaleryControllerImp saleryController = Get.put(SaleryControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (empController.isLoading.value) {
        return const MyLottieLoading();
      } else {
        return Column(
          children: [
            UpperWidget(isAdminScreen: false, onPressed: () {}),
            Expanded(
              child: MyContainer(
                content: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: MyTextField(
                            controller: empController.searchText,
                            validate: (val) {
                              return validInput(
                                max: 50,
                                min: 0,
                                type: AppStrings.validateAdmin,
                                val: val,
                              );
                            },
                            label: MyStrings.search,
                            onChange: (val) {
                              empController.search(val);
                            },
                            onSubmit: (val) {
                              empController.search(val);
                            },
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.w02,
                        ),
                        Text(
                          '${MyStrings.jopTitle} : ',
                          style: context.textTheme.bodyMedium,
                        ),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(empController.selectedJop.value,
                                  style: context.textTheme.bodySmall),
                              items: MyStrings.jopsList
                                  .map((package) => DropdownMenuItem<String>(
                                        value: package,
                                        child: Text(package,
                                            style: context.textTheme.bodySmall),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                empController.selectedJop.value = value!;
                                empController.search(value);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: MyButton(
                            text: MyStrings.addEmp,
                            onPressed: () {
                              Get.offAllNamed(AppRoutes.addEmpScreen);
                            },
                          ),
                        ),
                        Expanded(
                          child: MyButton(
                            text: MyStrings.saleries,
                            onPressed: () {
                              saleryController.selectMonth(
                                  context: context, forEmp: false);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    MyTableEmp(
                      isHeader: true,
                    ),
                    Expanded(
                      child: empController.searchEmpList.isEmpty &&
                              empController.searchText.text.isNotEmpty
                          ? const MyLottieEmpty()
                          : ListView.separated(
                              itemCount: empController.searchEmpList.length,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 2,
                                );
                              },
                              itemBuilder: (context, index) {
                                var emp = empController.searchEmpList[index];
                                return MyTableEmp(
                                  isHeader: false,
                                  emp: emp,
                                );
                              },
                            ),
                    ),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }
    }));
  }
}
