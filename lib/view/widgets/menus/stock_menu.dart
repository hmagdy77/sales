import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../routes.dart';

class StockMenu extends StatelessWidget {
  StockMenu({super.key});
  final List bodyItems = [
    // MyStrings.addItems,
    MyStrings.items,
    MyStrings.showItems,
    MyStrings.sup,
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          MyStrings.stock,
          style: context.textTheme.displayLarge,
        ),
        items: bodyItems
            .map(
              (sup) => DropdownMenuItem<String>(
                value: sup,
                child: Text(sup, style: context.textTheme.displayLarge),
              ),
            )
            .toList(),
        onChanged: (value) {
          switch (value) {
            // case MyStrings.addItems:
            //   Get.offAllNamed(AppRoutes.addItemsScreen);
            //   break;
            case MyStrings.items:
              Get.offAllNamed(AppRoutes.searchItemScreen);
              break;
            case MyStrings.showItems:
              Get.offAllNamed(AppRoutes.stockScreen);
              break;
            case MyStrings.sup:
              Get.offAllNamed(AppRoutes.searchSupScreen);
              break;
            default:
              Get.offAllNamed(AppRoutes.mainScreen);
          }
        },
      ),
    );
  }
}
