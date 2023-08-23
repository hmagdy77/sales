import 'package:flutter/material.dart';
 
import 'app_color_manger.dart';
import 'app_sizes.dart';

class AppTheme {
  static final light = ThemeData(
    tabBarTheme: TabBarTheme(
        overlayColor: MaterialStateProperty.all(Colors.grey),
        indicator: BoxDecoration(
            color: AppColorManger.primary,
            borderRadius: BorderRadius.circular(12))),
    primaryColor: AppColorManger.primary,
    primaryColorLight: AppColorManger.lightFontColor,
    primaryColorDark: AppColorManger.darkFontColor,
    scaffoldBackgroundColor: const Color.fromARGB(255, 249, 248, 249),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: AppColorManger.primary,
      centerTitle: true,
      titleTextStyle:
          TextStyle(color: Colors.white, fontSize: Sizes.height * .026),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: AppColorManger.lightFontColor,
          fontSize: Sizes.height * .04,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
        color: AppColorManger.lightFontColor,
        fontSize: Sizes.height * .035,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: AppColorManger.lightFontColor,
        fontSize: Sizes.height * .03,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: AppColorManger.lightFontColor,
        fontSize: Sizes.height * .025,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColorManger.lightFontColor,
        fontSize: Sizes.height * .02,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: AppColorManger.lightFontColor,
        fontSize: Sizes.height * .018,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: TextStyle(
        color: AppColorManger.lightFontColor,
        fontSize: Sizes.height * .015,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: AppColorManger.lightFontColor,
        fontSize: Sizes.height * .012,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: AppColorManger.lightFontColor,
        fontSize: Sizes.height * .01,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // static final dark = ThemeData(
  //   primaryColor: AppColorManger.pinkClr,
  //   primaryColorLight: AppColorManger.darkFontColor,
  //   primaryColorDark: AppColorManger.lightFontColor,
  //   scaffoldBackgroundColor: AppColorManger.darkScaffold,
  //   brightness: Brightness.dark,
  //   appBarTheme: AppBarTheme(
  //       elevation: 0,
  //       color: AppColorManger.pinkClr,
  //       centerTitle: true,
  //       titleTextStyle:
  //           TextStyle(color: Colors.white, fontSize: Sizes.height * .026)),
  //   textTheme: TextTheme(
  //     headline1: GoogleFonts.lato(
  //         color: AppColorManger.lightFontColor,
  //         fontSize: Sizes.height * .04,
  //         fontWeight: FontWeight.bold),
  //     headline2: GoogleFonts.lato(
  //       color: AppColorManger.white,
  //       fontSize: Sizes.height * .04,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     headline3: GoogleFonts.lato(
  //       color: AppColorManger.darkFontColor,
  //       fontSize: Sizes.height * .035,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     headline4: GoogleFonts.lato(
  //       color: AppColorManger.white,
  //       fontSize: Sizes.height * .035,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     headline5: GoogleFonts.lato(
  //       color: AppColorManger.darkFontColor,
  //       fontSize: Sizes.height * .03,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     headline6: GoogleFonts.lato(
  //       color: AppColorManger.white,
  //       fontSize: Sizes.height * .03,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     titleMedium: GoogleFonts.lato(
  //       color: AppColorManger.darkFontColor,
  //       fontSize: Sizes.height * .025,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     subtitle2: GoogleFonts.lato(
  //       color: AppColorManger.white,
  //       fontSize: Sizes.height * .025,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     bodyText1: GoogleFonts.lato(
  //       color: AppColorManger.darkFontColor,
  //       fontSize: Sizes.height * .01,
  //       // fontWeight: FontWeight.bold,
  //     ),
  //     bodyText2: GoogleFonts.lato(
  //       color: AppColorManger.white,
  //       fontSize: Sizes.height * .02,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  // );
}
