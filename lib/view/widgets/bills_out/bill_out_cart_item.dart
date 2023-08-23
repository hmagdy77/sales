import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/sub_string.dart';
import '../../../models/items/item_model.dart';
import '../text_fields/my_number_field.dart';

class BillOutCartItem extends StatelessWidget {
  BillOutCartItem(
      {Key? key,
      required this.index,
      required this.billOutItem,
      required this.quantity,
      required this.isBack,
      required this.inEdit})
      : super(key: key);
  final cartController = Get.put(BillOutCartControllerImp());
  final int index;
  final bool inEdit;
  final bool isBack;

  int quantity;
  final Item billOutItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: AppSizes.w01,
        left: AppSizes.w01,
        top: AppSizes.w01,
      ),
      padding: EdgeInsets.only(top: AppSizes.w01, right: AppSizes.w01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: cartController.isOverd![index]
              ? AppColorManger.primary
              : AppColorManger.grey),
      child: billOutItem.isBack == 2
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  billOutItem.itemName.maxLength(18),
                  style: Get.textTheme.displayLarge,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${MyStrings.total} : ${cartController.supTotal[index].toString().maxLength(6)}',
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${MyStrings.thePrice} : ${billOutItem.itemPriceOut}',
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${MyStrings.time} : ${billOutItem.itemPakage}',
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.start,
                ),
                inEdit
                    ? Text(
                        '${MyStrings.theNumber} : ${billOutItem.itemCount}',
                        style: context.textTheme.displayLarge,
                        textAlign: TextAlign.start,
                      )
                    : Container(),
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
                                    billOutItem, int.parse(val));
                              } else {}
                            },
                            onSubmit: (val) {
                              if (val.isEmpty) {
                              } else {
                                cartController.updateQuantity(
                                    billOutItem, int.parse(val));
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
                                  billOutItem, index);
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
                                      if (val.isEmpty) {
                                      } else {
                                        cartController.updateQuantity(
                                            billOutItem, int.parse(val));
                                      }
                                    },
                                    onSubmit: (val) {
                                      if (val.isEmpty) {
                                      } else {
                                        cartController.updateQuantity(
                                            billOutItem, int.parse(val));
                                      }
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height: AppSizes.h03,
                                  width: AppSizes.w1,
                                  child: MyNumberField(
                                    label: '',
                                    hint: quantity.toString(),
                                    controller:
                                        cartController.controllers![index],
                                    onChange: (val) {
                                      if (val.isNum) {
                                        // var quantityValue = int.parse(val);
                                        // var quantity = billOutItem.itemQuant;

                                        cartController.updateQuantity(
                                            billOutItem, int.parse(val));
                                        // if (quantity < quantityValue) {
                                        //   cartController.isOverd![index] = true;
                                        // } else if (quantity >= quantityValue) {
                                        //   cartController.isOverd![index] =
                                        //       false;
                                        // }
                                      }
                                    },
                                    onSubmit: (val) {
                                      if (val.isNum) {
                                        var quantityValue = int.parse(val);
                                        var quantity = billOutItem
                                            .itemQuant; //int.parse(billOutItem.itemQuant);
                                        cartController.updateQuantity(
                                            billOutItem, int.parse(val));
                                        if (quantity < quantityValue) {
                                          cartController.isOverd![index] = true;
                                        } else if (quantity >= quantityValue) {
                                          cartController.isOverd![index] =
                                              false;
                                        }
                                      }
                                    },
                                  ),
                                ),
                        ],
                      ),
              ],
            )
          : billOutItem.isBack == 3
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      billOutItem.itemName.maxLength(18),
                      style: Get.textTheme.displayLarge,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${MyStrings.total} : ${cartController.supTotal[index].toString().maxLength(6)}',
                      style: context.textTheme.displayLarge,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${MyStrings.thePrice} : ${billOutItem.itemPriceOut}',
                      style: context.textTheme.displayLarge,
                      textAlign: TextAlign.start,
                    ),
                    inEdit
                        ? Text(
                            '${MyStrings.theNumber} : ${billOutItem.itemCount}',
                            style: context.textTheme.displayLarge,
                            textAlign: TextAlign.start,
                          )
                        : Container(),
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
                                        billOutItem, int.parse(val));
                                  } else {}
                                },
                                onSubmit: (val) {
                                  if (val.isEmpty) {
                                  } else {
                                    cartController.updateQuantity(
                                        billOutItem, int.parse(val));
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
                                      billOutItem, index);
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
                                          if (val.isEmpty) {
                                          } else {
                                            cartController.updateQuantity(
                                                billOutItem, int.parse(val));
                                          }
                                        },
                                        onSubmit: (val) {
                                          if (val.isEmpty) {
                                          } else {
                                            cartController.updateQuantity(
                                                billOutItem, int.parse(val));
                                          }
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      height: AppSizes.h03,
                                      width: AppSizes.w1,
                                      child: MyNumberField(
                                        label: '',
                                        hint: quantity.toString(),
                                        controller:
                                            cartController.controllers![index],
                                        onChange: (val) {
                                          if (val.isNum) {
                                            cartController.updateQuantity(
                                                billOutItem, int.parse(val));
                                            // var quantityValue = int.parse(val);
                                            // var quantity =
                                            //     billOutItem.itemQuant;

                                            // if (quantity < quantityValue) {
                                            //   cartController.isOverd![index] =
                                            //       true;
                                            // } else if (quantity >=
                                            //     quantityValue) {
                                            //   cartController.isOverd![index] =
                                            //       false;
                                            // }
                                          }
                                        },
                                        onSubmit: (val) {
                                          if (val.isNum) {
                                            cartController.updateQuantity(
                                                billOutItem, int.parse(val));
                                            // var quantityValue = int.parse(val);
                                            // var quantity = billOutItem
                                            //     .itemQuant; //int.parse(billOutItem.itemQuant);

                                            // if (quantity < quantityValue) {
                                            //   cartController.isOverd![index] =
                                            //       true;
                                            // } else if (quantity >=
                                            //     quantityValue) {
                                            //   cartController.isOverd![index] =
                                            //       false;
                                            // }
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
                    billOutItem.isBack == 4
                        ? Text(
                            '${MyStrings.bikeNum} : ${billOutItem.itemNum}',
                            style: context.textTheme.displayLarge,
                          )
                        : Text(
                            billOutItem.itemName.maxLength(8),
                            style: Get.textTheme.displayLarge,
                            textAlign: TextAlign.start,
                          ),
                    Text(
                      '${MyStrings.total} : ${cartController.supTotal[index].toString().maxLength(6)}',
                      style: context.textTheme.displayLarge,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${MyStrings.itemPriceOut} : ${billOutItem.itemPriceOut}',
                      style: context.textTheme.displayLarge,
                      textAlign: TextAlign.start,
                    ),
                    inEdit
                        ? Container()
                        : Text(
                            '${MyStrings.avilableQuantity} : ${billOutItem.itemQuant}',
                            style: context.textTheme.displayLarge,
                            textAlign: TextAlign.start,
                          ),
                    inEdit
                        ? Text(
                            '${MyStrings.theNumber} : ${billOutItem.itemCount}',
                            style: context.textTheme.displayLarge,
                            textAlign: TextAlign.start,
                          )
                        : Container(),
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
                                        billOutItem, int.parse(val));
                                  } else {}
                                },
                                onSubmit: (val) {
                                  if (val.isEmpty) {
                                  } else {
                                    cartController.updateQuantity(
                                        billOutItem, int.parse(val));
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
                                      billOutItem, index);
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
                                          if (val.isEmpty) {
                                          } else {
                                            cartController.updateQuantity(
                                                billOutItem, int.parse(val));
                                          }
                                        },
                                        onSubmit: (val) {
                                          if (val.isEmpty) {
                                          } else {
                                            cartController.updateQuantity(
                                                billOutItem, int.parse(val));
                                          }
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      height: AppSizes.h03,
                                      width: AppSizes.w1,
                                      child: MyNumberField(
                                        label: '',
                                        hint: quantity.toString(),
                                        controller:
                                            cartController.controllers![index],
                                        onChange: (val) {
                                          if (val.isNum) {
                                            var quantityValue = int.parse(val);
                                            var quantity =
                                                billOutItem.itemQuant;
                                            cartController.updateQuantity(
                                                billOutItem, int.parse(val));
                                            if (quantity < quantityValue) {
                                              cartController.isOverd![index] =
                                                  true;
                                            } else if (quantity >=
                                                quantityValue) {
                                              cartController.isOverd![index] =
                                                  false;
                                            }
                                          }
                                        },
                                        onSubmit: (val) {
                                          if (val.isNum) {
                                            var quantityValue = int.parse(val);
                                            var quantity = billOutItem
                                                .itemQuant; //int.parse(billOutItem.itemQuant);
                                            cartController.updateQuantity(
                                                billOutItem, int.parse(val));
                                            if (quantity < quantityValue) {
                                              cartController.isOverd![index] =
                                                  true;
                                            } else if (quantity >=
                                                quantityValue) {
                                              cartController.isOverd![index] =
                                                  false;
                                            }
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
