import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

class ReadingAndWritingFile extends StatefulWidget {
  const ReadingAndWritingFile({super.key});

  @override
  State<ReadingAndWritingFile> createState() => _ReadingAndWritingFileState();
}

class _ReadingAndWritingFileState extends State<ReadingAndWritingFile> {
  int counter = 0;
  final HandleOperation _handleOperation = HandleOperation();
  Future<void> readData() async {
    print("read");
    counter = await _handleOperation.readData();

    setState(() {});
    print(counter.toString());
  }

  void writeData() {
    counter++;
    _handleOperation.writeData(counter);
    print("write ");
    readData();
  }

  @override
  void initState() {
    // TODO: implement initState

    readData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reading and Writing file")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Counter value ",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 39,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        writeData();
                      },
                      icon: const Icon(Icons.add)),
                  Text(
                    counter.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  IconButton(
                      onPressed: () {
                        writeData();
                      },
                      icon: const Icon(Icons.remove))
                ],
              ),
              TextButton(
                  onPressed: () {
                    _handleOperation.generatePDF();
                  },
                  child: const Text("generate pdf"))
            ],
          ),
        ),
      ),
    );
  }
}

class HandleOperation {
  Future<String> getPath() async {
    final path = await getApplicationDocumentsDirectory();
    return path.path;
  }

  Future<File> getFile() async {
    String path = await getPath();
    String fileName = "$path/test.txt";
    return File(fileName);
  }

  Future<int> readData() async {
    try {
      final file = await getFile();
      print(file);
      String data = await file.readAsString();
      if (data.isNotEmpty) {
        return int.parse(data);
      } else {
        // Return a default value when the file is empty
        return 0;
      }
    } catch (e) {
      // Handle any errors that occur during file reading
      print("Error reading data: $e");
      return 0; // Return a default value on error
    }
  }

  void writeData(int data) async {
    try {
      final file = await getFile();
      file.writeAsString("$data");
    } catch (e) {
      print(e);
    }
  }

  generatePDF() async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
      orientation: pw.PageOrientation.portrait,
      pageFormat: PdfPageFormat.a4,
      pageTheme: pw.PageTheme(theme: pw.ThemeData()),
      build: (pw.Context context) {
        return pw.Text("testing pdf",style: pw.TextStyle(fontSize: 30,fontBold: pw.Font.courierBold()));
      },
    ));
    final outPut = await getExternalStorageDirectory();

    String path =
        '${'${outPut!.path}/${DateTime.now().toIso8601String()}'}.pdf';
    final file = File(path);
    List<int> bytes = await doc.save();
    file.writeAsBytesSync(bytes);
  }
}
