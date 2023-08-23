import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/items/sup_model.dart';

class MySupWidget extends StatelessWidget {
  const MySupWidget({super.key, required this.sup});
  final Sup sup;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.h05,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w1),
      color: AppColorManger.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${MyStrings.idNumber} : ${sup.supId}',
            style: context.textTheme.bodySmall,
          ),
          Text(
            '${MyStrings.supName} : ${sup.supName}',
            style: context.textTheme.bodySmall,
          ),
          Text(
            '${MyStrings.supTel} : ${sup.supTel}',
            style: context.textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
