import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../controllers/supplires/edit_sup_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../routes.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/colors_details_widget.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_empty.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';
import '../../widgets/works/work_bill.dart';

class SearchBillOutScreen extends StatelessWidget {
  SearchBillOutScreen({super.key});
  final BillOutControllerImp billOutController =
      Get.put(BillOutControllerImp());
  final EditSupControllerImp supController = Get.put(EditSupControllerImp());
  final BillOutItemControllerImp itemsController =
      Get.put(BillOutItemControllerImp());
  final BillOutCartControllerImp cartController =
      Get.put(BillOutCartControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (billOutController.isLoading.value ||
            supController.isLoading.value ||
            itemsController.isLoading.value ||
            cartController.isLoading.value) {
          return const MyLottieLoading();
        } else {
          return Column(
            children: [
              UpperWidget(
                isAdminScreen: false,
                onPressed: () {},
              ),
              Expanded(
                child: MyContainer(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyStrings.editBillsOut,
                        style: context.textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: AppSizes.h05,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller:
                                  billOutController.billOutSearchController,
                              validate: (val) {
                                return validInput(
                                  max: 50,
                                  min: 0,
                                  type: AppStrings.validateAdmin,
                                  val: val,
                                );
                              },
                              label:
                                  '${MyStrings.billNumper}  او  ${MyStrings.agentName}  او  ${MyStrings.agentPhone}  او  ${MyStrings.billTotal}',
                              onChange: (val) {
                                billOutController.search(val);
                              },
                              onSubmit: (val) {
                                billOutController.search(val);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.h02,
                      ),
                      Expanded(
                        child: Obx(
                          () {
                            if (billOutController.isLoading.value) {
                              return const MyLottieLoading();
                            } else {
                              if (billOutController
                                      .billsOutSearchList.isEmpty &&
                                  billOutController.billOutSearchController.text
                                      .isNotEmpty) {
                                return const MyLottieEmpty();
                              } else {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: AppSizes.h25,
                                  ),
                                  itemCount: billOutController
                                      .billsOutSearchList.length,
                                  itemBuilder: (context, index) {
                                    var billOut = billOutController
                                        .billsOutSearchList.reversed
                                        .toList()[index];
                                    if (billOut.billTotal == 0) {
                                      return const ColorsDetailsWidget(
                                        kind: 2,
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () async {
                                          await itemsController.getItemsByIndex(
                                              billOut.billId.toString());
                                          await cartController.addAllToCarts(
                                              itemsController
                                                  .billsOutItemsList);
                                          // agentName
                                          billOutController.agentNameController
                                              .text = billOut.agentName;
                                          // agentPhone
                                          billOutController.agentPhoneController
                                              .text = billOut.agentPhone;
                                          // billDiscount
                                          billOutController
                                                  .discountController.text =
                                              billOut.billDiscount.toString();
                                          billOutController.discountValue
                                              .value = billOut.billDiscount;
                                          // billPaid
                                          billOutController
                                                  .paidController.text =
                                              billOut.billPaid.toString();
                                          billOutController.paidValue.value =
                                              billOut.billPaid;
                                          // billNotes
                                          billOutController.billNotesController
                                              .text = billOut.billNotes;
                                          Get.toNamed(
                                              AppRoutes.editBillOutScreen,
                                              arguments: [billOut]);
                                        },
                                        child: WorkBill(
                                          bill: billOut,
                                        ),
                                        // BillOutItem(bill: billOut),
                                      );
                                    }
                                  },
                                );
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
