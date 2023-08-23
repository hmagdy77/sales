import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      this.text,
      this.onPressed,
      this.minWidth,
      this.color,
      this.child})
      : super(key: key);
  final String? text;
  final double? minWidth;
  final Color? color;
  final Widget? child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppSizes.h06,
        //width: AppSizes.w25,
        margin: const EdgeInsets.all(12),
        child: MaterialButton(
          minWidth: minWidth ?? AppSizes.w4,
          onPressed: onPressed,
          color: color ?? AppColorManger.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child ??
              Text(
                text!,
                style: context.textTheme.displayLarge!
                    .copyWith(color: AppColorManger.white),
              ),
        ),
      ),
    );
  }
}
