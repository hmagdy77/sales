import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/items/item_model.dart';

class MyItemWidget extends StatelessWidget {
  const MyItemWidget({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.h05,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w05),
      color: item.isBack == 0
          ? AppColorManger.grey
          : item.isBack == 2
              ? AppColorManger.rentColor
              : item.isBack == 3
                  ? AppColorManger.fixtColor
                  : AppColorManger.bikesColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${MyStrings.itemName} : ${item.itemName}',
            style: context.textTheme.displayLarge,
          ),
          item.isBack == 4
              ? Text(
                  '${MyStrings.bikeNum} : ${item.itemNum}',
                  style: context.textTheme.displayLarge,
                )
              : Text(
                  '${MyStrings.itemNum} : ${item.itemNum}',
                  style: context.textTheme.displayLarge,
                ),
        ],
      ),
    );
  }
}
