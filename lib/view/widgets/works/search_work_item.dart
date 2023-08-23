// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../core/constants/app_color_manger.dart';
// import '../../../core/constants/app_sizes.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../models/works/work_model.dart';

// class SearchWorkItem extends StatelessWidget {
//   const SearchWorkItem({super.key, required this.work});
//   final Work work;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: AppSizes.h05,
//       padding: EdgeInsets.symmetric(horizontal: AppSizes.w05),
//       color: AppColorManger.grey,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '${MyStrings.workeNum} : ${work.workId}',
//             style: context.textTheme.displayLarge,
//           ),
//           Text(
//             '${MyStrings.startWorke} : ${DateFormat.yMMMEd().format(work.workStart)}  ${DateFormat.jm().format(work.workStart)}',
//             style: context.textTheme.displayLarge,
//           ),
//           Text(
//             '${MyStrings.endWorke} : ${DateFormat.yMMMEd().format(work.workEnd)}  ${DateFormat.jm().format(work.workEnd)}',
//             style: context.textTheme.displayLarge,
//           ),
//           Text(
//             '${MyStrings.cashierName} : ${work.workName}',
//             style: context.textTheme.displayLarge,
//           ),
//           Text(
//             '${MyStrings.total} : ${work.workTotal}',
//             style: context.textTheme.displayLarge,
//           ),
//         ],
//       ),
//     );
//   }
// }
