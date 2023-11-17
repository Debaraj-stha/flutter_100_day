import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class PPSizePhotoMaker extends StatelessWidget {
  const PPSizePhotoMaker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remove Background Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Remove Background Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? image;
  String? imagePath;
  Color selectedColor = Colors.red;
  ScreenshotController controller = ScreenshotController();
  chooseColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  Future<void> pickImage() async {
    try {
      final pickedimage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedimage != null) {
        imagePath = pickedimage.path;
        image = await pickedimage.readAsBytes();
        setState(() {});
      } else {
        throw Exception("image is not picked");
      }
    } catch (e) {
      print(e);
    }
  }

  void saveImage() async {
    bool isGranted = await Permission.storage.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.storage.request().isGranted;
    }

    if (isGranted) {
      String directory = (await getExternalStorageDirectory())!.path;
      String fileName = "${DateTime.now().microsecondsSinceEpoch}.png";
      controller.captureAndSave(directory, fileName: fileName);
    }
  }

  remove_background_image() async {
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
      request.files
          .add(await http.MultipartFile.fromPath("image_file", imagePath!));
      request.headers.addAll(
          {"X-API-Key": "t8TWJviwsMuVcgoB2DhD8Jki"}); //Put Your API key HERE
      final response = await request.send();
      if (response.statusCode == 200) {
        http.Response imgRes = await http.Response.fromStream(response);
        setState(() {
          image = imgRes.bodyBytes;
        });
      } else {
        throw Exception("Error occurred with response ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Select color"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildColorContainer(Colors.red),
                buildColorContainer(Colors.white),
                buildColorContainer(Colors.green),
                buildColorContainer(Colors.blue),
              ],
            ),
            TextButton(
                onPressed: () {
                  pickImage();
                },
                child: const Text("Pick Image")),
            (image != null)
                ? Container(
                    width: 200,
                    height: 200,
                    color: selectedColor,
                    child: Screenshot(
                      controller: controller,
                      child: Image.memory(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                    child: const Icon(
                      Icons.image,
                      size: 100,
                    ),
                  ),
            TextButton(
                onPressed: () async {
                  await remove_background_image();
                },
                child: const Text("Remove Background")),
            TextButton(
                onPressed: () async {
                  saveImage();
                },
                child: const Text("Save image"))
          ],
        ),
      ),
    );
  }

  InkWell buildColorContainer(Color color) {
    return InkWell(
      onTap: chooseColor(color),
      child: Container(
        width: 40,
        margin: const EdgeInsets.all(7),
        height: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: Colors.black, width: 1)),
      ),
    );
  }
}
