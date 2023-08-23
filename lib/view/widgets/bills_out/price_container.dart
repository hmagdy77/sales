import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer(
      {super.key, required this.text, required this.isConst, this.width});
  final String text;
  final bool isConst;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppSizes.w15,
      height: AppSizes.h06,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: isConst ? AppColorManger.white : AppColorManger.grey,
        border: Border.all(width: 1, color: AppColorManger.black),
      ),
      child: Center(
        child: Text(
          text,
          style: context.textTheme.displayLarge,
        ),
      ),
    );
  }
}
