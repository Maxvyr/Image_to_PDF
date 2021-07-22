import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_pdf/views/pdf_generate_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: (_imageFile == null)
              ? const SelectableText(
                  "Empty",
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.file(
                        File(_imageFile!.path),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PdfGeneratePapge(_imageFile!),
                            ),
                          );
                        },
                        child: const Text(
                          'Go to pdf',
                        ),
                      ),
                    ],
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = image;
        print(_imageFile.toString());
      });
    } catch (e) {
      print(e);
    }
  }
}
