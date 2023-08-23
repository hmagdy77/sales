import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/works/work_item_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/items/item_model.dart';
import 'table_ciel.dart';

class WorkItemTable extends StatelessWidget {
  WorkItemTable({
    super.key,
    @required this.item,
    required this.isHeader,
    required this.index,
  });
  final bool isHeader;
  final Item? item;
  final int index;
  final WorkItemControllerImp itemController = Get.put(WorkItemControllerImp());
  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return Center(
        child: Row(
          children: const [
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 1,
              text: 'م',
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 4,
              text: MyStrings.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: MyStrings.itemNum,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: '${MyStrings.supName} & ${MyStrings.time}',
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.theNumber,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.thePrice,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.total,
            ),
          ],
        ),
      );
    } else {
      return Row(
        children: [
          MyCiel(
            isBack: false,
            isHeader: true,
            width: 1,
            text: (index + 1).toString(),
          ),
          MyCiel(
            isBack: item!.isBack == 1 ? true : false,
            isHeader: false,
            width: 4,
            text: item!.itemName,
          ),
          MyCiel(
            isBack: item!.isBack == 1 ? true : false,
            isHeader: false,
            width: 3,
            text: item!.itemNum,
          ),
          MyCiel(
            isBack: item!.isBack == 1 ? true : false,
            isHeader: false,
            width: 3,
            text: item!.isBack == 0 || item!.isBack == 1
                ? item!.itemSup
                : item!.itemPakage,
          ),
          MyCiel(
            isBack: item!.isBack == 1 ? true : false,
            isHeader: false,
            width: 2,
            text: item!.isBack == 0 || item!.isBack == 1
                ? itemController.converter(item: item!)
                : item!.itemCount.toString(),
          ),
          MyCiel(
            isBack: item!.isBack == 1 ? true : false,
            isHeader: false,
            width: 2,
            text: item!.itemPriceOut.toString(),
          ),
          MyCiel(
            isBack: item!.isBack == 1 ? true : false,
            isHeader: false,
            width: 2,
            text: (item!.itemPriceOut * item!.itemCount).toString(),
          ),
        ],
      );
    }
  }
}
