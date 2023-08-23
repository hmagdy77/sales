import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/items/item_model.dart';

class BillItem extends StatelessWidget {
  const BillItem({super.key, required this.item, required this.isBack});
  final Item item;
  final int isBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.w01,
      ),
      padding: EdgeInsets.only(top: AppSizes.w01, right: AppSizes.w01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isBack == 0 ? AppColorManger.grey : AppColorManger.primary,
      ),
      width: AppSizes.w25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${MyStrings.itemName} : ${item.itemName}',
            style: Get.textTheme.displayLarge,
            textAlign: TextAlign.start,
          ),
          Text(
            '${MyStrings.itemNum} : ${item.itemNum}',
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            '${MyStrings.theNumber} : ${item.itemCount}',
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            '${MyStrings.itemPriceOut} : ${item.itemPriceOut}',
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            '${MyStrings.total} : ${(item.itemCount * item.itemPriceOut)}',
            style: Get.textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
