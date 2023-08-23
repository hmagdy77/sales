import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_sizes.dart';

class LabelText extends StatelessWidget {
  const LabelText({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.h01),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(AppSizes.h01),
      ),
      child: Text(
        label,
        style: context.textTheme.titleSmall,
      ),
    );
  }
}
