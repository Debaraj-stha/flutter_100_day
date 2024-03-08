import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:ui' as ui;

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ImageCropper extends StatefulWidget {
  const ImageCropper({super.key});

  @override
  State<ImageCropper> createState() => _ImageCropperState();
}

class _ImageCropperState extends State<ImageCropper> {
  File? images;
  img.Image? image;
  img.Image? croppedImage;
  pickImage() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker != null) {
        images = File(picker.path);
        print("1");
        await loadByte();
        print("2");
        setState(() {});
      } else {
        print("not picked image");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Face>> detectFaces() async {
    final faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableLandmarks: true, // enable landmark
        enableContours: true,
        enableTracking: true,
        enableClassification: true));
    return await faceDetector.processImage(InputImage.fromFile(images!));
  }

  loadByte() async {
    try {
      print("3");
      final data = await images!.readAsBytes();
      final decodedData = img.decodeImage(data);
      setState(() {
        image = decodedData;
      });
      print("4");
    } catch (e) {
      print("Error loading bytes: $e");
    }
  }

  img.Image cropImage(img.Image originalImage, Face face) {
    Rect faceRect = face.boundingBox;
    int x = faceRect.left.toInt();
    int y = faceRect.top.toInt();
    int width = faceRect.width.toInt();
    int height = faceRect.height.toInt();
    return img.copyCrop(originalImage,
        x: x, y: y, width: width, height: height);
  }

  cropAndDisplayImage() async {
    try {
      List<Face> faces = await detectFaces();

      if (faces.isNotEmpty) {
        try {
          croppedImage = cropImage(image!, faces.first);
          final directory = await getExternalStorageDirectory();
          final filename = "${directory!.path}+cropped.png";
          File file = File(filename);

          file.writeAsBytesSync(Uint8List.fromList(croppedImage!.getBytes()));
        } catch (e) {
          print(e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        images != null
            ? Container(child: Image.file(images!))
            : const Icon(Icons.image),
        croppedImage != null
            ? Image.memory(Uint8List.fromList(img.encodePng(croppedImage!)))
            : Container(),
        TextButton(
            onPressed: () {
              pickImage();
            },
            child: const Text("Pick image")),
        TextButton(
            onPressed: () async {
              cropAndDisplayImage();
            },
            child: const Text("crop image"))
      ],
    )));
  }
}
