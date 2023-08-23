import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class ColorsDetailsWidget extends StatelessWidget {
  const ColorsDetailsWidget({super.key, required this.kind});
  final int kind;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: AppSizes.w3,
      child: kind == 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColorManger.grey,
                          radius: 8,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          MyStrings.billOut,
                          style: context.textTheme.displayLarge,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColorManger.primary,
                          radius: 8,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          MyStrings.backBillOut,
                          style: context.textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColorManger.rentColor,
                          radius: 8,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          MyStrings.rent,
                          style: context.textTheme.displayLarge,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColorManger.fixtColor,
                          radius: 8,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          MyStrings.fix,
                          style: context.textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColorManger.bikesColor,
                          radius: 8,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          MyStrings.bikeBillOut,
                          style: context.textTheme.displayLarge,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColorManger.backBikesColor,
                          radius: 8,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          MyStrings.backBillInBike,
                          style: context.textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          : kind == 2
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: AppColorManger.black,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: AppSizes.w01,
                    vertical: AppSizes.w01,
                  ),
                  padding: EdgeInsets.only(
                    top: AppSizes.w01,
                    right: AppSizes.w01,
                    left: AppSizes.w01,
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                MyStrings.billOut,
                                style: context.textTheme.displayLarge,
                              ),
                              const CircleAvatar(
                                backgroundColor: AppColorManger.grey,
                                radius: 8,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                MyStrings.backBillOut,
                                style: context.textTheme.displayLarge,
                              ),
                              const CircleAvatar(
                                backgroundColor: AppColorManger.primary,
                                radius: 8,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                MyStrings.rent,
                                style: context.textTheme.displayLarge,
                              ),
                              const CircleAvatar(
                                backgroundColor: AppColorManger.rentColor,
                                radius: 8,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                MyStrings.fix,
                                style: context.textTheme.displayLarge,
                              ),
                              const CircleAvatar(
                                backgroundColor: AppColorManger.fixtColor,
                                radius: 8,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                MyStrings.bikeBillOut,
                                style: context.textTheme.displayLarge,
                              ),
                              const CircleAvatar(
                                backgroundColor: AppColorManger.bikesColor,
                                radius: 8,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                MyStrings.backBillInBike,
                                style: context.textTheme.displayLarge,
                              ),
                              const CircleAvatar(
                                backgroundColor: AppColorManger.backBikesColor,
                                radius: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
    );
  }
}
