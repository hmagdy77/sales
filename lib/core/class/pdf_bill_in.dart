import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../constants/app_strings.dart';

const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<void> printBillIn({
  required List<List<String>> items,
  required String billNumber,
  required String billLenth,
  required String billDate,
  required String billTime,
  required double billTotal,
  required double billPayment,
  required String billNotes,
  required String supName,
  required int isBack,
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
                    Row(
                      children: [
                        SizedBox(width: 4),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Text(
                              '${MyStrings.supName} : $supName',
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
                              '${MyStrings.billNumper} : $billNumber',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 4),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Text(
                              '${MyStrings.time} :  $billTime',
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
                              '${MyStrings.date} :  $billDate',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 4),
                        Spacer(),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Text(
                              isBack == 0
                                  ? '${MyStrings.opreation} : ${MyStrings.billIn}'
                                  : '${MyStrings.opreation} : ${MyStrings.backBillIn}',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
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
                      fontSize: 6,
                    ),
                    headerAlignment: Alignment.center,
                    headers: <dynamic>[
                      MyStrings.total,
                      MyStrings.theNumber,
                      MyStrings.thePrice,
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
              //for height
              SizedBox(height: 5),
              //the prices table
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // values
                  Column(
                    children: [
                      //bill total
                      Container(
                        height: 14,
                        width: 80,
                        decoration: BoxDecoration(
                          // color: PdfColor.fromHex('#D3D3D3'),
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              width: 1,
                              color: PdfColor.fromHex('#000000'),
                            ),
                          ),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Text(
                              billTotal.toString(),
                              style: TextStyle(
                                fontSize: 8,
                                color: PdfColor.fromHex('#000000'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //for height
                      SizedBox(height: 3),
                      //bill payment
                      Container(
                        height: 14,
                        width: 80,
                        decoration: BoxDecoration(
                          // color: PdfColor.fromHex('#D3D3D3'),
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              width: 1,
                              color: PdfColor.fromHex('#000000'),
                            ),
                          ),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Text(
                              billPayment.toString(),
                              style: TextStyle(
                                fontSize: 8,
                                color: PdfColor.fromHex('#000000'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //for height
                      SizedBox(height: 3),
                      // notes
                      Container(
                        height: 14,
                        width: 80,
                        decoration: BoxDecoration(
                          // color: PdfColor.fromHex('#D3D3D3'),
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              width: 1,
                              color: PdfColor.fromHex('#000000'),
                            ),
                          ),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Center(
                            child: Text(
                              (billTotal + billPayment).toString(),
                              style: TextStyle(
                                fontSize: 8,
                                color: PdfColor.fromHex('#000000'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //for width
                  SizedBox(width: 5),
                  // labels
                  Column(
                    children: [
                      //bill total
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Center(
                          child: Text(
                            MyStrings.billTotal,
                            style: const TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                      //for height
                      SizedBox(height: 3),
                      //bill payment
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Center(
                          child: Text(
                            MyStrings.billPayment,
                            style: const TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                      //for height
                      SizedBox(height: 3),
                      // total
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Center(
                          child: Text(
                            MyStrings.total,
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
            ],
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
