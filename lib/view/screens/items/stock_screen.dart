import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/items/item_controller.dart';
import '../../../controllers/supplires/edit_sup_controller.dart';
import '../../../core/class/pdf_stock.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../widgets/items/my_table_item.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/lottie/my_lottie_empty.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/my_text_field.dart';

class StockScreen extends StatelessWidget {
  StockScreen({super.key});
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
                          Expanded(
                            flex: 1,
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
                                switch (itemController.selectedKind.value) {
                                  case MyStrings.stock:
                                    itemController.searchInList(
                                        searchName: val, kind: 0);
                                    break;
                                  case MyStrings.bikes:
                                    itemController.searchInList(
                                        searchName: val, kind: 4);
                                    break;
                                }
                              },
                              onSubmit: (val) {
                                switch (itemController.selectedKind.value) {
                                  case MyStrings.stock:
                                    itemController.searchInList(
                                        searchName: val, kind: 0);
                                    break;
                                  case MyStrings.bikes:
                                    itemController.searchInList(
                                        searchName: val, kind: 4);
                                    break;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: AppSizes.w02,
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  ' ${MyStrings.itemKind} : ',
                                  style: context.textTheme.bodyMedium,
                                ),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      hint: Text(
                                          itemController.selectedKind.value,
                                          style: context.textTheme.bodySmall),
                                      items: MyStrings.stockSearchList
                                          .map(
                                            (kind) => DropdownMenuItem<String>(
                                              value: kind,
                                              child: Text(kind,
                                                  style: context
                                                      .textTheme.bodySmall),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        itemController.selectedKind.value =
                                            value as String;
                                        switch (value) {
                                          case MyStrings.stockMax:
                                            itemController.searchMinAndMax(
                                                "0", 1);
                                            break;
                                          case MyStrings.stockMin:
                                            itemController.searchMinAndMax(
                                                "0", 0);
                                            break;
                                          case MyStrings.notFoundItems:
                                            itemController.searchAvilableQuant(
                                                '0', 0);
                                            break;
                                          case MyStrings.currentItems:
                                            itemController.searchAvilableQuant(
                                                '0', 1);
                                            break;
                                          case MyStrings.stock:
                                            itemController.searchKind('0');
                                            break;
                                          case MyStrings.notFoundBikes:
                                            itemController.searchAvilableQuant(
                                                '4', 0);
                                            break;
                                          case MyStrings.currentBikes:
                                            itemController.searchAvilableQuant(
                                                '4', 1);
                                            break;
                                          case MyStrings.bikes:
                                            itemController.searchKind('4');
                                            break;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  ' ${MyStrings.supName} : ',
                                  style: context.textTheme.bodyMedium,
                                ),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      hint: Text(
                                          supController.selectedSup.value,
                                          style: context.textTheme.bodySmall),
                                      items: supController.supList
                                          .map(
                                            (sup) => DropdownMenuItem<String>(
                                              value: sup.supName,
                                              child: Text(sup.supName,
                                                  style: context
                                                      .textTheme.bodySmall),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        switch (
                                            itemController.selectedKind.value) {
                                          case MyStrings.stock:
                                            itemController.searchInList(
                                                searchName: value!, kind: 0);
                                            break;
                                          case MyStrings.bikes:
                                            itemController.searchInList(
                                                searchName: value!, kind: 4);
                                            break;
                                        }
                                        supController.selectedSup.value =
                                            value as String;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: MyButton(
                              text: MyStrings.print,
                              onPressed: () {
                                var printItems = itemController.printItems;
                                var items = itemController.searchItemsList;
                                printItems.clear();
                                for (int i = 0; i < items.length; i++) {
                                  printItems.add(
                                    [
                                      itemController.converter(items[i]),
                                      items[i].itemNum.toString(),
                                      items[i].itemName.toString(),
                                    ],
                                  );
                                }
                                // printItems
                                //PrintStock.
                                printStock(
                                  date:
                                      DateFormat.yMEd().format(DateTime.now()),
                                  time: DateFormat.jm().format(DateTime.now()),
                                  lenth: items.length.toString(),
                                  items: printItems,
                                  opreation: itemController.selectedKind.value,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.h02,
                      ),
                      MyTableItem(
                        isHeader: true,
                        isStock: true,
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
                                  supController.selectedSup.value != '') {
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
                                    return MyTableItem(
                                        item: item,
                                        isHeader: false,
                                        isStock: true);
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
    )

        //  Center(
        //   child: Column(
        //     children: [

        //       Row(
        //         children: [
        //           const Spacer(),
        //           Expanded(
        //             flex: 15,
        //             child: MyTableWidget(
        //               isHeader: true,
        //             ),
        //           ),
        //           const Spacer(),
        //         ],
        //       ),
        //       Expanded(
        //         child: ListView(
        //           children: [
        //             Obx(
        //               () {
        //                 if (itemController.isLoading.value) {
        //                   return const MyLottieLoading();
        //                 } else {
        //                   if (itemController.searchItemsList.isEmpty &&
        //                       itemController.name.text.isEmpty) {
        //                     return ListView.builder(
        //                       shrinkWrap: true,
        //                       itemCount: itemController.itemsList.length,
        //                       itemBuilder: (context, index) {
        //                         return Container();
        //                       },
        //                     );
        //                   } else if (itemController.searchItemsList.isEmpty &&
        //                       itemController.name.text.isNotEmpty) {
        //                     return const MyLottieEmpty();
        //                   } else if (itemController.searchItemsList.isEmpty &&
        //                       supController.selectedSup.value.isNotEmpty) {
        //                     return const MyLottieEmpty();
        //                   } else {
        //                     return ListView.separated(
        //                       itemCount: itemController.searchItemsList.length,
        //                       separatorBuilder: (context, index) {
        //                         return const Divider(
        //                           thickness: 2,
        //                         );
        //                       },
        //                       // itemController.isLoading.value

        //                       itemBuilder: (context, index) {
        //                         var item = itemController.searchItemsList[index];
        //                         return Expanded(
        //                           child: Row(
        //                             children: [
        //                               const Spacer(
        //                                 flex: 1,
        //                               ),
        //                               Expanded(
        //                                 flex: 15,
        //                                 child: ListView.builder(
        //                                   shrinkWrap: true,
        //                                   itemBuilder: (context, index) {
        //                                     var item =
        //                                         itemController.itemsList[index];
        //                                     return MyTableWidget(
        //                                       item: item,
        //                                       isHeader: false,
        //                                     );
        //                                   },
        //                                   itemCount:
        //                                       itemController.itemsList.length,
        //                                 ),
        //                               ),
        //                               const Spacer(
        //                                 flex: 1,
        //                               ),
        //                             ],
        //                           ),
        //                         );
        //                       },
        //                     );
        //                   }
        //                 }
        //               },
        //             ),
        //             SizedBox(
        //               height: AppSizes.h05,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
