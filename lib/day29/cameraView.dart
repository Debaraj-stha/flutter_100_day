import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? file;
  List<Face> faces = [];
  ui.Image? image;
  void captureAndDetectFace() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        file = File(image.path);
        _loadImaqge(file!);
        detectImage();
        setState(() {});
      } else {
        print("No  image is picked");
      }
    } catch (e) {
      print("Exception:$e ");
    }
  }

  _loadImaqge(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then((value) {
      image = value;
    });
  }

  detectImage() async {
    InputImage inputImage = InputImage.fromFile(File(file!.path));
    final faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
        performanceMode: FaceDetectorMode.fast,
        enableLandmarks: true,
        enableClassification: true,
        enableContours: true,
        enableTracking: true));
    faces = await faceDetector.processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
                faces.isNotEmpty?FittedBox(child: SizedBox(
                  width: image!.width.toDouble(),
                  height: image!.height.toDouble(),
                  child: CustomPaint(painter: FacePainter(faces, image!)),
                ),):Container(),
          TextButton(
              onPressed: () {
                captureAndDetectFace();
              },
              child: const Text("Capture and detect face"))
        ],
      )),
    );
  }
}

class FacePainter extends CustomPainter {
  ui.Image image;
  List<Rect> rect = [];
  List<Face> faces = [];
  FacePainter(this.faces, this.image) {
    for (var i = 0; i < faces.length; i++) {
      rect.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawImage(image, Offset.zero, paint);
    for (var i = 0; i < faces.length; i++) {
      canvas.drawRect(rect[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || image != oldDelegate.faces;
  }
}
