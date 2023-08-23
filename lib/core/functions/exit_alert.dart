import 'dart:io';

import 'package:get/get.dart';

Future<bool> exitAlert() async {
  Get.defaultDialog(
    title: 'Exit from app',
    middleText: 'Are you sure you want yo exit?',
    backgroundColor: Get.theme.primaryColor,
    buttonColor: Get.theme.scaffoldBackgroundColor,
    radius: 10,
    textCancel: 'Yes',
    cancelTextColor: Get.theme.primaryColorLight,
    confirmTextColor: Get.theme.primaryColorLight,
    textConfirm: 'No',
    onConfirm: () {
      Get.back();
    },
    onCancel: () {
      exit(0);
    },
  );
  return Future.value(true);
}
