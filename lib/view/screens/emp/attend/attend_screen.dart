import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/emp/attend_controller.dart';
import '../../../../controllers/emp/emp_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../../core/service/services.dart';
import '../../../../routes.dart';
import '../../../widgets/emp/my_table_attend.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_empty.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class AttendScreen extends StatelessWidget {
  AttendScreen({super.key});
  final EmpControllerImp empController = Get.put(EmpControllerImp());
  final AttendControllerImp attendController = Get.put(AttendControllerImp());
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (empController.isLoading.value ||
              attendController.isLoading.value) {
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
                              flex: 4,
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
                                  attendController.search(val);
                                },
                                onSubmit: (val) {
                                  empController.search(val);
                                  attendController.search(val);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: AppSizes.w05,
                                  ),
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
                                        onChanged: (value) {
                                          empController.selectedJop.value =
                                              value!;
                                          empController.search(value);
                                          attendController.search(value);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: MyButton(
                                text: MyStrings.prepareAttend,
                                onPressed: () {
                                  attendController.makeAllAbsence(
                                      empList: empController.empList);
                                  Get.offAllNamed(
                                    AppRoutes.loadingScreen,
                                    arguments: [AppRoutes.attendScreen],
                                  );
                                },
                              ),
                            ),
                            myService.sharedPreferences
                                        .getInt(MyStrings.adminKey) ==
                                    0
                                ? Container()
                                : Expanded(
                                    flex: 2,
                                    child: MyButton(
                                      text: MyStrings.logs,
                                      onPressed: () {
                                        attendController.selectMonth(
                                            forEmp: false, context: context);
                                      },
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: MyTableAttend(
                                isHeader: true,
                                isAbsence: true,
                              ),
                            ),
                            SizedBox(
                              width: AppSizes.w05,
                            ),
                            Expanded(
                              flex: 1,
                              child: MyTableAttend(
                                isHeader: true,
                                isAbsence: false,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: empController.searchEmpList.isEmpty &&
                                        empController.searchText.text.isNotEmpty
                                    ? const MyLottieEmpty()
                                    : ListView.builder(
                                        itemCount: attendController
                                            .searchDayList.length,
                                        itemBuilder: (context, index) {
                                          var day = attendController
                                              .searchDayList[index];
                                          if (day.empAbsence == 0) {
                                            return Container();
                                          } else {
                                            return MyTableAttend(
                                              isHeader: false,
                                              day: day,
                                              isAbsence: true,
                                              empId: day.empId.toString(),
                                            );
                                          }
                                        },
                                      ),
                              ),
                              SizedBox(
                                width: AppSizes.w05,
                              ),
                              Expanded(
                                flex: 1,
                                child: attendController.searchDayList.isEmpty &&
                                        empController.searchText.text.isNotEmpty
                                    ? const MyLottieEmpty()
                                    : ListView.builder(
                                        itemCount: attendController
                                            .searchDayList.length,
                                        itemBuilder: (context, index) {
                                          var day = attendController
                                              .searchDayList[index];
                                          if (day.empAbsence == 1) {
                                            return Container();
                                          } else {
                                            return MyTableAttend(
                                              isHeader: false,
                                              day: day,
                                              isAbsence: false,
                                              empId: day.empId.toString(),
                                            );
                                          }
                                        },
                                      ),
                              ),
                            ],
                          ),
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
