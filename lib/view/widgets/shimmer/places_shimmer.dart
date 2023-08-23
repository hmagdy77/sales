// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// import '../../../core/constants/app_sizes.dart';

// class PlacesShimmer extends StatelessWidget {
//   const PlacesShimmer({super.key});

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
//               baseColor: Colors.black12,
//               highlightColor: Colors.black26,
//               enabled: true,
//               child: ListView.builder(
//                 itemCount: 12,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(AppSizes.h01),
//                       border: Border.all(color: Colors.amber, width: 2),
//                     ),
//                     height: AppSizes.h1,
//                     margin: EdgeInsets.all(AppSizes.h01),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
