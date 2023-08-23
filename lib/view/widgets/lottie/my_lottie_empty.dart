import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_sizes.dart';

class MyLottieEmpty extends StatelessWidget {
  const MyLottieEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/empty.json',
        width: AppSizes.w5,
        height: AppSizes.w5,
        fit: BoxFit.fill,
      ),
    );
  }
}
