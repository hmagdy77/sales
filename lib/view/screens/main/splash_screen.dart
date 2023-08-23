import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/service/services.dart';
import '../../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    MyService myService = Get.find();
    if (myService.sharedPreferences.getInt(MyStrings.adminKey) == null) {
      Get.offNamed(AppRoutes.loginScreen);
    } else {
      Get.offNamed(AppRoutes.mainScreen);
    }
    // Get.offNamed(AppRoutes.loginScreen);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColorManger.primary,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/home.png'),
        ),
      ),
    );

    // Center(
    //   child:
    //   Image(
    //     image: AssetImage(AppImageAssets.google),
    //   ),
    // ),
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
