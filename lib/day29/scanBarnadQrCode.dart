import 'dart:io';


import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  File? file;

  List<Barcode> barcode = [];
  String barcodevalue = "";
  pickAndScandCode() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker != null) {
        file = File(picker.path);

        final scanner = GoogleMlKit.vision.barcodeScanner();
        barcode = await scanner.processImage(InputImage.fromFile(file!));
        barcodevalue = barcode[0].displayValue.toString();
        setState(() {});
      }
    } catch (e) {
      print("Exceprtion $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            file != null
                ? Container(
                    child: Image.file(
                      File(file!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    child: const Icon(
                      Icons.image,
                      size: 100,
                    ),
                  ),
            TextButton(
                onPressed: () async {
                  await pickAndScandCode();
                },
                child: const Text("Pick and scan code")),
            Text("Barcode value is $barcodevalue"),
          ],
        ),
      )),
    );
  }
}
