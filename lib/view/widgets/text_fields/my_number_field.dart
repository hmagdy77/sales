import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';

class MyNumberField extends StatelessWidget {
  const MyNumberField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.onChange,
    this.onSubmit,
    this.readOnly,
    this.value,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool? readOnly;
  final String? value;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;

  // ItemControllerImp editItemController = Get.put(ItemControllerImp());

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      style: context.textTheme.displayLarge,
      cursorColor: Get.theme.primaryColor,
      autocorrect: true,
      // cursorHeight: double.maxFinite,
      readOnly: readOnly ?? false,
      // initialValue: value ?? 0,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.w01),
        errorStyle:
            TextStyle(fontSize: Sizes.height * .016, color: AppColorManger.red),
        label: Text(label!),
        labelStyle: context.textTheme.displayLarge,
        floatingLabelStyle: context.textTheme.displayLarge,
        hintText: hint,
        hintStyle: context.textTheme.displayLarge!
            .copyWith(color: AppColorManger.grey),
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
