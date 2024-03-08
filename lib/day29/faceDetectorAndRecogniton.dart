import 'package:flutter/material.dart';
import 'package:hundred_day/day29/cameraView.dart';
import 'package:hundred_day/day29/galleryView.dart';

class FaceDetectorAndRecognition extends StatefulWidget {
  const FaceDetectorAndRecognition({super.key});

  @override
  State<FaceDetectorAndRecognition> createState() =>
      _FaceDetectorAndRecognitionState();
}

class _FaceDetectorAndRecognitionState
    extends State<FaceDetectorAndRecognition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GalleryView()));
                  },
                  child: const Text("Gallery view")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CameraView()));
                  },
                  child: const Text("Camera view"))
            ],
          ),
        ),
      ),
    );
  }
}
