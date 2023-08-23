import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../models/items/item_model.dart';
import '../text_fields/my_number_field.dart';

class BillInCartItem extends StatelessWidget {
  BillInCartItem({
    Key? key,
    required this.index,
    required this.billInItem,
    required this.quantity,
    required this.inEdit,
    required this.isBack,
  }) : super(key: key);
  final cartController = Get.put(BillInCartControllerImp());
  final int index;
  final bool inEdit;
  final bool isBack;
  final Item billInItem;
  int quantity;
  @override
  Widget build(BuildContext context) {
    int? isAdmin =
        cartController.myService.sharedPreferences.getInt(MyStrings.adminKey);
    return Container(
      margin: EdgeInsets.only(
        left: AppSizes.w01,
        top: AppSizes.w01,
      ),
      padding: EdgeInsets.only(top: AppSizes.w01, right: AppSizes.w01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cartController.isOverd![index]
            ? AppColorManger.primary
            : AppColorManger.grey,
      ),
      width: AppSizes.w25,
      child: billInItem.bikeKind.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${MyStrings.name} : ${billInItem.itemName.maxLength(9)}',
                      style: Get.textTheme.displayMedium,
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                    Text(
                      '${MyStrings.bikeNum} : ${billInItem.itemNum.maxLength(9)}',
                      style: Get.textTheme.displayMedium,
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${MyStrings.bikeModel} : ${billInItem.bikeModel.maxLength(9)}',
                      style: Get.textTheme.displayMedium,
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                    Text(
                      '${MyStrings.bikeColor} : ${billInItem.bikeColor.maxLength(9)}',
                      style: Get.textTheme.displayMedium,
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                  ],
                ),
                isAdmin == 1
                    ? Text(
                        '${MyStrings.itemPriceIn} : ${billInItem.itemPriceIn}',
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.start,
                      )
                    : Container(),
                isAdmin == 1
                    ? Text(
                        '${MyStrings.total} : ${cartController.supTotal[index].toString().maxLength(6)}',
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.start,
                      )
                    : Container(),
                inEdit
                    ? Text(
                        '${MyStrings.theNumber} : ${billInItem.itemCount}',
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.start,
                      )
                    : Text(
                        '${MyStrings.avilableQuantity} : ${billInItem.itemQuant}',
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.start,
                      ),
                const Spacer(),
                inEdit
                    ? Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: AppSizes.h03,
                          width: AppSizes.w1,
                          child: MyNumberField(
                            label: '',
                            hint: '1',
                            controller: cartController.controllers![index],
                            onChange: (val) {
                              if (val.isNum) {
                                cartController.updateQuantity(
                                    billInItem, int.parse(val));
                              } else {}
                            },
                            onSubmit: (val) {
                              if (val.isEmpty) {
                              } else {
                                cartController.updateQuantity(
                                    billInItem, int.parse(val));
                              }
                            },
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cartController.removeOneProduct(
                                  billInItem, index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: context.theme.primaryColorDark,
                              size: AppSizes.h03,
                            ),
                          ),
                          isBack
                              ? SizedBox(
                                  height: AppSizes.h03,
                                  width: AppSizes.w1,
                                  child: MyNumberField(
                                    label: '',
                                    hint: '1',
                                    controller:
                                        cartController.controllers![index],
                                    onChange: (val) {
                                      if (val.isNum) {
                                        var quantityValue = int.parse(val);
                                        var quantity = billInItem.itemQuant;
                                        cartController.updateQuantity(
                                            billInItem, int.parse(val));
                                        if (quantity < quantityValue) {
                                          cartController.isOverd![index] = true;
                                        } else if (quantity >= quantityValue) {
                                          cartController.isOverd![index] =
                                              false;
                                        }
                                      }
                                    },
                                    onSubmit: (val) {
                                      if (val.isNum) {
                                        var quantityValue = int.parse(val);
                                        var quantity = billInItem.itemQuant;
                                        cartController.updateQuantity(
                                            billInItem, int.parse(val));
                                        if (quantity < quantityValue) {
                                          cartController.isOverd![index] = true;
                                        } else if (quantity >= quantityValue) {
                                          cartController.isOverd![index] =
                                              false;
                                        }
                                      }
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height: AppSizes.h03,
                                  width: AppSizes.w1,
                                  child: MyNumberField(
                                    label: '',
                                    hint: '1',
                                    controller:
                                        cartController.controllers![index],
                                    onChange: (val) {
                                      if (val.isEmpty) {
                                      } else {
                                        cartController.updateQuantity(
                                            billInItem, int.parse(val));
                                      }
                                    },
                                    onSubmit: (val) {
                                      if (val.isEmpty) {
                                      } else {
                                        cartController.updateQuantity(
                                            billInItem, int.parse(val));
                                      }
                                    },
                                  ),
                                ),
                        ],
                      ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  billInItem.itemName.maxLength(18),
                  style: Get.textTheme.displayMedium,
                  textAlign: TextAlign.start,
                ),
                isAdmin == 1
                    ? Text(
                        '${MyStrings.itemPriceIn} : ${billInItem.itemPriceIn}',
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.start,
                      )
                    : Container(),
                isAdmin == 1
                    ? Text(
                        '${MyStrings.total} : ${cartController.supTotal[index].toString().maxLength(6)}',
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.start,
                      )
                    : Container(),
                inEdit
                    ? Text(
                        '${MyStrings.theNumber} : ${billInItem.itemCount}',
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.start,
                      )
                    : Text(
                        '${MyStrings.avilableQuantity} : ${billInItem.itemQuant}',
                        style: context.textTheme.displayMedium,
                        textAlign: TextAlign.start,
                      ),
                const Spacer(),
                inEdit
                    ? Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: AppSizes.h03,
                          width: AppSizes.w1,
                          child: MyNumberField(
                            label: '',
                            hint: '1',
                            controller: cartController.controllers![index],
                            onChange: (val) {
                              if (val.isNum) {
                                cartController.updateQuantity(
                                    billInItem, int.parse(val));
                              } else {}
                            },
                            onSubmit: (val) {
                              if (val.isEmpty) {
                              } else {
                                cartController.updateQuantity(
                                    billInItem, int.parse(val));
                              }
                            },
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cartController.removeOneProduct(
                                  billInItem, index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: context.theme.primaryColorDark,
                              size: AppSizes.h03,
                            ),
                          ),
                          isBack
                              ? SizedBox(
                                  height: AppSizes.h03,
                                  width: AppSizes.w1,
                                  child: MyNumberField(
                                    label: '',
                                    hint: '1',
                                    controller:
                                        cartController.controllers![index],
                                    onChange: (val) {
                                      if (val.isNum) {
                                        var quantityValue = int.parse(val);
                                        var quantity = billInItem.itemQuant;
                                        cartController.updateQuantity(
                                            billInItem, int.parse(val));
                                        if (quantity < quantityValue) {
                                          cartController.isOverd![index] = true;
                                        } else if (quantity >= quantityValue) {
                                          cartController.isOverd![index] =
                                              false;
                                        }
                                      }
                                    },
                                    onSubmit: (val) {
                                      if (val.isNum) {
                                        var quantityValue = int.parse(val);
                                        var quantity = billInItem.itemQuant;
                                        cartController.updateQuantity(
                                            billInItem, int.parse(val));
                                        if (quantity < quantityValue) {
                                          cartController.isOverd![index] = true;
                                        } else if (quantity >= quantityValue) {
                                          cartController.isOverd![index] =
                                              false;
                                        }
                                      }
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height: AppSizes.h03,
                                  width: AppSizes.w1,
                                  child: MyNumberField(
                                    label: '',
                                    hint: '1',
                                    controller:
                                        cartController.controllers![index],
                                    onChange: (val) {
                                      if (val.isEmpty) {
                                      } else {
                                        cartController.updateQuantity(
                                            billInItem, int.parse(val));
                                      }
                                    },
                                    onSubmit: (val) {
                                      if (val.isEmpty) {
                                      } else {
                                        cartController.updateQuantity(
                                            billInItem, int.parse(val));
                                      }
                                    },
                                  ),
                                ),
                        ],
                      ),
              ],
            ),
    );
  }
}
