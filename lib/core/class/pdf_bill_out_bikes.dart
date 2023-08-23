import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import '../constants/app_strings.dart';

const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<void> printBillOutBikes({
  required List<List<String>> items,
  required String billNumber,
  required String billLenth,
  required String billDate,
  required String billTime,
  required double billTotal,
  required double billPaid,
  required double billDiscount,
  required String agentName,
  required String agentPhone,
  required String workNum,
  required String casherName,
  required int isBack,
}) async {
  final Document pdf = Document();
// pdf_bikes
  var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/arabic.ttf"));
  final profileImage = MemoryImage(
    (await rootBundle.load('assets/images/logo.jpg')).buffer.asUint8List(),
  );
  final qrImage = MemoryImage(
    (await rootBundle.load('assets/images/qr.png')).buffer.asUint8List(),
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
                //for height
                SizedBox(height: 3),
                // //bill details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // width: 100,
                          child: Column(
                            children: [
                              // workeNum
                              Row(
                                children: [
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Center(
                                      child: Text(
                                        '${MyStrings.workeNum} :  $workNum',
                                        style: const TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // numberOfSaleditems
                              Row(
                                children: [
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Center(
                                      child: Text(
                                        '${MyStrings.numberOfSaleditems} :  $billLenth',
                                        style: const TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // billDate
                              Row(
                                children: [
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Center(
                                      child: Text(
                                        '${MyStrings.date} :  $billDate',
                                        style: const TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // agentPhone
                              Row(
                                children: [
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Center(
                                      child: Text(
                                        '${MyStrings.agentPhone} : $agentPhone',
                                        style: const TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Container(
                          // width: 80,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Center(
                                      child: Text(
                                        '${MyStrings.billNumper} :  $billNumber',
                                        style: const TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Center(
                                      child: Text(
                                        '${MyStrings.cashier} :  $casherName',
                                        style: const TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Center(
                                      child: Text(
                                        '${MyStrings.time} :  $billTime',
                                        style: const TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Center(
                                      child: Text(
                                        '${MyStrings.agentName} : $agentName',
                                        style: const TextStyle(
                                          fontSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //for height
                SizedBox(height: 3),
                Row(
                  children: [
                    SizedBox(width: 4),
                    Spacer(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(
                        child: Text(
                          '${MyStrings.opreation} : ${MyStrings.bikeBillOut}',
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
                      //  <List<dynamic>>[
                      //   items,
                      // ],
                    ),
                  ),
                ),
                //for height
                SizedBox(height: 5),
                billDiscount != 0
                    ? //the table
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Table.fromTextArray(
                            border: TableBorder.all(
                              width: 2,
                              color: PdfColor.fromHex('#000000'),
                            ),
                            headerStyle: const TextStyle(
                              fontSize: 8,
                            ),
                            headerAlignment: Alignment.center,
                            headers: <dynamic>[
                              MyStrings.unPaid,
                              MyStrings.paid,
                              MyStrings.safy,
                              MyStrings.discount,
                              MyStrings.total,
                            ],
                            cellAlignment: Alignment.center,
                            cellStyle: const TextStyle(
                              fontSize: 6,
                            ),
                            data: <List<dynamic>>[
                              [
                                (billPaid - (billTotal - billDiscount)),
                                billPaid,
                                (billTotal - billDiscount),
                                billDiscount,
                                billTotal,
                              ],
                            ],
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // values
                          Column(
                            children: [
                              //bill discount value
                              Container(
                                height: 14,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: PdfColor.fromHex('#D3D3D3'),
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
                              //billPaid
                              Container(
                                height: 14,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: PdfColor.fromHex('#D3D3D3'),
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
                                      billPaid.toString(),
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
                              // billUnPaid
                              Container(
                                height: 14,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: PdfColor.fromHex('#D3D3D3'),
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
                                      billDiscount != 0
                                          ? (billPaid -
                                                  billTotal -
                                                  billDiscount)
                                              .toString()
                                          : (billPaid - billTotal).toString(),
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
                              //bill discount label
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
                              //for height
                              SizedBox(height: 3),
                              //bill billPay14
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Center(
                                  child: Text(
                                    MyStrings.paid,
                                    style: const TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                              //for height
                              SizedBox(height: 3),
                              // billEndTotal
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Center(
                                  child: Text(
                                    MyStrings.unPaid,
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
                //for height
                SizedBox(height: 5),
                //address Container
                Container(
                  color: PdfColor.fromHex('#000000'),
                  height: 48,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          MyStrings.addressWheels,
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          MyStrings.addressWheels2,
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          MyStrings.phoneWheels1,
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex('#FFFFFF'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //for height
                SizedBox(height: 5),
                // substitution
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      ' ${MyStrings.substitution}',
                      style: const TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
                // in14Days
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      ' ${MyStrings.in14Days}',
                      style: const TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
                // in30Days
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      ' ${MyStrings.in30Days}',
                      style: const TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
                // changeBike1
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      ' ${MyStrings.changeBike1}',
                      style: const TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
                // changeBike2
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      ' ${MyStrings.changeBike2}',
                      style: const TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
                // //for height
                SizedBox(height: 5),
                // qr cod image
                Container(
                  height: 70,
                  width: double.infinity,
                  child: Image(
                    qrImage,
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

// Center(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       //casher and bill num
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(width: 4),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Center(
//                               child: Text(
//                                 '${MyStrings.cashier} :  $casherName',
//                                 style: const TextStyle(
//                                   fontSize: 6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Center(
//                               child: Text(
//                                 '${MyStrings.workeNum} :  $workNum',
//                                 style: const TextStyle(
//                                   fontSize: 6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 4),
//                         ],
//                       ),
//                       //for height
//                       SizedBox(height: 3),
//                       //casher and bill num
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(width: 4),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Center(
//                               child: Text(
//                                 '${MyStrings.numberOfSaleditems} :  $billLenth',
//                                 style: const TextStyle(
//                                   fontSize: 6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Center(
//                               child: Text(
//                                 '${MyStrings.billNumper} :  $billNumber',
//                                 style: const TextStyle(
//                                   fontSize: 6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 4),
//                         ],
//                       ),
//                       //for height
//                       SizedBox(height: 3),
//                       //date and time
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(width: 4),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Center(
//                               child: Text(
//                                 '${MyStrings.time} :  $billTime',
//                                 style: const TextStyle(
//                                   fontSize: 6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Center(
//                               child: Text(
//                                 '${MyStrings.date} :  $billDate',
//                                 style: const TextStyle(
//                                   fontSize: 6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 4),
//                         ],
//                       ),
//                       //for height
//                       SizedBox(height: 3),
//                       //agent name and phone
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(width: 4),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Center(
//                               child: Text(
//                                 '${MyStrings.agentPhone} : $agentPhone',
//                                 style: const TextStyle(
//                                   fontSize: 6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Center(
//                               child: Text(
//                                 '${MyStrings.agentName} : $agentName',
//                                 style: const TextStyle(
//                                   fontSize: 6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 4),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
