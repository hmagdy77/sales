import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../constants/app_strings.dart';

// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:printing/printing.dart';

// import '../constants/app_strings.dart';

const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<void> printStock({
  required List<List<String>> items,
  required String lenth,
  required String date,
  required String time,
  required String opreation,
}) async {
  final Document pdf = Document();

  var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/arabic.ttf"));
  final profileImage = MemoryImage(
    (await rootBundle.load('assets/images/logo.jpg')).buffer.asUint8List(),
  );

  pdf.addPage(
    Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.roll80,
      build: (Context context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //image
                Container(
                  height: 70,
                  width: double.infinity,
                  child: Image(profileImage, fit: BoxFit.fill),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Text(
                                '${MyStrings.time} : $time',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Text(
                                '${MyStrings.date} : $date',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Text(
                                '${MyStrings.numberOfitems} : $lenth',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Text(
                                '${MyStrings.opreation} : ${opreation}',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //for height
                SizedBox(height: 3),
                //the table
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Table.fromTextArray(
                      headerStyle: const TextStyle(
                        fontSize: 6,
                      ),
                      headerAlignment: Alignment.center,
                      headers: <dynamic>[
                        MyStrings.itemQuantity,
                        MyStrings.itemNum,
                        MyStrings.itemName,
                      ],
                      cellAlignment: Alignment.center,
                      cellStyle: const TextStyle(
                        fontSize: 6,
                      ),
                      data: items,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}



// class PrintStock {
//   final pdf = Document();

//   static printStock({
//     required List<List<String>> items,
//     required String lenth,
//     required String date,
//     required String time,
//   }) async {
//     var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/arabic.ttf"));

//     Printing.layoutPdf(
//       format: PdfPageFormat.roll80,
//       dynamicLayout: true,
//       usePrinterSettings: true,
//       onLayout: (format) {
//         final doc = Document();
//         doc.addPage(
//           MultiPage(
//             theme: ThemeData.withFont(
//               base: arabicFont,
//             ),
//             header: (context) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 1),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Center(
//                             child: Text(
//                               '${MyStrings.time} : $time',
//                               style: const TextStyle(
//                                 fontSize: 8,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Center(
//                             child: Text(
//                               '${MyStrings.date} : $date',
//                               style: const TextStyle(
//                                 fontSize: 8,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Center(
//                             child: Text(
//                               '${MyStrings.numberOfitems} : $lenth',
//                               style: const TextStyle(
//                                 fontSize: 8,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Center(
//                             child: Text(
//                               '${MyStrings.opreation} : ${MyStrings.stockCheck}',
//                               style: const TextStyle(
//                                 fontSize: 8,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//             build: (Context context) => <Widget>[
//               for (int i = 0; i < items.length; i++)
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
//                   child: Row(
//                     children: [
//                       Container(
//                           width: 40,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               width: 1,
//                               color: PdfColors.black,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               items[i][0],
//                               style: const TextStyle(fontSize: 6),
//                               textDirection: TextDirection.rtl,
//                             ),
//                           )),
//                       Container(
//                           width: 20,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               width: 1,
//                               color: PdfColors.black,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               items[i][1],
//                               style: const TextStyle(fontSize: 6),
//                               textDirection: TextDirection.rtl,
//                             ),
//                           )),
//                       Container(
//                         width: 60,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             width: 1,
//                             color: PdfColors.black,
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             items[i][2],
//                             style: const TextStyle(fontSize: 6),
//                             textDirection: TextDirection.rtl,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//             ],
//           ),
//         );
//         return doc.save();
//       },
//     );
//   }

// //  https://stackoverflow.com/questions/61679628/flutter-pdf-error-this-widget-created-more-than-20-pages-this-may-be-an-i
// }
