import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareFile extends StatefulWidget {
  const ShareFile({super.key});

  @override
  State<ShareFile> createState() => _ShareFileState();
}

class _ShareFileState extends State<ShareFile> {
  Future<void> shareFile() async {
    String url =
        "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg";

    http.Response response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final tempPath = await getExternalStorageDirectory();
    final path = "${tempPath!.path}/image.jpg";

    File file = File(path);
    print(path);
    await file.writeAsBytes(bytes);
    try {
      await Share.shareFiles(
        [path],
        subject: "Sharing file",
        text: "Check out this image!",
        mimeTypes: ["image/jpeg"],
      );
    } catch (e) {
      print("exception $e");
    } finally {
      if (await file.exists()) {
        file.delete();
        print("file delted");
      }
    }
  }

  final List<XFile> _images = [];
  Future<void> shareMultipleImages() async {
    await Share.shareXFiles(_images);
  }

  Future<void> pickImage() async {
    final images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _images.addAll(images);
      });
      await shareMultipleImages();
    } else {
      print("none of image is picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextButton(
              onPressed: () async {
                await shareFile();
              },
              child: const Text("Share file from net")),
          TextButton(
              onPressed: () async {
                await pickImage();
              },
              child: const Text("Share multiple local file"))
        ],
      )),
    );
  }
}
