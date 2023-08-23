import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/auth/user_model.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});
  final User user;
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
            '${MyStrings.userName} : ${user.userName}',
            style: context.textTheme.bodySmall,
          ),
          user.userAdmin == 1
              ? Text(
                  '${MyStrings.primison} : ${MyStrings.manger}',
                  style: context.textTheme.bodySmall,
                )
              : Text(
                  '${MyStrings.primison} : ${MyStrings.employ}',
                  style: context.textTheme.bodySmall,
                ),
        ],
      ),
    );
  }
}
