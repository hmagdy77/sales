import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/emp/attend_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../../core/localization/translations.dart';
import '../../../widgets/emp/day_widget.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_empty.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';
import '../../../widgets/text_fields/my_text_field.dart';

class DayViewScreen extends StatelessWidget {
  DayViewScreen({super.key});
  final AttendControllerImp attendController = Get.put(AttendControllerImp());
  final DateTime date = Get.arguments[0];
  final int day = Get.arguments[1];

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
                    content: Column(
                      children: [
                        Text(
                            '${MyStrings.attendAndExitLog} ${MyStrings.forDay} $day ${MyStrings.month} ${DateFormat.MMM("ar").format(date).toString()} ${MyStrings.year} ${DateFormat.y("ar").format(date).toString()}'),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: MyTextField(
                                controller: attendController.searchText,
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
                                  // empController.search(val);
                                  attendController.search(val);
                                },
                                onSubmit: (val) {
                                  // empController.search(val);
                                  attendController.search(val);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: AppSizes.w05,
                                  ),
                                  Text(
                                    '${MyStrings.jopTitle} : ',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  SizedBox(
                                    width: AppSizes.w05,
                                  ),
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        hint: Text(
                                            attendController.selectedJop.value,
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
                                          attendController.selectedJop.value =
                                              value!;
                                          // empController.search(value);
                                          attendController.search(value);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MyButton(
                                text: MyStrings.attendAndExitLog,
                                onPressed: () {
                                  attendController.selectMonth(
                                      context: context, forEmp: false);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        attendController.searchDayList.isEmpty &&
                                attendController.searchText.text.isNotEmpty
                            ? const MyLottieEmpty()
                            : Expanded(
                                child: ListView.separated(
                                  itemCount:
                                      attendController.searchDayList.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 2,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    // DateTime test;
                                    // if (date == DateTime.now()) {
                                    //   test = DateTime.parse(
                                    //       '${date.add(Duration(days: index - 1))}');
                                    // } else {
                                    //   test = DateTime.parse(
                                    //       '${date.add(Duration(days: index))}');
                                    // }
                                    // var day = DateFormat.EEEE("ar").format(test);
                                    return Center(
                                      child: DayWidget(
                                        forEmp: false,
                                        day: attendController
                                            .searchDayList[index],
                                      ),
                                    );
                                  },
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
