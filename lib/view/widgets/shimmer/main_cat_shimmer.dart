// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// import '../../../core/constants/app_sizes.dart';

// class MainCatShimmer extends StatelessWidget {
//   const MainCatShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Shimmer.fromColors(
//             baseColor: Colors.black12,
//             highlightColor: Colors.black26,
//             enabled: true,
//             child: GridView.builder(
//               primary: false,
//               itemCount: 12,
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: AppSizes.h13,
//               ),
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     // CircleAvatar(
//                     //   radius: AppSizes.h03,
//                     // ),
//                     // SizedBox(
//                     //   height: AppSizes.h01,
//                     // ),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(AppSizes.h01),
//                         color: Colors.white,
//                       ),
//                       width: AppSizes.h1,
//                       height: AppSizes.h1,
//                     )
//                   ],
//                 );

//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(AppSizes.h01),
//                     color: Colors.white,
//                   ),
//                   width: AppSizes.w08,
//                   height: AppSizes.h01,
//                 );

//                 Container(
//                   height: AppSizes.h05,
//                   width: AppSizes.h05,
//                   padding: EdgeInsets.all(AppSizes.h01),
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset:
//                             const Offset(0, 1), // changes position of shadow
//                       ),
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(AppSizes.h01),
//                     // border: Border.all(width: 2, color: AppColorManger.grey),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
