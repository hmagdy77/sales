import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../core/service/services.dart';
import '../../models/auth/user_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class LoginController extends GetxController {
  login();
  logOut();
}

class LoginControllerImp extends LoginController {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  late TextEditingController password;
  late TextEditingController name;
  List<User> loginList = [];
  bool isShown = true;
  var isLoading = false.obs;
  MyService myService = Get.find();
  showPassword() {
    isShown = !isShown;
    update();
  }

  @override
  void onInit() {
    password = TextEditingController();
    name = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  login() async {
    var formData = loginKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var login = await Crud.postRequest(
        MyStrings.apiLogin,
        {'user_name': name.text.toString()},
        userModelFromJson,
      );
      try {
        if (login.status == "suc") {
          loginList.addAll(login.data);
          if (loginList[0].userPassword != password.text) {
            MySnackBar.snack('', MyStrings.wrongPassword);

            isLoading(false);
            update();
          } else if (loginList[0].userAdmin == 0) {
            MySnackBar.snack(MyStrings.sucLogIn, '');
            Get.offNamed(AppRoutes.addBillOutScreen);
            myService.sharedPreferences.setInt(MyStrings.adminKey, 0);
            isLoading(false);
            update();
          } else if (loginList[0].userAdmin == 2) {
            MySnackBar.snack(MyStrings.sucLogIn, '');
            Get.offNamed(AppRoutes.mainScreen);
            myService.sharedPreferences.setInt(MyStrings.adminKey, 2);
            isLoading(false);
            update();
          } else if (loginList[0].userAdmin == 1) {
            MySnackBar.snack(MyStrings.sucLogIn, '');
            myService.sharedPreferences.setInt(MyStrings.adminKey, 1);
            Get.offNamed(AppRoutes.mainScreen);
            isLoading(false);
            update();
          }
          update();
        } else if (login.status == "fail") {
          MySnackBar.snack(MyStrings.userNotFound, '');
          isLoading(false);
          update();
        }
      } catch (_) {
        isLoading(false);
        update();
      }
    }
  }

  @override
  logOut() {
    isLoading(true);
    myService.sharedPreferences.clear();
    Get.offNamed(AppRoutes.loginScreen);
    isLoading(false);
  }
}
