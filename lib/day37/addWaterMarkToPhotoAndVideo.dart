import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'package:video_watermark/video_watermark.dart';

class WaterMarkToPhotoVideo extends StatefulWidget {
  const WaterMarkToPhotoVideo({super.key});

  @override
  State<WaterMarkToPhotoVideo> createState() => _WaterMarkToPhotoVideoState();
}

class _WaterMarkToPhotoVideoState extends State<WaterMarkToPhotoVideo> {
  io.File? sourceVideo;
  io.File? sourceImage;
  img.Image? sourceImagePath;
  img.Image? destImagePath;
  io.File? imagePath;
  Future<void> toPhoto() async {
    final data = await rootBundle.load("assets/sourceImage.jpg");
    final bytes = data.buffer.asUint8List();
    destImagePath = img.decodeImage(bytes);
    final destData = await rootBundle.load("assets/images.jpeg");
    final sourceBytes = destData.buffer.asUint8List();
    sourceImagePath = img.decodeImage(sourceBytes);
    img.Image finalImaghe = img.compositeImage(destImagePath!, sourceImagePath!,
        center: true, srcH: 100, srcW: 100, srcX: 40, srcY: 40);
    final dir = await getExternalStorageDirectory();
    imagePath = io.File("${dir!.path}/${DateTime.now()}.jpg");
    img.encodeImageFile(imagePath!.path, finalImaghe);
    print("path:$imagePath");
  }

  Future<void> textToPhoto() async {
    final data = await rootBundle.load("assets/sourceImage.jpg");
    final bytes = data.buffer.asUint8List();
    destImagePath = img.decodeImage(bytes);
    String watermark = "This is watermark";
    final myFont = await rootBundle.load("assets/Roboto-Black.ttf.zip");
    final fontToZip = myFont.buffer.asUint8List();
    img.Image finalImaghe = img.drawString(destImagePath!, watermark,
        font: img.BitmapFont.fromZip(fontToZip),
        x: destImagePath!.width - 300,
        y: destImagePath!.height - 100,
        color: img.ColorFloat32.rgb(255, 255, 255));
    final dir = await getExternalStorageDirectory();
    imagePath = io.File("${dir!.path}/${DateTime.now()}.jpg");
    img.encodeImageFile(imagePath!.path, finalImaghe);
    print("path:$imagePath");
  }

  Future<void> toVideo() async {
    print("called");
    final ByteData data = await rootBundle.load("assets/sample.mp4");
    final Uint8List videoBytes = data.buffer.asUint8List();

    final sourceImageData = await rootBundle.load("assets/sourceImage.jpg");
    final unitData = sourceImageData.buffer.asUint8List();

    final io.Directory? systemTempDir = await getExternalStorageDirectory();
    sourceVideo = io.File('${systemTempDir!.path}/temp_video.mp4');
    await sourceVideo!.writeAsBytes(videoBytes);
    print("s");
    VideoWatermark videoWatermark = VideoWatermark(
      sourceVideoPath: sourceVideo!.path,
      watermark: Watermark(image: WatermarkSource.asset("assets/images.jpg")),
      onSave: (path) {
        print("on video saved");
        print("path: $path");
      },
      progress: (value) {
        print("on progresss");
        print(value);
      },
    );
    videoWatermark.generateVideo();
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
            TextButton(
                onPressed: () async {
                  await toPhoto();
                },
                child: const Text("Add watermark photo to photo")),
            TextButton(
                onPressed: () async {
                  await textToPhoto();
                },
                child: const Text("Add watermark text to photo")),
            TextButton(
                onPressed: () async {
                  await toVideo();
                },
                child: const Text("Add watermark to video"))
          ],
        ),
      )),
    );
  }
}
