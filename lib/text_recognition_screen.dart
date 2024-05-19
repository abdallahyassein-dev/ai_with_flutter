import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({super.key});

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  File? _image;
  final picker = ImagePicker();

  String textRecoginized = "";
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await readTextFromImage();
      setState(() {});
    }
  }

  Future<void> readTextFromImage() async {
    final inputImage = InputImage.fromFile(_image!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecoginized = recognizedText.text;

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Recognition')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    getImageFromGallery();
                  },
                  icon: const Icon(
                    Icons.document_scanner_outlined,
                    size: 100,
                  )),
              _image != null ? Image.file(_image!) : const SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              textRecoginized.isNotEmpty
                  ? Text(
                      textRecoginized,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
