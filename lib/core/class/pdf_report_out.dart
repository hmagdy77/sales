// CreateArabicPdf

import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../constants/app_strings.dart';

Future<void> printreportOut({
  // required List<String> fristRow,
  // required List<String> secondRow,
  required String billOut,
  required String backBillOut,
  required String rent,
  required String fix,
  required String bikesSales,
  required String bikesBackSales,
  required String workesSafy,
  required String workesPayment,
  required String date,
  required String kind,
  required String startDate,
  required String endDate,
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
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //image
              Container(
                height: 70,
                width: double.infinity,
                child: Image(profileImage, fit: BoxFit.fill),
              ),
              //for height
              SizedBox(height: 3),
              Center(
                child: Column(
                  children: [
                    // date and opreation
                    Row(
                      children: [
                        SizedBox(width: 4),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Text(
                              date,
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
                              '${MyStrings.opreation} : $kind',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                    ),
                    // startDate and endDate
                    Row(
                      children: [
                        SizedBox(width: 4),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Text(
                              '${MyStrings.to} : $endDate',
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
                              '${MyStrings.from} : $startDate ',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
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
                      fontSize: 8,
                    ),
                    headerAlignment: Alignment.center,
                    headers: <dynamic>[
                      MyStrings.theValue,
                      MyStrings.reportKind,
                    ],
                    cellAlignment: Alignment.center,
                    cellStyle: const TextStyle(
                      fontSize: 6,
                    ),
                    data: [
                      [billOut, MyStrings.billOut],
                      [backBillOut, MyStrings.theValue],
                      [bikesSales, MyStrings.bikesSales],
                      [bikesBackSales, MyStrings.bikesBackSales],
                      [rent, MyStrings.rent],
                      [fix, MyStrings.fix],
                      [workesSafy, MyStrings.workesSafy],
                      [workesPayment, MyStrings.workesPayment],

                      // thirdRow,
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3),

              // Spacer(),
            ],
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
