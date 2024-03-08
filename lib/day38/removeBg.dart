import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class RemoveBackground extends StatefulWidget {
  const RemoveBackground({super.key});

  @override
  State<RemoveBackground> createState() => _RemoveBackgroundState();
}

class _RemoveBackgroundState extends State<RemoveBackground> {
  File? image;
  Uint8List? responseImage;
  final bool _isLoaded = false;

  Future<void> removeBg() async {
    String uri = "https://api.remove.bg/v1.0/removebg";
    Map<String, String> headers = {
      'X-API-Key': "t1689LyUTModrnaHgKRjsJuk",
    };

    try {
      final request = http.MultipartRequest("POST", Uri.parse(uri))
        ..files.add(http.MultipartFile.fromBytes(
            "image_file", image!.readAsBytesSync(),
            filename: image!.path.split("/").last));
      request.headers.addAll(headers);

      await request.send().then((response) async {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print("Error in removeBg: $e");
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
              SizedBox(
                height: 400,
                child: image != null
                    ? Image.file(File(image!.path))
                    : Container(
                        child: const Icon(Icons.image),
                      ),
              ),
              _isLoaded
                  ? Image.memory(responseImage!)
                  : const CircularProgressIndicator(),
              TextButton(
                onPressed: () async {
                  try {
                    final picker = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (picker != null) {
                      image = File(picker.path);
                      setState(() {});
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text("Pick image"),
              ),
              TextButton(
                onPressed: () {
                  removeBg();
                },
                child: const Text("Remove BG"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
