import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/bills/bill_model.dart';
import '../public/discount_icon.dart';

class WorkBill extends StatelessWidget {
  const WorkBill({super.key, required this.bill});
  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.w01,
        vertical: AppSizes.w01,
      ),
      padding: EdgeInsets.only(top: AppSizes.w01, right: AppSizes.w01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bill.isBack == 0
              ? AppColorManger.grey
              : bill.isBack == 1
                  ? AppColorManger.primary
                  : bill.isBack == 2
                      ? AppColorManger.rentColor
                      : bill.isBack == 3
                          ? AppColorManger.fixtColor
                          : bill.isBack == 4
                              ? AppColorManger.bikesColor
                              : AppColorManger.backBikesColor),
      width: AppSizes.w25,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${MyStrings.billNumper} : ${bill.billId}',
                style: Get.textTheme.displayLarge,
                textAlign: TextAlign.start,
              ),
              Text(
                '${MyStrings.total} : ${bill.billTotal}',
                style: Get.textTheme.displayMedium,
                textAlign: TextAlign.start,
              ),
              Text(
                '${MyStrings.billTime} : ${DateFormat.jm().format(bill.billTimestamp)}',
                style: context.textTheme.displayMedium,
                textAlign: TextAlign.start,
              ),
              Text(
                '${MyStrings.numberOfitems} : ${bill.billItems}',
                style: Get.textTheme.displayMedium,
                textAlign: TextAlign.start,
              ),
              Text(
                '${MyStrings.agentName} : ${bill.agentName}',
                style: Get.textTheme.displayMedium,
                textAlign: TextAlign.start,
              ),
              Text(
                '${MyStrings.agentPhone} : ${bill.agentPhone}',
                style: Get.textTheme.displayMedium,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          bill.billDiscount != 0
              ? const Positioned(bottom: 5, left: 5, child: DiscountIcon())
              : Container(),
        ],
      ),
    );
  }
}
