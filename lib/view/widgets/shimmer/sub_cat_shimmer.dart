// import 'package:flutter/material.dart';
 
// import '../../../core/constants/app_sizes.dart';

// class SubCatShimmer extends StatelessWidget {
//   const SubCatShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Expanded(
//             child: Shimmer.fromColors(
//                 baseColor: Colors.black12,
//                 highlightColor: Colors.black26,
//                 enabled: true,
//                 child: GridView.builder(
//                     itemCount: 12,
//                     shrinkWrap: true,
//                     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                       maxCrossAxisExtent: AppSizes.h17,
//                     ),
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(AppSizes.h01),
//                               color: Colors.white,
//                             ),
//                             width: AppSizes.w1,
//                             height: AppSizes.h1,
//                           ),
//                         ],
//                       );
//                     })),
//           ),
//         ],
//       ),
//     );
//   }
// }
