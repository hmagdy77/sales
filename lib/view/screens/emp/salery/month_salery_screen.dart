import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/emp/salery_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../widgets/emp/my_table_salery.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_empty.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class MonthSaleryScreen extends StatelessWidget {
  MonthSaleryScreen({super.key});
  final SaleryControllerImp saleryController = Get.put(SaleryControllerImp());
  final DateTime date = Get.arguments[0];
  final int days = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (saleryController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            return Column(
              children: [
                UpperWidget(isAdminScreen: false, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      children: [
                        Text(
                            '${MyStrings.saleries} ${MyStrings.forMonth} ${DateFormat.MMM("ar").format(date).toString()} ${MyStrings.year} ${DateFormat.y("ar").format(date).toString()}'),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: MyTextField(
                                controller: saleryController.searchText,
                                validate: (val) {
                                  return validInput(
                                    max: 50,
                                    min: 0,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.searchByEmp,
                                onChange: (val) {
                                  saleryController.search(val);
                                },
                                onSubmit: (val) {
                                  saleryController.search(val);
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
                                  hint: Text(saleryController.selectedJop.value,
                                      style: context.textTheme.bodySmall),
                                  items: MyStrings.jopsList
                                      .map(
                                          (package) => DropdownMenuItem<String>(
                                                value: package,
                                                child: Text(package,
                                                    style: context
                                                        .textTheme.bodySmall),
                                              ))
                                      .toList(),
                                  onChanged: (value) {
                                    saleryController.selectedJop.value = value!;
                                    saleryController.search(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        MyTableSalery(
                          isHeader: true,
                        ),
                        Expanded(
                          child: saleryController.searchSaleryList.isEmpty &&
                                  saleryController.searchText.text.isNotEmpty
                              ? const MyLottieEmpty()
                              : ListView.separated(
                                  itemCount:
                                      saleryController.searchSaleryList.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 2,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    var salery = saleryController
                                        .searchSaleryList[index];
                                    return MyTableSalery(
                                      isHeader: false,
                                      salery: salery,
                                      days: days,
                                      pickedDate: date,
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
        },
      ),
    );
  }
}
