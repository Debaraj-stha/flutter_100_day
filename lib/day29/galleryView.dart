import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  ui.Image? iimage;
  List<Face> faceses = [];
  pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _image = File(pickedImage.path);

        await _loadImage(_image!);
        await detectFace();
        setState(() {});
      } else {
        print("no image is picked");
      }
    } catch (e) {
      print("Exception $e");
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    print("data $data");
    await decodeImageFromList(data).then((value) {
      iimage = value;
      print("image value:$value ");
    });
  }

  detectFace() async {
    InputImage inputImage = InputImage.fromFile(_image!);
    final faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableLandmarks: true, // enable landmark
        enableContours: true,
        enableTracking: true,
        enableClassification: true));
    faceses = await faceDetector.processImage(inputImage);
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
            _image != null
                ? Container(
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    child: const Icon(
                      Icons.image,
                      size: 100,
                    ),
                  ),
            faceses.isNotEmpty
                ? FittedBox(
                    child: SizedBox(
                      width: iimage?.width.toDouble(),
                      height: iimage?.height.toDouble(),
                      child: CustomPaint(
                        painter: FacePainter(iimage!, faceses),
                      ),
                    ),
                  )
                : Container(),
            faceses.isNotEmpty
                ? Text(
                    "Number of detected faces is ${faceses.length.toString()}")
                : const Text("no face detected"),
            TextButton(
                onPressed: () {
                  pickImage();
                },
                child: const Text("Pick Image and detect face")),
          ],
        ),
      )),
    );
  }
}

class FacePainter extends CustomPainter {
  ui.Image image;
  List<Face> faces;
  List<Rect> boundingBoxes = [];
  List<Map<FaceContourType, FaceContour?>> contours = [];
  List<Map<FaceLandmarkType, FaceLandmark?>> landmarks = []; //landmark
  FacePainter(this.image, this.faces) {
    for (var face in faces) {
      boundingBoxes.add(face.boundingBox);
      contours.add(face.contours);
      landmarks.add(face.landmarks);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint boundingBoxPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.blue;

    final Paint contourPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.blue;
    final Paint landmarkPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    Paint smilePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawImage(image, Offset.zero, Paint()); //draw rectangle around face
//draw facecontour
    for (var i = 0; i < faces.length; i++) {
      print(faces[i].toString());

      canvas.drawRect(boundingBoxes[i], boundingBoxPaint);
      double? smileDetecyed = faces[i].smilingProbability;
      if (smileDetecyed != null && smileDetecyed >= 0.5) {
        print("\n\n\nsmile detected with probability $smileDetecyed");
        // canvas.drawArc(
        //     faces[i].boundingBox, 0, pi, false, smilePaint); //draw arc
      } else {
        print("\n\n\nno smile is detectected $smileDetecyed");
      }
      final faceContour = contours[i];
      for (var faceContourType in faceContour.keys) {
        final contour = faceContour[faceContourType];
        final points = contour!.points;
        if (points.isNotEmpty) {
          canvas.drawPoints(
              ui.PointMode.points,
              points
                  .map((e) => Offset(e.x.toDouble(), e.y.toDouble()))
                  .toList(),
              contourPaint);
        }
      }
      //draw facelandmarks
      for (var i = 0; i < faces.length; i++) {
        final faceLandmark = landmarks[i];
        for (var landmarkType in faceLandmark.keys) {
          final landmark = faceLandmark[landmarkType];
          final points = landmark?.position;
          if (points != null) {
            canvas.drawPoints(
                ui.PointMode.points,
                [Offset(points.x.toDouble(), points.y.toDouble())],
                landmarkPaint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
