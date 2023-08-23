import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/works/work_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../models/works/work_model.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_number_field.dart';
import '../../widgets/text_fields/my_text_field.dart';

class AddPaymentScreen extends StatelessWidget {
  AddPaymentScreen({super.key});
  final WorkControllerImp workController = Get.put(WorkControllerImp());
  final Work work = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (workController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            return Form(
              key: workController.workKey,
              child: Column(
                children: [
                  UpperWidget(isAdminScreen: false, onPressed: () {}),
                  MyContainer(
                    content: Column(
                      children: [
                        Text(MyStrings.addPayment,
                            style: context.textTheme.titleSmall),
                        //for height
                        SizedBox(
                          height: AppSizes.w1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${MyStrings.currentWork} : ${work.workId}',
                              style: context.textTheme.titleSmall,
                            ),
                            Text(
                              '${MyStrings.cashierName} : ${work.workName}',
                              style: context.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.w1,
                        ),

                        //kind textfield and value textfield
                        Row(
                          children: [
                            //name textfield
                            Expanded(
                              child: MyTextField(
                                controller: workController.workNotes,
                                validate: (val) {
                                  return validInput(
                                    max: 80,
                                    min: 1,
                                    type: AppStrings.validateAdmin,
                                    val: val,
                                  );
                                },
                                label: MyStrings.kindPayment,
                              ),
                            ),
                            //for width
                            SizedBox(
                              width: AppSizes.w1,
                            ),
                            //textfields
                            Expanded(
                              child: MyNumberField(
                                controller: workController.workPayment,
                                label: MyStrings.billPayment,
                                onSubmit: (payment) {
                                  if (workController.workNotes.text.isEmpty ||
                                      payment.isEmpty) {
                                    MySnackBar.snack(
                                        MyStrings.pleaseEnterWantedValues, "");
                                  } else if (work.workTotal == 0) {
                                    MySnackBar.snack(MyStrings.noSales, "");
                                  } else {
                                    workController.updateWorkPayment(
                                      workId: work.workId.toString(),
                                      total: workController.workPayment.text,
                                    );
                                    // workController.updateTotal(
                                    // total: -(double.parse(
                                    //     workController.workPayment.text)),
                                    //   workId: work.workId.toString(),
                                    // );
                                    workController.updateTotal(
                                      workId: work.workId.toString(),
                                      total: -(double.parse(
                                          workController.workPayment.text)),
                                    );
                                    workController.addWorkPayment(
                                      workId: work.workId.toString(),
                                      workName: work.workName,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        //for height
                        SizedBox(
                          height: AppSizes.h1,
                        ),
                        //add button
                        MyButton(
                          // minWidth: true,
                          text: MyStrings.addPayment,
                          onPressed: () {
                            if (workController.workNotes.text.isEmpty ||
                                workController.workPayment.text.isEmpty) {
                              MySnackBar.snack(
                                  MyStrings.pleaseEnterWantedValues, "");
                            } else if (work.workTotal == 0) {
                              MySnackBar.snack(MyStrings.noSales, "");
                            } else {
                              workController.updateWorkPayment(
                                workId: work.workId.toString(),
                                total: workController.workPayment.text,
                              );
                              workController.addWorkPayment(
                                workId: work.workId.toString(),
                                workName: work.workName,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
