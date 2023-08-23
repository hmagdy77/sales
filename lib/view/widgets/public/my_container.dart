import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.content});
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppSizes.w02, vertical: AppSizes.h02),
      // padding: EdgeInsets.symmetric(AppSizes.w01),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(AppSizes.h02),
      //     bottomLeft: Radius.circular(AppSizes.h02),
      //     topRight: Radius.circular(AppSizes.h02),
      //   ),
      // ),
      child: content,
    );
  }
}
