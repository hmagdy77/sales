import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/works/work_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/works/work_model.dart';
import '../items/table_ciel.dart';

class MyTableWork extends StatelessWidget {
  MyTableWork({super.key, @required this.work, required this.isHeader});
  final Work? work;
  final bool isHeader;
  final WorkControllerImp workController = Get.find<WorkControllerImp>();

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return Center(
        child: Row(
          children: const [
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: MyStrings.workeNum,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: MyStrings.startWorke,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: MyStrings.endWorke,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: MyStrings.cashierName,
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
            isHeader: false,
            width: 2,
            text: work!.workId.toString(),
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 3,
            text:
                '${DateFormat.yMMMEd().format(work!.workStart)}  ${DateFormat.jm().format(work!.workStart)}',
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 3,
            text: work!.workClosed == 1
                ? '${DateFormat.yMMMEd().format(work!.workEnd)}  ${DateFormat.jm().format(work!.workEnd)}'
                : MyStrings.currentWork,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 3,
            text: work!.workName,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: work!.workTotal.toString(),
          ),
        ],
      );
    }
  }
}
