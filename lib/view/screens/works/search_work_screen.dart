import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/works/work_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../core/service/services.dart';
import '../../../routes.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_empty.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';
import '../../widgets/works/current_work_item.dart';
import '../../widgets/works/my_table_work.dart';

class SearchWorkScreen extends StatelessWidget {
  SearchWorkScreen({super.key});
  final WorkControllerImp workController = Get.put(WorkControllerImp());
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());
  final BillOutCartControllerImp cartController =
      Get.put(BillOutCartControllerImp());
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(isAdminScreen: false, onPressed: () {}),
          Expanded(
            child: MyContainer(
              content: Obx(
                () {
                  if (workController.isLoading.value) {
                    return const MyLottieLoading();
                  } else {
                    var work = workController.worksListReversed[0];
                    return Column(
                      children: [
                        //current work
                        CurentWorkItem(
                          work: work, // workController.lastWork[0],
                        ),
                        myService.sharedPreferences
                                    .getInt(MyStrings.adminKey) ==
                                1
                            ? Expanded(
                                child: Column(
                                  children: [
                                    //for height
                                    SizedBox(
                                      height: AppSizes.h02,
                                    ),
                                    //search TextField
                                    MyTextField(
                                      controller: workController.workSearch,
                                      validate: (val) {
                                        return validInput(
                                          max: 50,
                                          min: 0,
                                          type: AppStrings.validateAdmin,
                                          val: val,
                                        );
                                      },
                                      label: MyStrings.cashierName,
                                      onChange: (val) {
                                        workController.search(val);
                                      },
                                      onSubmit: (val) {
                                        workController.search(val);
                                      },
                                    ),
                                    //for height
                                    SizedBox(
                                      height: AppSizes.h02,
                                    ),
                                    //works items
                                    MyTableWork(
                                      isHeader: true,
                                    ),
                                    Expanded(
                                      child: workController
                                                  .worksSearchList.isEmpty &&
                                              workController
                                                  .workSearch.text.isNotEmpty
                                          ? const MyLottieEmpty()
                                          : ListView.separated(
                                              itemCount: workController
                                                  .worksSearchList.length,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Divider(
                                                  thickness: 2,
                                                );
                                              },
                                              itemBuilder: (context, index) {
                                                var work = workController
                                                    .worksSearchList[index];
                                                return GestureDetector(
                                                  onTap: () async {
                                                    await billOutController
                                                        .getItemsByIndex(work
                                                            .workId
                                                            .toString());
                                                    await cartController
                                                        .addAllBillsToCarts(
                                                            billOutController
                                                                .workBillsList);
                                                    Get.toNamed(
                                                        AppRoutes
                                                            .workDetailsScreen,
                                                        arguments: [work]);
                                                  },
                                                  child: MyTableWork(
                                                    work: work,
                                                    isHeader: false,
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
