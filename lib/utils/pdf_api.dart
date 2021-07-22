import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfApi {
  static Future<File> generateImage(XFile imageFile) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(
      File(imageFile.path).readAsBytesSync(),
    );
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            buildBackground: (context) {
              return pw.FullPage(
                ignoreMargins: true,
                child: pw.Image(
                  image,
                  fit: pw.BoxFit.cover,
                ),
              );
            }),
        build: (pw.Context context) {
          // empty body but her can add watermark example
          return pw.SizedBox();
        },
      ),
    );

    return saveDocument(name: "pdf_example.pdf", pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationSupportDirectory();
    final file = File("${dir.path}/$name");

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
