import 'package:flutter/material.dart';
import 'package:image_to_pdf/utils/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_picker/image_picker.dart';

class PdfGeneratePapge extends StatefulWidget {
  final XFile imageFile;
  PdfGeneratePapge(this.imageFile);

  @override
  _PdfGeneratePapgeState createState() => _PdfGeneratePapgeState();
}

class _PdfGeneratePapgeState extends State<PdfGeneratePapge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdfFile = await PdfApi.generateImage(widget.imageFile);
            PdfApi.openFile(pdfFile);
          },
          child: const Text("PDF"),
        ),
      ),
    );
  }
}
