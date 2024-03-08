import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';

class PickFile extends StatefulWidget {
  const PickFile({super.key});

  @override
  State<PickFile> createState() => _PickFileState();
}

class _PickFileState extends State<PickFile> {
  final List<File> _files = [];
  @override
  void initState() {
    // TODO: implement initState
    _checkAndRequestPermissions();
    super.initState();
  }

  Future<void> _checkAndRequestPermissions() async {
    bool status = await Permission.storage.isGranted;
    if (status) {
      _loadFiles();
    } else {
      PermissionStatus request = await Permission.storage.request();
      if (request == PermissionStatus.denied) {
        // Handle the case where the user denied storage permission
        print("Storage permission denied");
        return;
      }
      _loadFiles();
    }
  }

  Future<void> _loadFiles() async {
    Directory? directory =
        await getExternalStorageDirectory(); //get external storage directory

    List<FileSystemEntity> files = directory!.listSync(); //return list of files

    final extgernalFiles = files
        .where((file) => file.path.endsWith('.pdf'))
        .map((e) => File(e.path))
        .toList(); //return pdf file by filetring files
    Directory? applicationDir =
        await getApplicationDocumentsDirectory(); //get external storage directory

    List<FileSystemEntity> appFiles =
        applicationDir.listSync(); //return list of files

    final filteredFiles = appFiles
        .where((file) => file.path.endsWith('.pdf'))
        .map((e) => File(e.path))
        .toList();
    print("external files $extgernalFiles");
    print("app dir files:$filteredFiles");
    _files.addAll(filteredFiles);
    _files.addAll(extgernalFiles);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _files.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("Index $index"),
                    title: Text("path ${_files[index].path}"),
                  );
                })
          ],
        ),
      )),
    );
  }
}
