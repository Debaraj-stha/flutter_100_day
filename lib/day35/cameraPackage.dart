import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:google_ml_kit/google_ml_kit.dart';

import '../main.dart';

class ExploringCameras extends StatefulWidget {
  const ExploringCameras({super.key});

  @override
  _ExploringCamerasState createState() => _ExploringCamerasState();
}

class _ExploringCamerasState extends State<ExploringCameras> {
  late CameraController controller;
  late Future<void> initializeControllerFuture;
  XFile? imageFile;
  XFile? detectFile;
  List<Face> _faces = [];
  @override
  void initState() {
    super.initState();
    initializeControllerFuture = initializeCamera();
  }

  Future<void> initializeCamera() async {
    controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );

    await controller.initialize();
    controller.startImageStream((CameraImage image) async {
      if (detectFile == null) {
        await detectFace(image);
      }
    });
  }

  Future<void> detectFace(CameraImage image) async {
    final faceDetector = GoogleMlKit.vision.faceDetector();
    print(image.planes[0].toString());
    final inputImage = InputImage.fromBytes(
      bytes: image.planes[0].bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation90deg,
        bytesPerRow: image.planes[0].bytesPerRow,
        format: InputImageFormat.nv21,
      ),
    );
    _faces = await faceDetector.processImage(inputImage);
  }

  Future<void> takePicture() async {
    try {
      final XFile file = await controller.takePicture();
      setState(() {
        imageFile = file;
      });
    } catch (e) {
      print(e);
    }
  }

  changeCamera() async {
    CameraLensDirection des = controller.description.lensDirection;
    CameraLensDirection lensDirection = des == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;
    CameraDescription? newCamera;
    try {
      final camera = await availableCameras();
      if (des == CameraLensDirection.back) {
        newCamera = camera
            .firstWhere((element) => element.lensDirection == lensDirection);
      } else {
        newCamera = camera
            .firstWhere((element) => element.lensDirection == lensDirection);
      }
    } catch (e) {
      print("No camera available: $e");
    }
    if (newCamera != null) {
      controller.dispose();
      controller = CameraController(newCamera, ResolutionPreset.high);
      controller.initialize;
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Capture'),
      ),
      body: FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: imageFile == null
                      ? CameraPreview(controller)
                      : Image.file(File(imageFile!.path)),
                ),
                Row(
                  children: [
                    if (imageFile == null)
                      FloatingActionButton(
                        onPressed: () {
                          takePicture();
                        },
                        child: const Icon(Icons.camera),
                      ),
                    IconButton(
                        onPressed: () {
                          changeCamera();
                        },
                        icon: const Icon(Icons.switch_camera_rounded))
                  ],
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
