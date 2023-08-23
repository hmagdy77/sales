import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/items/item_controller.dart';
import '../../../core/class/pdf_bar_code.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/service/services.dart';
import '../../../models/bills/bill_model.dart';
import '../../../models/items/item_model.dart';
import '../public/dialouge.dart';
import '../public/my_button.dart';
import '../text_fields/my_number_field.dart';
import 'table_ciel.dart';

class MyTableItem extends StatelessWidget {
  MyTableItem({
    super.key,
    @required this.item,
    required this.isHeader,
    required this.isStock,
    this.bill,
  });
  final Item? item;
  final bool isHeader;
  final bool isStock;
  final Bill? bill;
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final MyService myService = Get.find();
  static GlobalKey previewContainer = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (isStock) {
      if (isHeader) {
        return Center(
          child: Row(
            children: [
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 4,
                text: MyStrings.itemName,
              ),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: MyStrings.itemNum,
              ),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: MyStrings.supName,
              ),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 2,
                text: MyStrings.theNumber,
              ),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: MyStrings.itemQuantity,
              ),
              myService.sharedPreferences.getInt(MyStrings.adminKey) == 1
                  ? const MyCiel(
                      isBack: false,
                      isHeader: true,
                      width: 2,
                      text: MyStrings.itemPriceIn,
                    )
                  : Container(),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 2,
                text: MyStrings.itemPriceOut,
              ),
              const MyCiel(
                isBack: false,
                isHeader: true,
                width: 2,
                text: MyStrings.barCode,
              ),
            ],
          ),
        );
      } else {
        return Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 4,
              text: item!.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemNum,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemSup,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemPiec,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: itemController.converter(item!),
            ),
            myService.sharedPreferences.getInt(MyStrings.adminKey) == 1
                ? MyCiel(
                    isBack: false,
                    isHeader: false,
                    width: 2,
                    text: item!.itemPriceIn.toString(),
                  )
                : Container(),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemPriceOut.toString(),
            ),
            Expanded(
              flex: 2,
              child: MyButton(
                text: MyStrings.print,
                onPressed: () {
                  myDialuge(
                    cancel: () {
                      Get.back();
                    },
                    confirmTitle: MyStrings.print,
                    cancelTitle: MyStrings.cancel,
                    confirm: () {
                      CustomPrinter.printBarCode(
                        data: item!.itemNum.toString(),
                        number: itemController.print.text.isEmpty
                            ? 1
                            : int.parse(itemController.print.text),
                      );
                      Get.back();
                      itemController.print.clear();
                    },
                    title: MyStrings.barCode,
                    middleText: '',
                    content: MyNumberField(
                      label: MyStrings.numberOfPrint,
                      hint: '',
                      controller: itemController.print,
                      onChange: (value) {},
                      onSubmit: (value) {
                        CustomPrinter.printBarCode(
                          data: item!.itemNum.toString(),
                          number: itemController.print.text.isEmpty
                              ? 1
                              : int.parse(itemController.print.text),
                        );
                        Get.back();
                        itemController.print.clear();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    } else {
      if (isHeader) {
        return Center(
            child: Row(
          children: [
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 4,
              text: MyStrings.itemName,
            ),
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: MyStrings.itemNum,
            ),
            bill!.isBack == 2
                ? const MyCiel(
                    isBack: false,
                    isHeader: true,
                    width: 3,
                    text: MyStrings.time,
                  )
                : bill!.isBack == 1 || bill!.isBack == 0
                    ? const MyCiel(
                        isBack: false,
                        isHeader: true,
                        width: 3,
                        text: MyStrings.supName,
                      )
                    : Container(),
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.itemQuantity,
            ),
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.thePrice,
            ),
            const MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.total,
            ),
          ],
        ));
      } else {
        return Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 4,
              text: item!.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemNum,
            ),
            bill!.isBack == 2
                ? MyCiel(
                    isBack: false,
                    isHeader: false,
                    width: 3,
                    text: item!.itemPakage,
                  )
                : bill!.isBack == 1 || bill!.isBack == 0
                    ? MyCiel(
                        isBack: false,
                        isHeader: false,
                        width: 3,
                        text: item!.itemSup,
                      )
                    : Container(),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemCount.toString(),
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemPriceOut.toString(),
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: (item!.itemPriceOut * item!.itemCount).toString(),
            ),
          ],
        );
      }
    }
  }
}
