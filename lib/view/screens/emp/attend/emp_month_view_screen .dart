import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/emp/attend_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../models/emp/emp_model.dart';
import '../../../widgets/emp/day_widget.dart';
import '../../../widgets/emp/emp_details.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_button.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';

class EmpMonthViewScreen extends StatelessWidget {
  EmpMonthViewScreen({super.key});
  final AttendControllerImp attendController = Get.put(AttendControllerImp());
  final DateTime date = Get.arguments[0];
  final Emp emp = Get.arguments[1];

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
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                                '${MyStrings.attendAndExitLog} ${MyStrings.month} ${DateFormat.MMM("ar").format(date).toString()} ${MyStrings.year} ${DateFormat.y("ar").format(date).toString()}'),
                            const Spacer(),
                            MyButton(
                              text: MyStrings.attendAndExitLog,
                              onPressed: () {
                                attendController.selectMonth(
                                    context: context, forEmp: false);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        EmpDetails(
                          forEmp: true,
                          emp: emp,
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount:
                                attendController.attendLogForEmpList.length,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: AppSizes.w35,
                            ),
                            itemBuilder: (context, index) {
                              return Center(
                                child: DayWidget(
                                  forEmp: true,
                                  day: attendController
                                      .attendLogForEmpList[index],
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
