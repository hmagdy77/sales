import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../widgets/menus/upper_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final BillInControllerImp mainController = Get.put(BillInControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(
            isAdminScreen: false,
            onPressed: () {},
          ),
          const Expanded(
            child: Image(
              image: AssetImage('assets/images/home.png'),
            ),
          ),
        ],
      ),
    );
  }
}

//  return Obx(
//       () {
//         return Scaffold(
//           // backgroundColor: Colors.white,
//           body: SafeArea(
//             child: Column(
//               children: [
//                 //upper widget flex: 3,
//                 Container(
//                   //width: double.infinity,
//                   //height: AppSizes.h25,
//                   color: Colors.transparent, //AppColorManger.primary,
//                   // padding: EdgeInsets.all(
//                   //   AppSizes.w02,
//                   // ),
//                   child: Row(
//                     children: [
//                       ItemsMenu(mainController: mainController),
//                       SupMenu(mainController: mainController),
//                       BillOutMenu(mainController: mainController),
//                       BillInMenu(mainController: mainController),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           MyStrings.logOut,
//                           style: context.textTheme.titleMedium,
//                         ),
//                       ),
//                       const Spacer(
//                         flex: 2,
//                       ),
//                     ],
//                   ),
//                 ),

//                 //  body flex: 7,
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       top: AppSizes.h05,
//                       right: AppSizes.w1,
//                       left: AppSizes.w1,
//                     ),
//                     child: bodyContent(mainController),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
