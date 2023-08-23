import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/emp/attend_controller.dart';
import '../../../../core/constants/app_color_manger.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../routes.dart';
import '../../../widgets/menus/upper_widget.dart';
import '../../../widgets/public/my_container.dart';
import '../../../widgets/lottie/my_lottie_loading.dart';

class MonthViewScreen extends StatelessWidget {
  MonthViewScreen({super.key});
  final AttendControllerImp attendController = Get.put(AttendControllerImp());
  final DateTime date = Get.arguments[0];
  final int days = Get.arguments[1];

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
                            '${MyStrings.attendAndExitLog} ${MyStrings.forMonth} ${DateFormat.MMM("ar").format(date).toString()} ${MyStrings.year} ${DateFormat.y("ar").format(date).toString()}'),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: days,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: AppSizes.h25,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  attendController.toDayList.clear();
                                  attendController.getAttendToday(
                                      date: attendController.dayFormater.format(
                                          date.add(Duration(days: index))));
                                  Get.toNamed(AppRoutes.dayViewScreen,
                                      arguments: [date, index + 1]);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(AppSizes.h01),
                                  decoration: BoxDecoration(
                                      color: AppColorManger.grey,
                                      borderRadius:
                                          BorderRadius.circular(AppSizes.h01)),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: context.textTheme.titleLarge,
                                    ),
                                  ),
                                ),
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
