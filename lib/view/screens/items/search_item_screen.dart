import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/edit_sup_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../../routes.dart';
import '../../widgets/items/item_widget.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_empty.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';

class SearchItems extends StatelessWidget {
  SearchItems({super.key});
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final EditSupControllerImp supController = Get.put(EditSupControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(
      () {
        if (itemController.isLoading.value || supController.isLoading.value) {
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
                    children: [
                      Row(
                        children: [
                          // MyTextField
                          Expanded(
                            flex: 2,
                            child: MyTextField(
                              controller: itemController.name,
                              validate: (val) {
                                return validInput(
                                  max: 50,
                                  min: 0,
                                  type: AppStrings.validateAdmin,
                                  val: val,
                                );
                              },
                              label: MyStrings.itemName,
                              onChange: (val) {
                                itemController.searchInList(
                                    searchName: val,
                                    kind: itemController.usedKind.value);
                              },
                              onSubmit: (val) {
                                itemController.searchInList(
                                    searchName: val,
                                    kind: itemController.usedKind.value);
                              },
                            ),
                          ),
                          //for width
                          SizedBox(
                            width: AppSizes.w02,
                          ),
                          Text(
                            ' ${MyStrings.supName} : ',
                            style: context.textTheme.bodyMedium,
                          ),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(supController.selectedSup.value,
                                    style: context.textTheme.bodySmall),
                                items: supController.supList
                                    .map((sup) => DropdownMenuItem<String>(
                                          value: sup.supName,
                                          child: Text(sup.supName,
                                              style:
                                                  context.textTheme.bodySmall),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  itemController.searchInList(
                                      searchName: value.toString(),
                                      kind: itemController.usedKind.value);
                                  supController.selectedSup.value =
                                      value as String;
                                },
                              ),
                            ),
                          ),
                          Text(
                            '${MyStrings.itemKind} : ',
                            style: context.textTheme.bodyMedium,
                          ),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(itemController.selectedKind.value,
                                    style: context.textTheme.bodySmall),
                                items: MyStrings.billOutkindList
                                    .map((package) => DropdownMenuItem<String>(
                                          value: package,
                                          child: Text(package,
                                              style:
                                                  context.textTheme.bodySmall),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  itemController.selectedKind.value =
                                      value.toString();
                                  switch (value) {
                                    case MyStrings.stock:
                                      itemController.searchKind("0");
                                      itemController.usedKind.value = 0;
                                      break;
                                    case MyStrings.rent:
                                      itemController.searchKind("2");
                                      itemController.usedKind.value = 2;
                                      break;
                                    case MyStrings.fix:
                                      itemController.searchKind("3");
                                      itemController.usedKind.value = 3;
                                      break;
                                    case MyStrings.bikes:
                                      itemController.searchKind("4");
                                      itemController.usedKind.value = 4;
                                      break;
                                  }
                                },
                              ),
                            ),
                          ),
                          Text(
                            '${MyStrings.addItems} : ',
                            style: context.textTheme.bodyMedium,
                          ),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(itemController.selectedKind.value,
                                    style: context.textTheme.bodySmall),
                                items: MyStrings.billOutkindList
                                    .map((package) => DropdownMenuItem<String>(
                                          value: package,
                                          child: Text(package,
                                              style:
                                                  context.textTheme.bodySmall),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  switch (value) {
                                    case MyStrings.stock:
                                      Get.offAllNamed(
                                          AppRoutes.addStockItemsScreen);
                                      break;
                                    case MyStrings.bikes:
                                      Get.offAllNamed(
                                          AppRoutes.addBikeItemScreen);
                                      break;
                                    case MyStrings.rent:
                                      Get.offAllNamed(
                                          AppRoutes.addRentItemScreen);
                                      break;
                                    case MyStrings.fix:
                                      Get.offAllNamed(
                                          AppRoutes.addFixItemScreen);
                                      break;
                                  }
                                },
                              ),
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
                            if (itemController.isLoading.value) {
                              return const MyLottieLoading();
                            } else {
                              if (itemController.searchItemsList.isEmpty &&
                                  itemController.name.text.isEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: itemController.itemsList.length,
                                  itemBuilder: (context, index) {
                                    return Container();
                                  },
                                );
                              } else if (itemController
                                      .searchItemsList.isEmpty &&
                                  itemController.name.text.isNotEmpty) {
                                return const MyLottieEmpty();
                              } else if (itemController
                                      .searchItemsList.isEmpty &&
                                  supController.selectedSup.value.isNotEmpty) {
                                return const MyLottieEmpty();
                              } else {
                                return ListView.separated(
                                  itemCount:
                                      itemController.searchItemsList.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 2,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    var item =
                                        itemController.searchItemsList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        itemController.name.text =
                                            item.itemName;
                                        itemController.num.text = item.itemNum;
                                        itemController.priceIn.text =
                                            item.itemPriceIn.toString();
                                        itemController.priceOut.text =
                                            item.itemPriceOut.toString();
                                        itemController.numberOfpices.text =
                                            item.itemPiec.toString();
                                        itemController.min.text =
                                            item.itemMin.toString();
                                        itemController.max.text =
                                            item.itemMax.toString();
                                        //bikes
                                        itemController.bikeColor.text =
                                            item.bikeColor.toString();
                                        itemController.bikeKind.text =
                                            item.bikeKind.toString();
                                        itemController.bikeModel.text =
                                            item.bikeModel.toString();
                                        item.isBack == 0
                                            ? Get.offAndToNamed(
                                                AppRoutes.editItemScreen,
                                                arguments: [item, 0],
                                              )
                                            : item.isBack == 2
                                                ? Get.offAndToNamed(
                                                    AppRoutes.editItemScreen,
                                                    arguments: [item, 2],
                                                  )
                                                : item.isBack == 3
                                                    ? Get.offAndToNamed(
                                                        AppRoutes
                                                            .editItemScreen,
                                                        arguments: [item, 3],
                                                      )
                                                    : Get.offAndToNamed(
                                                        AppRoutes
                                                            .editItemScreen,
                                                        arguments: [item, 4],
                                                      );
                                      },
                                      child: MyItemWidget(
                                        item: item,
                                      ),
                                    );
                                  },
                                );
                              }
                            }
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
    ));
  }
}
