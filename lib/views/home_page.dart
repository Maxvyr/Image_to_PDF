import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_pdf/utils/pdf_api.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _imageFile;

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
            ? ViewImageEmpty(
                callback: _pickImage,
              )
            : ViewImageSelected(_imageFile!),
      ),
      floatingActionButton: (_imageFile == null)
          ? FloatingActionButton.extended(
              onPressed: _pickImage,
              tooltip: 'Increment',
              label: Row(
                children: [
                  const Icon(Icons.add),
                  const Text("Choix de l'image"),
                ],
              ),
            )
          : FloatingActionButton(
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
      });
    } catch (e) {
      print(e);
    }
  }
}

class ViewImageEmpty extends StatelessWidget {
  final VoidCallback callback;

  ViewImageEmpty({required this.callback});

  @override
  Widget build(BuildContext context) {
    const _radius = 50.0;
    return InkWell(
      onTap: callback,
      child: Card(
        elevation: 12.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius),
            child: Image.asset(
              "assets/img/empty.jpg",
            ),
          ),
        ),
      ),
    );
  }
}

class ViewImageSelected extends StatelessWidget {
  final XFile imageFile;
  const ViewImageSelected(this.imageFile);

  @override
  Widget build(BuildContext context) {
    const _radius = 50.0;
    return SingleChildScrollView(
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
                  File(imageFile.path),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () async {
              final pdfFile = await PdfApi.generateImage(imageFile);
              PdfApi.openFile(pdfFile);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: const Center(
                child: Text(
                  "Go to pdf",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
