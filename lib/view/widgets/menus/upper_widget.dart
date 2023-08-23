import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth/login_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/service/services.dart';
import '../../../routes.dart';
import 'bill_in_menu.dart';
import 'bill_out_menu.dart';
import 'stock_menu.dart';
import 'emp_menu.dart';
import 'users_menu.dart';

class UpperWidget extends StatelessWidget {
  UpperWidget(
      {super.key, required this.isAdminScreen, required this.onPressed});
  final bool isAdminScreen;
  final Function onPressed;
  final LoginControllerImp loginController = Get.put(LoginControllerImp());
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    if (myService.sharedPreferences.getInt(MyStrings.adminKey) == 1) {
      return Padding(
        padding: EdgeInsets.only(bottom: AppSizes.h05),
        child: Row(
          children: [
            SizedBox(
              child: TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.mainScreen);
                },
                child: Text(
                  MyStrings.mainScreen,
                  style: context.textTheme.displayLarge,
                ),
              ),
            ),
            SizedBox(child: StockMenu()),
            SizedBox(child: SupMenu()),
            SizedBox(child: BillInMenu()),
            SizedBox(child: BillOutMenu()),
            // SizedBox(child: ReportsMenu()),
            SizedBox(child: UsersMenu()),
            SizedBox(
              child: TextButton(
                onPressed: () async {
                  // Get.offNamed(AppRoutes.loginScreen);
                  // myService.sharedPreferences.clear();
                  await loginController.logOut();
                },
                child: Text(
                  MyStrings.logOut,
                  style: context.textTheme.displayLarge,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (myService.sharedPreferences.getInt(MyStrings.adminKey) == 2) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: AppSizes.h05,
          top: AppSizes.h02,
        ),
        child: Row(
          children: [
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // MainScreen()
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.mainScreen);
              },
              child: Text(
                MyStrings.mainScreen,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            //stock
            TextButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.stockScreen);
              },
              child: Text(
                MyStrings.stock,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // attend
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.attendScreen);
              },
              child: Text(
                MyStrings.attendAndExit,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // bilout
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.addBillInScreen);
              },
              child: Text(
                MyStrings.billIn,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // bilout
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.addBillOutScreen);
              },
              child: Text(
                MyStrings.billOut,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // works
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.searchWorkScreen);
              },
              child: Text(
                MyStrings.workes,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // logOut
            TextButton(
              onPressed: () async {
                // Get.offNamed(AppRoutes.loginScreen);
                // myService.sharedPreferences.clear();
                await loginController.logOut();
              },
              child: Text(
                MyStrings.logOut,
                style: context.textTheme.displayLarge,
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
          bottom: AppSizes.h05,
          top: AppSizes.h02,
        ),
        child: Row(
          children: [
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // main screen
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.mainScreen);
              },
              child: Text(
                MyStrings.mainScreen,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // attend
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.attendScreen);
              },
              child: Text(
                MyStrings.attendAndExit,
                style: context.textTheme.displayLarge,
              ),
            ),
            SizedBox(
              width: AppSizes.w05,
            ),

            // billsout
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.addBillOutScreen);
              },
              child: Text(
                MyStrings.addBillOut,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // works
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.searchWorkScreen);
              },
              child: Text(
                MyStrings.workes,
                style: context.textTheme.displayLarge,
              ),
            ),
            // for width
            SizedBox(
              width: AppSizes.w05,
            ),
            // logout
            TextButton(
              onPressed: () async {
                // Get.offNamed(AppRoutes.loginScreen);
                // myService.sharedPreferences.clear();
                await loginController.logOut();
              },
              child: Text(
                MyStrings.logOut,
                style: context.textTheme.displayLarge,
              ),
            )
          ],
        ),
      );
    }
  }
}
