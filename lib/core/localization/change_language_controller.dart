import 'dart:ui';

import 'package:get/get.dart';

import '../service/services.dart';
import 'translations.dart';

class ChangeLanguageController extends GetxController {
  late Locale language;
  final String key = 'language';
  MyService myService = Get.find();

  changeLanguage(String languageCode) {
    language = Locale(languageCode);
    myService.sharedPreferences.setString(key, languageCode);
    Get.updateLocale(language);
  }

  @override
  void onInit() {
    super.onInit();
    //String? sharedPrefLang = myService.sharedPreferences.getString(key);
    language = const Locale(AppStrings.arabicCode);
    // if (sharedPrefLang == AppStrings.arabicCode) {
    //   language = const Locale(AppStrings.arabicCode);
    // } else if (sharedPrefLang == AppStrings.englishCode) {
    //   language = const Locale(AppStrings.englishCode);
    // } else {
    //   language = Locale(Get.deviceLocale!.languageCode);
    // }
  }
}
