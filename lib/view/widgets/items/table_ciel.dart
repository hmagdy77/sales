import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';

class MyCiel extends StatelessWidget {
  const MyCiel({
    super.key,
    required this.text,
    required this.isHeader,
    required this.width,
    required this.isBack,
    this.child,
    this.style,
    this.padding,
  });
  final String text;
  final int width;
  final bool isHeader;
  final bool isBack;
  final Widget? child;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: width,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isBack
              ? AppColorManger.primary
              : isHeader
                  ? AppColorManger.greyLight
                  : AppColorManger.white,
          border: isHeader
              ? Border.symmetric(
                  horizontal: BorderSide(color: AppColorManger.black, width: 5),
                  vertical: BorderSide(color: AppColorManger.black, width: 2))
              : Border.all(width: 2, color: AppColorManger.black),
        ),
        child: child ??
            Center(
              child: Text(
                text,
                style: style ?? context.textTheme.bodySmall,
              ),
            ),
      ),
    );
  }
}
