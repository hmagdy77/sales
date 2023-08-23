import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/functions/crud.dart';
import '../../models/status/status_model.dart';
import '../../models/auth/user_model.dart';
import '../../routes.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class EditUserController extends GetxController {
  getUsers();
  editUser(String id);
  deleteUser(String id);
  void search(String searchName);
  goToMainScreen();
}

class EdituserControllerImp extends EditUserController {
  late TextEditingController userName;
  late TextEditingController password;
  late TextEditingController searchController;
  var selectedJop = ''.obs;
  var isManger = false.obs;
  var isEmploy = false.obs;
  GlobalKey<FormState> editUserKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  List<User> usersList = <User>[].obs;
  List<User> searchUsersList = <User>[].obs;

  @override
  void onInit() {
    userName = TextEditingController();
    password = TextEditingController();
    searchController = TextEditingController();
    getUsers();
    super.onInit();
  }

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  editUser(String id) async {
    var formData = editUserKey.currentState;
    if (formData!.validate()) {
      isLoading(true);
      var edituser = await Crud.postRequest(
          MyStrings.apiEditUsers,
          {
            'user_id': id,
            'user_name': userName.text,
            'user_password': password.text,
          },
          statusModelFromJson);
      try {
        if (edituser.status == "suc") {
          isLoading(false);
          // Get.offNamed(AppRoutes.mainScreen);
          // MySnackBar.snack('Done', '');
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [AppRoutes.searchUserScreen],
          );
          update();
        } else if (edituser.status == "fail") {
          MySnackBar.snack(MyStrings.noitemsEdited, '');
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
  getUsers() async {
    isLoading(true);
    var user = await Crud.postRequest(
      MyStrings.apiGetUsers,
      {},
      userModelFromJson,
    );
    try {
      if (user.status == 'fail') {
        isLoading(false);
        update();
      } else if (user.status == 'suc') {
        isLoading(false);
        usersList.addAll(user.data);
        update();
      }
    } catch (_) {}
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchUsersList = usersList.where(
      (user) {
        var userName = user.userName;
        var userId = user.userId.toString();
        return userName.contains(searchName) || userId.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deleteUser(String id) async {
    isLoading(true);
    var user = await Crud.postRequest(
      MyStrings.apiDeleteUsers,
      {'user_id': id},
      statusModelFromJson,
    );
    if (user.status == 'suc') {
      isLoading(false);
      Get.offNamed(AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchUserScreen]);
      update();
    } else if (user.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  goToMainScreen() {
    Get.offAndToNamed(AppRoutes.mainScreen);
  }
}
