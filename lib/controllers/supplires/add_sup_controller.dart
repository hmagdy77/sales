import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../core/service/services.dart';
import '../../models/status/status_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class AddSupController extends GetxController {
  addSup();
}

class AddSupControllerImp extends AddSupController {
  late TextEditingController name;
  late TextEditingController tel;

  GlobalKey<FormState> addSupKey = GlobalKey<FormState>();
  bool isShown = true;
  var isLoading = false.obs;
  MyService myService = Get.find();

  @override
  void onInit() {
    name = TextEditingController();
    tel = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    tel.dispose();
    super.dispose();
  }

  @override
  addSup() async {
    var formData = addSupKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var addItem = await Crud.postRequest(
          MyStrings.apiAddSup,
          {
            'sup_name': name.text,
            'sup_tel': tel.text,
          },
          statusModelFromJson);
      try {
        if (addItem.status == "suc") {
          isLoading(false);
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.addSupScreen],
          );
          update();
        } else if (addItem.status == "found") {
          MySnackBar.snack(MyStrings.found, ' ');
          isLoading(false);
          update();
        } else if (addItem.status == "fail") {
          isLoading(false);
          update();
        }
      } catch (_) {
        isLoading(false);
        update();
      }
    }
  }
}
