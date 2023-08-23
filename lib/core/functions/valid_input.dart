import 'package:get/get.dart';

import '../constants/app_strings.dart';
import '../localization/translations.dart';

validInput({
  required String type,
  required String val,
  required int min,
  required int max,
}) {
  if (type == AppStrings.validateUserName) {
    if (!GetUtils.isUsername(val)) {
      return AppStrings.notValidUserName.tr;
    }
  }
  if (type == AppStrings.validateEmail) {
    if (!GetUtils.isEmail(val)) {
      return AppStrings.notValidEmail.tr;
    }
  }
  if (type == AppStrings.validatePhone) {
    if (!GetUtils.isPhoneNumber(val)) {
      return AppStrings.notValidPhone.tr;
    }
  }

  //admin

  if (type == AppStrings.validateAdminNum) {
    if (!GetUtils.isNum(val)) {
      return MyStrings.notValidInput;
    }
  }
  if (type == AppStrings.validateAdmin) {
    if (val.replaceAll(' ', '').isEmpty) {
      return MyStrings.notValidInput;
    }
    if (val.length > max) {
      return '${MyStrings.cantBeMore.tr} $max';
    }
    if (val.length < min) {
      return '${MyStrings.cantBeLess.tr} $min';
    }
  }
  if (val.isEmpty) {
    return MyStrings.cantBeEmpty.tr;
  }
  if (val.length > max) {
    return '${MyStrings.cantBeMore.tr} $max';
  }
  if (val.length < min) {
    return '${MyStrings.cantBeLess.tr} $min';
  }
}
