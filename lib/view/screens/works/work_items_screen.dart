import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/works/work_controller.dart';
import '../../../controllers/works/work_item_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/items/item_model.dart';
import '../../../models/works/work_model.dart';
import '../../widgets/items/work_item.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';

class WorkItemsScreen extends StatelessWidget {
  WorkItemsScreen({super.key});

  final Work work = Get.arguments[0];
  final WorkControllerImp workController = Get.find<WorkControllerImp>();
  final WorkItemControllerImp workItemsController =
      Get.find<WorkItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (workController.isLoading.value ||
              workItemsController.isLoading.value) {
            return const Center(
              child: MyLottieLoading(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UpperWidget(isAdminScreen: false, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      children: [
                        //work id and date and numberOfitems
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  ' ${MyStrings.workeNum} : ${work.workId.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                SizedBox(
                                  height: AppSizes.h04,
                                ),
                                Text(
                                  ' ${MyStrings.numberOfitems} : ${workItemsController.workItemsList.length.toString()}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${MyStrings.salesWork} : ${work.workTotal}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                SizedBox(
                                  height: AppSizes.h04,
                                ),
                                Text(
                                  '${MyStrings.billDate} : ${DateFormat.yMEd().format(work.workStart)}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${MyStrings.cashierName} : ${work.workName}',
                                  style: context.textTheme.bodyMedium,
                                ),
                                SizedBox(
                                  height: AppSizes.h04,
                                ),
                                work.workClosed == 1
                                    ? Text(
                                        '${MyStrings.endWorke} :  ${DateFormat.yMMMEd().format(work.workEnd)}  ${DateFormat.jm().format(work.workEnd)}',
                                        style: context.textTheme.bodyMedium,
                                      )
                                    : Text(
                                        MyStrings.currentWork,
                                        style: context.textTheme.bodyMedium,
                                      ),
                              ],
                            ),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h04,
                        ),
                        //cart items
                        WorkItemTable(
                          isHeader: true,
                          index: 1,
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h02,
                        ),
                        Expanded(
                          flex: 3,
                          child: workItemsController.workItemsList.isEmpty
                              ? Text(
                                  MyStrings.emptyList,
                                  style: context.textTheme.titleSmall,
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemBuilder: (context, index) {
                                            Item item = workItemsController
                                                .workItemsList[index];
                                            if (item.itemCount == 0) {
                                              return Container();
                                            } else {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: AppSizes.h02),
                                                child: WorkItemTable(
                                                  item: item,
                                                  isHeader: false,
                                                  index: index,
                                                ),
                                              );
                                            }
                                          },
                                          itemCount: workItemsController
                                              .workItemsList.length),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
