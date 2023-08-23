import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_sizes.dart';

class MyLottie extends StatelessWidget {
  const MyLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/done.json',
      width: AppSizes.w5,
      height: AppSizes.w5,
      fit: BoxFit.fill,
    );
  }
}
