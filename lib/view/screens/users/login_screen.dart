import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth/login_controller.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/localization/translations.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/lottie/my_lottie_loading.dart';
import '../../widgets/text_fields/old_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginControllerImp loginController = Get.put(LoginControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: loginController.loginKey,
          child: Obx(() {
            if (loginController.isLoading.value) {
              return const Center(child: MyLottieLoading());
            } else {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: AppSizes.w4,
                  vertical: AppSizes.w15,
                ),
                padding: EdgeInsets.all(
                  AppSizes.w05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.h03),
                  border: Border.all(
                    color: AppColorManger.black,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(MyStrings.logIn, style: context.textTheme.titleSmall),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    OldTextField(
                      controller: loginController.name,
                      sufIcon:
                          Icon(Icons.email, color: context.theme.primaryColor),
                      keyboard: TextInputType.emailAddress,
                      label: MyStrings.userName,
                      validate: (val) {
                        return validInput(
                          max: 80,
                          min: 3,
                          type: AppStrings.validateAdmin,
                          val: val,
                        );
                      },
                      hidePassword: false,
                      onSubmite: (value) async {
                        await loginController.login();
                      },
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    GetBuilder<LoginControllerImp>(
                      builder: (_) {
                        return OldTextField(
                          controller: loginController.password,
                          label: AppStrings.password.tr,
                          hidePassword: loginController.isShown,
                          sufIcon: Icon(Icons.lock,
                              color: context.theme.primaryColor),
                          keyboard: TextInputType.emailAddress,
                          preIcon: IconButton(
                            onPressed: () {
                              loginController.showPassword();
                            },
                            icon: loginController.isShown
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppColorManger.primary,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: AppColorManger.primary,
                                  ),
                          ),
                          validate: (val) {
                            return validInput(
                              max: 80,
                              min: 3,
                              type: AppStrings.validateAdmin,
                              val: val,
                            );
                          },
                          onSubmite: (value) async {
                            await loginController.login();
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    MyButton(
                      text: MyStrings.logIn,
                      onPressed: () async {
                        await loginController.login();
                      },
                    ),
                  ],
                ),
              );

              // Expanded(
              //   child: Row(
              //     children: [
              //       const Spacer(),
              //       Expanded(
              //         flex: 2,
              //         child: Container(
              //           margin: EdgeInsets.only(top: AppSizes.h2),
              //           padding: EdgeInsets.symmetric(
              //             horizontal: AppSizes.w02,
              //             vertical: AppSizes.h02,
              //           ),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(AppSizes.h03),
              //             border: Border.all(
              //               color: AppColorManger.black,
              //               width: 2,
              //             ),
              //           ),
              //           child: Column(
              //             children: [
              //               Text(MyStrings.logIn,
              //                   style: context.textTheme.titleSmall),
              //               SizedBox(
              //                 height: AppSizes.h02,
              //               ),
              //               OldTextField(
              //                 controller: loginController.name,
              //                 sufIcon: Icon(Icons.email,
              //                     color: context.theme.primaryColor),
              //                 keyboard: TextInputType.emailAddress,
              //                 label: MyStrings.userName,
              //                 validate: (val) {
              //                   return validInput(
              //                     max: 80,
              //                     min: 3,
              //                     type: AppStrings.validateAdmin,
              //                     val: val,
              //                   );
              //                 },
              //                 hidePassword: false,
              //                 onSubmite: (value) async {
              //                   await loginController.login();
              //                 },
              //               ),
              //               SizedBox(
              //                 height: AppSizes.h03,
              //               ),
              //               GetBuilder<LoginControllerImp>(
              //                 builder: (_) {
              //                   return OldTextField(
              //                     controller: loginController.password,
              //                     label: AppStrings.password.tr,
              //                     hidePassword: loginController.isShown,
              //                     sufIcon: Icon(Icons.lock,
              //                         color: context.theme.primaryColor),
              //                     keyboard: TextInputType.visiblePassword,
              //                     preIcon: IconButton(
              //                       onPressed: () {
              //                         loginController.showPassword();
              //                       },
              //                       icon: loginController.isShown
              //                           ? const Icon(
              //                               Icons.visibility,
              //                               color: AppColorManger.primary,
              //                             )
              //                           : const Icon(
              //                               Icons.visibility_off,
              //                               color: AppColorManger.primary,
              //                             ),
              //                     ),
              //                     validate: (val) {
              //                       return validInput(
              //                         max: 80,
              //                         min: 3,
              //                         type: AppStrings.validateAdmin,
              //                         val: val,
              //                       );
              //                     },
              //                     onSubmite: (value) async {
              //                       await loginController.login();
              //                     },
              //                   );
              //                 },
              //               ),
              //               MyButton(
              //                 text: MyStrings.logIn,
              //                 onPressed: () async {
              //                   await loginController.login();
              //                 },
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       const Spacer(),
              //     ],
              //   ),
              // );
            }
          }),
        ),
      ),
    );
  }
}

// Row(
//                     children: [
//                       const Spacer(),
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: AppSizes.w02,
//                             vertical: AppSizes.h02,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(AppSizes.h03),
//                             border: Border.all(
//                               color: AppColorManger.black,
//                               width: 2,
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               Text(MyStrings.logIn,
//                                   style: context.textTheme.titleSmall),
//                               SizedBox(
//                                 height: AppSizes.h02,
//                               ),
//                               OldTextField(
//                                 controller: loginController.name,
//                                 sufIcon: Icon(Icons.email,
//                                     color: context.theme.primaryColor),
//                                 keyboard: TextInputType.emailAddress,
//                                 label: MyStrings.userName,
//                                 validate: (val) {
//                                   return validInput(
//                                     max: 80,
//                                     min: 3,
//                                     type: AppStrings.validateAdmin,
//                                     val: val,
//                                   );
//                                 },
//                                 hidePassword: false,
//                                 onSubmite: (value) async {
//                                   await loginController.login();
//                                 },
//                               ),
//                               SizedBox(
//                                 height: AppSizes.h03,
//                               ),
//                               GetBuilder<LoginControllerImp>(
//                                 builder: (_) {
//                                   return OldTextField(
//                                     controller: loginController.password,
//                                     label: AppStrings.password.tr,
//                                     hidePassword: loginController.isShown,
//                                     sufIcon: Icon(Icons.lock,
//                                         color: context.theme.primaryColor),
//                                     keyboard: TextInputType.emailAddress,
//                                     preIcon: IconButton(
//                                       onPressed: () {
//                                         loginController.showPassword();
//                                       },
//                                       icon: loginController.isShown
//                                           ? const Icon(
//                                               Icons.visibility,
//                                               color: AppColorManger.primary,
//                                             )
//                                           : const Icon(
//                                               Icons.visibility_off,
//                                               color: AppColorManger.primary,
//                                             ),
//                                     ),
//                                     validate: (val) {
//                                       return validInput(
//                                         max: 80,
//                                         min: 3,
//                                         type: AppStrings.validateAdmin,
//                                         val: val,
//                                       );
//                                     },
//                                     onSubmite: (value) async {
//                                       await loginController.login();
//                                     },
//                                   );
//                                 },
//                               ),
//                               MyButton(
//                                 text: MyStrings.logIn,
//                                 onPressed: () async {
//                                   await loginController.login();
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
