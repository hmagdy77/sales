import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/status/status_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class AddUserController extends GetxController {
  addUser(String isAdmin);
}

class AddUserControllerImp extends AddUserController {
  late TextEditingController userName;
  late TextEditingController password;

  GlobalKey<FormState> addUserKey = GlobalKey<FormState>();
  bool isShown = true;
  var isLoading = false.obs;
  var selectedJop = ''.obs;
  var jopKind = 0.obs;

  @override
  void onInit() {
    userName = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  addUser(String isAdmin) async {
    var formData = addUserKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var addUser = await Crud.postRequest(
          MyStrings.apiAddUsers,
          {
            'user_name': userName.text,
            'user_password': password.text,
            'user_admin': isAdmin
          },
          statusModelFromJson);
      try {
        if (addUser.status == "suc") {
          isLoading(false);
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.addUserScreen],
          );
          update();
        } else if (addUser.status == "found") {
          MySnackBar.snack(MyStrings.userFound, ' ');
          isLoading(false);
          update();
        } else if (addUser.status == "fail") {
          isLoading(false);
          update();
        }
      } catch (_) {
        //MySnackBar.snack('please try later', 'Some thing went wrong');
        isLoading(false);
        update();
      }
    }
  }
}

 // await Future.delayed(const Duration(seconds: 2));