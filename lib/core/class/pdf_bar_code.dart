import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class CustomPrinter {
  final pdf = Document();

  static printBarCode({required String data, required int number}) {
    Printing.layoutPdf(
      onLayout: (format) {
        final doc = Document();
        doc.addPage(
          Page(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // pageFormat: PdfPageFormat.roll80
            pageFormat: PdfPageFormat.roll57,
            build: (Context context) => Column(
              children: [
                SizedBox(height: 8),
                for (int i = 0; i < number; i++)
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(4),
                    child: BarcodeWidget(
                      color: PdfColor.fromHex("#000000"),
                      barcode: Barcode.code39(),
                      data: data,
                      height: 30,
                      width: 80,
                      textStyle: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
        return doc.save();
      },
    );
  }

//  https://stackoverflow.com/questions/61679628/flutter-pdf-error-this-widget-created-more-than-20-pages-this-may-be-an-i
}
