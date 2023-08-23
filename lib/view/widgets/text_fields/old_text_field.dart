import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';

class OldTextField extends StatelessWidget {
  const OldTextField(
      {Key? key,
      this.sufIcon,
      this.label,
      this.hint,
      this.controller,
      required this.hidePassword,
      this.keyboard,
      this.readOnly,
      required this.validate,
      required this.onSubmite,
      this.preIcon})
      : super(key: key);
  final TextEditingController? controller;
  final Widget? sufIcon; //sufIcon
  final Widget? preIcon; //
  final String? label;
  final String? hint;
  final bool hidePassword;
  final bool? readOnly;
  final Function? validate;
  final TextInputType? keyboard;
  final Function(String) onSubmite;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validate!(value),
      onFieldSubmitted: onSubmite,
      style: context.textTheme.bodySmall,
      controller: controller,
      cursorColor: Get.theme.primaryColor,
      autocorrect: true,
      // cursorHeight: double.maxFinite,
      keyboardType: keyboard,
      readOnly: readOnly == null ? false : true,
      obscureText: hidePassword,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.all(1),
        errorStyle:
            TextStyle(fontSize: Sizes.height * .016, color: AppColorManger.red),
        // labelStyle: GoogleFonts.lato(
        //   fontSize: Sizes.height * .016,
        //   color: Get.theme.primaryColor,
        // ),
        label: Text(label!, style: context.textTheme.bodyMedium),
        floatingLabelStyle: context.textTheme.bodySmall,
        hintText: hint,
        hintStyle:
            context.textTheme.bodySmall!.copyWith(color: AppColorManger.grey),
        suffixIcon: preIcon,
        prefixIcon: sufIcon ?? const Text(''),
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
