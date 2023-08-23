import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../core/service/services.dart';
import '../../models/status/status_model.dart';
import '../../models/items/sup_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class EditSupController extends GetxController {
  getSups();
  editSup(String id);
  deleteSub(String id);
  void search(String searchName);
  goToMainScreen();
}

class EditSupControllerImp extends EditSupController {
  late TextEditingController name;
  late TextEditingController tel;
  var selectedSup = ''.obs;

  GlobalKey<FormState> editSupKey = GlobalKey<FormState>();

  bool isShown = true;
  var isLoading = false.obs;
  List<Sup> supList = <Sup>[].obs;
  List<Sup> searchSupList = <Sup>[].obs;
  MyService myService = Get.find();

  @override
  void onInit() {
    name = TextEditingController();
    tel = TextEditingController();
    getSups();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    tel.dispose();
    super.dispose();
  }

  @override
  editSup(String id) async {
    var formData = editSupKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var editSup = await Crud.postRequest(
          MyStrings.apiEditSup,
          {
            'sup_id': id,
            'sup_name': name.text,
            'sup_tel': tel.text,
          },
          statusModelFromJson);
      try {
        if (editSup.status == "suc") {
          isLoading(false);
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.searchSupScreen],
          );
          update();
        } else if (editSup.status == "fail") {
          MySnackBar.snack(MyStrings.noitemsEdited, '');
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

  @override
  getSups() async {
    isLoading(true);
    var sup = await Crud.postRequest(
      MyStrings.apiGetSup,
      {},
      supModelFromJson,
    );
    try {
      if (sup.status == 'fail') {
        MySnackBar.snack(MyStrings.emptyList, '');
        isLoading(false);
        update();
      } else if (sup.status == 'suc') {
        isLoading(false);
        supList.addAll(sup.data);
        update();
      }
    } catch (_) {}
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchSupList = supList.where(
      (sup) {
        var supName = sup.supName;
        var supId = sup.supId.toString();
        var supTel = sup.supTel.toString();
        return supName.contains(searchName) ||
            supId.contains(searchName) ||
            supTel.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deleteSub(String id) async {
    isLoading(true);
    var sup = await Crud.postRequest(
      MyStrings.apiDeleteSup,
      {'sup_id': id},
      statusModelFromJson,
    );
    if (sup.status == 'suc') {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [AppRoutes.searchSupScreen],
      );
      update();
    } else if (sup.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  goToMainScreen() {
    Get.offAndToNamed(AppRoutes.mainScreen);
  }
}
