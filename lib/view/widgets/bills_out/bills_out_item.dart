import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/bills/bill_model.dart';

class BillOutItem extends StatelessWidget {
  const BillOutItem({super.key, required this.bill});
  final Bill bill;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bill.isBack.toString() == '1'
          ? AppColorManger.primary
          : bill.isBack.toString() == '2'
              ? AppColorManger.rentColor
              : bill.isBack.toString() == '3'
                  ? AppColorManger.black
                  : AppColorManger.grey,
      height: AppSizes.h05,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.w01, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.w05,
          ),
          Text(
            '${MyStrings.billNumper} : ${bill.billId.toString()}',
            style: bill.isBack.toString() == '3'
                ? context.textTheme.bodySmall!
                    .copyWith(color: AppColorManger.white)
                : context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${MyStrings.agentName} : ${bill.agentName.toString()}',
            style: bill.isBack.toString() == '3'
                ? context.textTheme.bodySmall!
                    .copyWith(color: AppColorManger.white)
                : context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${MyStrings.totalAfterDiscount} :  ${bill.billAfterAiscount.toString()}',
            style: bill.isBack.toString() == '3'
                ? context.textTheme.bodySmall!
                    .copyWith(color: AppColorManger.white)
                : context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${MyStrings.billDate} : ${bill.billTimestamp.year} - ${bill.billTimestamp.month} - ${bill.billTimestamp.day}',
            style: bill.isBack.toString() == '3'
                ? context.textTheme.bodySmall!
                    .copyWith(color: AppColorManger.white)
                : context.textTheme.bodySmall,
          ),
          SizedBox(
            width: AppSizes.w05,
          ),
        ],
      ),
    );
  }
}
