import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.onChange,
    this.onSubmit,
    this.keyBoardType,
    required this.validate,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final Function? validate;
  final TextInputType? keyBoardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
//       inputFormatters: <TextInputFormatter>[
//for below version 2 use this
      // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//for version 2 and greater youcan also use this
//         FilteringTextInputFormatter.digitsOnly
//       ],
      keyboardType: keyBoardType,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: (value) => validate!(value),
      style: context.textTheme.bodySmall,
      controller: controller,
      cursorColor: Get.theme.primaryColor,
      autocorrect: true,
      // cursorHeight: double.maxFinite,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.h03),
        errorStyle:
            TextStyle(fontSize: Sizes.height * .016, color: AppColorManger.red),
        label: Text(label!),
        labelStyle: context.textTheme.bodySmall,
        floatingLabelStyle: context.textTheme.bodySmall,
        hintText: hint,
        hintStyle:
            context.textTheme.bodySmall!.copyWith(color: AppColorManger.grey),
        suffixIcon: IconButton(
          onPressed: () {
            controller!.text.isNotEmpty ? controller!.clear() : print('');
            // editItemController.searchItemsList.clear();
          },
          icon: const Icon(
            Icons.clear_outlined,
            color: AppColorManger.primary,
          ),
        ),
        suffixIconColor: Get.theme.primaryColor,
        prefixIconColor: Get.theme.primaryColor,
        filled: true,
        fillColor: AppColorManger.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.w01),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.w01),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.w01),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.w01),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.w01),
          borderSide: const BorderSide(color: AppColorManger.red, width: 2),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.w01),
          borderSide: const BorderSide(color: AppColorManger.red, width: 2),
        ),
      ),
    );
  }
}
