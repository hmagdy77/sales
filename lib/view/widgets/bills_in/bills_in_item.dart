import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/bills/bill_model.dart';

class BillInItem extends StatelessWidget {
  const BillInItem({super.key, required this.bill});
  final Bill bill;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bill.isBack == 1
          ? AppColorManger.primary
          : bill.isBack == 0
              ? AppColorManger.grey
              : bill.isBack == 4
                  ? AppColorManger.bikesColor
                  : AppColorManger.backBikesColor,
      height: AppSizes.h05,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.w01, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.w05,
          ),
          Text(
            '${MyStrings.billNumper} : ${bill.billId.toString()}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${MyStrings.supName} : ${bill.billSup.toString()}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${MyStrings.billTotal} :  ${bill.billTotal.toString()}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${MyStrings.billDate} : ${bill.billTimestamp.year} - ${bill.billTimestamp.month} - ${bill.billTimestamp.day}',
            style: context.textTheme.bodySmall,
          ),
          SizedBox(
            width: AppSizes.w05,
          ),
        ],
      ),
    );
  }
}
