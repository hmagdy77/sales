import 'package:flutter/material.dart';
import 'package:get/get.dart';

myDialuge({
  required Function confirm,
  required Function cancel,
  required String confirmTitle,
  required String cancelTitle,
  required String title,
  required String middleText,
  Widget? content,
}) {
  return Get.defaultDialog(
    title: title,
    middleText: middleText,
    backgroundColor: Get.theme.primaryColor,
    buttonColor: Get.theme.scaffoldBackgroundColor,
    radius: 10,
    textCancel: cancelTitle,
    textConfirm: confirmTitle,
    content: content ?? Container(),
    cancelTextColor: Get.theme.primaryColorLight,
    confirmTextColor: Get.theme.primaryColorLight,
    onConfirm: () {
      confirm();
    },
    onCancel: () {
      cancel();
    },
  );
}
