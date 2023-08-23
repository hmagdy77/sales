import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_sizes.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.w02),
      child: Center(
        child: Text(
          text,
          style: context.textTheme.bodySmall,
        ),
      ),
    );
  }
}
