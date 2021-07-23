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
  final _radius = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Image To PDF",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
          child: (_imageFile == null)
              ? const Text(
                  "Empty",
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 12.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_radius),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(_radius),
                            child: Image.file(
                              File(_imageFile!.path),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
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
