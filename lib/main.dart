import 'dart:ui';

// import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_theme.dart';
import 'core/localization/change_language_controller.dart';
import 'core/localization/translations.dart';
import 'core/service/services.dart';
import 'routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialService();
  // await DesktopWindow.setMinWindowSize(const Size(1200, 800));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeLanguageController controller = Get.put(ChangeLanguageController());

    return GetMaterialApp(
      translations: MyTranslation(),
      scrollBehavior: MyCustomScrollBehavior(),
      locale: controller.language,
      debugShowCheckedModeBanner: false,
      title: 'Purchasing and Sales Management Program',
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      getPages: getRoutes!,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
