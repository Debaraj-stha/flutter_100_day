import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as img;

import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';

class PlayAudio extends StatefulWidget {
  const PlayAudio({super.key});

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  img.Image? src;
  img.Image? dest;

  loadImage() async {
    try {
      final destImage = await rootBundle.load("assets/images.jpeg");
      final bytes = destImage.buffer.asUint8List();
      final decodedDest = img.decodeImage(bytes);
      final sourceImage = await rootBundle.load("assets/sourceImage.jpg");
      final bytesSource = sourceImage.buffer.asUint8List();
      final decodedSource = img.decodeImage(bytesSource);
      setState(() {
        dest = decodedDest;
        src = decodedSource;
      });
    } catch (e) {
      print(e.toString());
    }
    // final image=File.fromRawPath(rawPath)
  }

  drawImageComposite() async {
    io.Directory? dir = await getExternalStorageDirectory();
    final path = "${dir!.path}/${DateTime.now()}image.png";
    io.File file = io.File(path);

    await loadImage();
    if (src != null && dest != null) {
      img.Image newImage = img.compositeImage(src!, dest!,
          linearBlend: true,
          center: true,
          srcH: 200,
          srcW: 200,
          srcX: 200,
          srcY: 40);
      img.encodeImageFile(path, newImage);
    }
  }

  drawChar() async {
    await loadImage();
    if (src != null) {
      io.Directory? dir = await getExternalStorageDirectory();
      final path = "${dir!.path}/${DateTime.now()}image.png";
      io.File file = io.File(path);
      final myFont = await rootBundle.load("assets/Roboto-Black.ttf.zip");
      final fontToZip = myFont.buffer.asUint8List();
      final newImage = img.drawChar(src!, "h",
          font: img.BitmapFont.fromZip(fontToZip), x: 100, y: 100);
      img.encodeImageFile(path, newImage);
    }
  }

  drawString() async {
    await loadImage();
    if (src != null) {
      io.Directory? dir = await getExternalStorageDirectory();
      final path = "${dir!.path}/${DateTime.now()}image.png";
      io.File file = io.File(path);
      final myFont = await rootBundle.load("assets/Roboto-Black.ttf.zip");
      final fontToZip = myFont.buffer.asUint8List();
      final newImage = img.drawChar(src!, "hello world",
          font: img.BitmapFont.fromZip(fontToZip), x: 100, y: 100);
      img.encodeImageFile(path, newImage);
    }
  }

  drawCircle() async {
    await loadImage();
    if (src != null) {
      io.Directory? dir = await getExternalStorageDirectory();
      final path = "${dir!.path}/${DateTime.now()}image.png";
      io.File file = io.File(path);
      final fontToZip =
          await io.File("D:/flutter/fluttertest/assets/Roboto-Black.ttf.zip")
              .readAsBytes();
      final newImage = img.drawCircle(src!,
          x: 100, y: 100, radius: 50, color: img.ColorFloat16(3));
      final bytes = newImage.getBytes();
      img.encodeJpgFile(file.path, newImage);
    }
  }

  Future<String> getPath() async {
    io.Directory? dir = await getExternalStorageDirectory();
    final path = "${dir!.path}/${DateTime.now()}image.png";
    return path;
  }

  rotateImage() async {
    await loadImage();
    if (src != null) {
      final file = io.File(await getPath());
      final image = img.copyRotate(src!, angle: 45);
      final bytes = image.getBytes();
      // file.writeAsBytesSync(bytes);
      img.encodeJpgFile(file.path, image);
    }
  }

  cropToCircle() async {
    await loadImage();
    if (src != null) {
      final file = io.File(await getPath());
      final image =
          img.copyCropCircle(src!, radius: 300, centerX: 600, centerY: 700);
      final bytes = image.getBytes();

      final x = await img.encodeJpgFile(file.path, image);
      print("called");
      //  file.writeAsBytesSync(x);
    }
  }

  copyResize() async {
    await loadImage();
    if (src != null) {
      final file = io.File(await getPath());
      final image = img.copyResize(src!, height: 100, width: 100);
      final bytes = image.getBytes();

      final x = await img.encodeJpgFile(file.path, image);
      print("called");
      //  file.writeAsBytesSync(x);
    }
  }

  copyRectify() async {
    // await loadImage();
    // if (src != null) {
    //   final file = io.File(await getPath());
    //   Point point=Point(0, 10);
    //   final image =
    //   img.copyRectify(src!, topLeft:point, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight);
    //   final bytes = image.getBytes();

    //   final x = await img.encodeJpgFile(file.path, image);
    //   // print("called");
    //   //  file.writeAsBytesSync(x);
    // }
  }
  adjustImageColor() async {
    await loadImage();
    if (src != null) {
      final image = img.adjustColor(src!,
          brightness: 0.6,
          contrast: 0.6,
          exposure: 0.8,
          hue: 0.8,
          saturation: 0.8,
          gamma: 0.7);
      final path = await getPath();
      img.encodeImageFile(path, image);
    }
  }

  adjustVignette() async {
    await loadImage();
    if (src != null) {
      final image = img.vignette(
        src!,
      );
      final path = await getPath();
      img.encodeImageFile(path, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  await drawImageComposite();
                },
                child: const Text("drawImageComposite")),
            TextButton(
                onPressed: () async {
                  await drawChar();
                },
                child: const Text("drawCharacter")),
            TextButton(
                onPressed: () async {
                  await drawString();
                },
                child: const Text("draw string")),
            TextButton(
                onPressed: () async {
                  await drawCircle();
                },
                child: const Text("draw circle")),
            TextButton(
                onPressed: () async {
                  await rotateImage();
                },
                child: const Text("rotate image")),
            TextButton(
                onPressed: () async {
                  await cropToCircle();
                },
                child: const Text("copy crop circle image")),
            TextButton(
                onPressed: () async {
                  await copyResize();
                },
                child: const Text("copy resize image")),
            TextButton(
                onPressed: () async {
                  await copyRectify();
                },
                child: const Text("copy rectify image")),
            TextButton(
                onPressed: () async {
                  await adjustImageColor();
                },
                child: const Text("Adjust image color")),
            TextButton(
                onPressed: () async {
                  await adjustVignette();
                },
                child: const Text("Adjust vignette color")),
          ],
        ),
      )),
    );
  }
}
