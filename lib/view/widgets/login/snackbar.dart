import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_sizes.dart';

class MySnackBar {
  static SnackbarController snack(String title, String message) {
    return Get.rawSnackbar(
        maxWidth: AppSizes.h25 * 3,
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(milliseconds: 500),
        titleText: Center(
          child: Text(
            message,
            style: (TextStyle(
                color: Get.theme.primaryColorDark, fontSize: AppSizes.h02)),
          ),
        ),
        messageText: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Get.theme.primaryColorDark,
                fontSize: Sizes.height * .02),
          ),
        ),
        backgroundColor: Get.theme.primaryColor,
        duration: const Duration(seconds: 1),
        borderRadius: 10);
  }
}
