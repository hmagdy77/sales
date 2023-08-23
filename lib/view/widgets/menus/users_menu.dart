import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/works/work_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes.dart';

class UsersMenu extends StatelessWidget {
  UsersMenu({super.key});
  final WorkControllerImp workController = Get.put(WorkControllerImp());
  final List bodyItems = [
    MyStrings.addUser,
    MyStrings.editUsers,
    MyStrings.workes,
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          MyStrings.settings,
          style: context.textTheme.displayLarge,
        ),
        items: bodyItems
            .map((user) => DropdownMenuItem<String>(
                  value: user,
                  child: Text(user, style: context.textTheme.displayLarge),
                ))
            .toList(),
        onChanged: (value) {
          switch (value) {
            case MyStrings.addUser:
              Get.offNamed(AppRoutes.addUserScreen);
              break;
            case MyStrings.editUsers:
              Get.offNamed(AppRoutes.searchUserScreen);
              break;
            case MyStrings.workes:
              workController.getlastWork();
              Get.offAllNamed(AppRoutes.searchWorkScreen);
              break;
            default:
              Get.offNamed(AppRoutes.mainScreen);
          }
        },
      ),
    );
  }
}
