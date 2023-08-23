import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../routes.dart';

class SupMenu extends StatelessWidget {
  SupMenu({super.key});

  final List bodyItems = [
    MyStrings.employersList,
    MyStrings.attendAndExit,
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          MyStrings.employers,
          style: context.textTheme.displayLarge,
        ),
        items: bodyItems
            .map((sup) => DropdownMenuItem<String>(
                  value: sup,
                  child: Text(sup, style: context.textTheme.displayLarge),
                ))
            .toList(),
        onChanged: (value) {
          switch (value) {
            case MyStrings.employersList:
              Get.offAllNamed(AppRoutes.searchEmpScreen);
              break;

            case MyStrings.attendAndExit:
              Get.offAllNamed(AppRoutes.attendScreen);
              break;
            default:
              Get.offAllNamed(AppRoutes.mainScreen);
          }
        },
      ),
    );
  }
}

  //  var start = DateTime.parse('2023-04-22 06:10');
  //                       final end = DateTime.now();
  //                       final difference = start.difference(end);
  //                       print(difference.inMinutes);