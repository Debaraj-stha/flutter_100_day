import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:http/http.dart' as http;

class PDFReader extends StatefulWidget {
  const PDFReader({super.key});

  @override
  State<PDFReader> createState() => _PDFReaderState();
}

class _PDFReaderState extends State<PDFReader> {
  createPDF() async {
    try {
      final pdf = pw.Document();
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(8),
        build: (context) {
          return pw.Center(
              child: pw.Text("this is a simple pdf document",
                  style: const pw.TextStyle(fontSize: 30)));
        },
      ));
      final dir = await getExternalStorageDirectory();
      String path = "${dir!.path}/${DateTime.now().microsecondsSinceEpoch}.pdf";
      File file = File(path);
      List<int> bytes = await pdf.save();
      file.writeAsBytes(bytes);
      print("file path is $path");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    createPDF();
                  },
                  child: const Text("create PDF")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewPDf(type: 0)));
                  },
                  child: const Text("read PDF from asset")),
              TextButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      String? path = result.files.single.path!;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewPDf(
                                    type: 1,
                                    path: path,
                                  )));
                    }
                  },
                  child: const Text("read local file")),
              TextButton(
                  onPressed: () async {
                    print("clicked");

                    http.Response res = await http.get(Uri.parse(
                        'https://www.africau.edu/images/default/sample.pdf'));

                    final bytes = res.bodyBytes;
                    final dir = await getExternalStorageDirectory();
                    final path = "${dir!.path}/example.pdf";
                    File file = File(path);
                    file.writeAsBytesSync(bytes);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewPDf(
                                  type: 1,
                                  path: path,
                                )));
                  },
                  child: const Text("Read from online")),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewPDf extends StatefulWidget {
  const ViewPDf({super.key, required this.type, this.path});
  final int type;
  final String? path;
  @override
  State<ViewPDf> createState() => _ViewPDfState();
}

class _ViewPDfState extends State<ViewPDf> {
  late pdfx.PdfController _controller;
  _loadController() async {
    switch (widget.type) {
      case 0:
        _controller = pdfx.PdfController(
          document: pdfx.PdfDocument.openAsset('asset/x.pdf'),
        );
        break;
      case 1:
        _controller = pdfx.PdfController(
            document: pdfx.PdfDocument.openFile(widget.path!));
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pdfx.PdfView(controller: _controller),
    );
  }
}
