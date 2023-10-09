import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ReconizeText extends StatefulWidget {
  const ReconizeText({super.key});

  @override
  State<ReconizeText> createState() => _ReconizeTextState();
}

class _ReconizeTextState extends State<ReconizeText> {
  bool isTextToString = false;
  File? image;
  String scannedText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Reconizer"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isTextToString) const CircularProgressIndicator(),
              Container(
                height: 300,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: !isTextToString && image != null
                    ? Container(
                        child: Image(image: FileImage(File(image!.path))))
                    : Container(),
              ),
              const SizedBox(height: 10),
              Text(scannedText),
              TextButton(
                  onPressed: () {
                    pickimage();
                  },
                  child: const Text("Pick image from gallery"))
            ],
          ),
        ),
      ),
    );
  }

  void pickimage() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          isTextToString = true;
          image = File(file.path);
        });
        detectText(image!);
      }
    } catch (e) {
      isTextToString = false;
      image = null;
      scannedText = "Error while reconizing text";
    }
  }

  void detectText(File file) async {
    final inputImage = InputImage.fromFile(file);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText == "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        print(line.text);
        scannedText = "$scannedText${line.text}\n";
      }
    }
    isTextToString = false;
    setState(() {});
  }
}
