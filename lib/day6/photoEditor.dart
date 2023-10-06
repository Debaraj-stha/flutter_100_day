import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hundred_day/day6/model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class PhotoEditor extends StatefulWidget {
  const PhotoEditor({super.key});

  @override
  State<PhotoEditor> createState() => _PhotoEditorState();
}

class _PhotoEditorState extends State<PhotoEditor> {
  File? file;
  pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        file = File(image.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditPage(file: image.path)));
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo editor"),
      ),
      body: TextButton(
          onPressed: () {
            pickImage();
          },
          child: const Text("Pick image")),
    );
  }
}

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.file});
  final String file;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<Map<String, dynamic>> editTool = [];
  List<Map<String, dynamic>> colorTool = [];
  changeFontStyle(FontStyle style) {
    if (textInfo.isNotEmpty) {
      setState(() {
        textInfo[currentinex].style = style;
      });
    }
  }

  changeTextAlign(TextAlign align) {
    if (textInfo.isNotEmpty) {
      setState(() {
        if (textInfo[currentinex].align == align) {
          textInfo[currentinex].align = TextAlign.left;
          return;
        }
        textInfo[currentinex].align = align;
      });
    }
  }

  chnageTextSize(int type) {
    if (textInfo.isNotEmpty) {
      setState(() {
        switch (type) {
          case 1:
            textInfo[currentinex].size += 2;
            break;
          case 2:
            textInfo[currentinex].size -= 2;
            break;
        }
      });
    }
  }

  void addField() {
    List<Map<String, dynamic>> colorField = [
      {
        "name": "Red",
        "color": Colors.red,
      },
      {
        "name": "blue",
        "color": Colors.blue,
      },
      {
        "name": "white",
        "color": Colors.white,
      },
      {"name": "green", "color": Colors.green},
      {
        "name": "yellow",
        "color": Colors.yellow,
      },
    ];
    colorTool.addAll(colorField);
    List<Map<String, dynamic>> appBarList = [
      {"icon": Icons.save, "tooltop": "save"},
      {"icon": Icons.space_bar, "tooltop": "add space bar"},
      {"icon": Icons.format_italic, "tooltop": "font italic"},
      {"icon": Icons.format_bold, "tooltop": "font bold"},
      {"icon": Icons.format_align_center, "tooltop": "text align center"},
      {"icon": Icons.format_align_left, "tooltop": "text align left"},
      {"icon": Icons.format_align_right, "tooltop": "text align right"},
      {"icon": Icons.remove, "tooltop": "decrease font size"},
      {"icon": Icons.add, "tooltop": "increase font size"},
    ];
    editTool.addAll(appBarList);
  }

  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> textInfo = [];
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  int currentinex = 0;
  String data = "";
  stCurrentIndex(BuildContext context, int index) {
    setState(() {
      currentinex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("text is selected for edit"),
    ));
  }

  addText() {
    String text = controller.text;
    TextInfo info = TextInfo(
        text: text,
        align: TextAlign.left,
        color: Colors.black,
        size: 18.0,
        weight: FontWeight.normal,
        top: 0.0,
        left: 0.0,
        style: FontStyle.normal);
    textInfo.add(info);
    print(textInfo);

    setState(() {});
    controller.clear();
    focusNode.unfocus();
    Navigator.of(context).pop();
  }

  removeText(BuildContext context) {
    setState(() {
      textInfo.removeAt(currentinex);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Removed"),
    ));
  }

  changeTextColor(Color color) {
    print("clicked");
    if (textInfo.isNotEmpty) {
      setState(() {
        textInfo[currentinex].color = color;
      });
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "_")
        .replaceAll(":", "_");
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  saveToGallery(BuildContext context) {
    if (textInfo.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("saved to gallery"),
        ));
      }).catchError((err) => print(err));
    }
  }

  addNewLine() {
    if (textInfo[currentinex].text.contains("\n")) {
      textInfo[currentinex].text =
          textInfo[currentinex].text.replaceAll("\n", " ");
      return;
    }
    textInfo[currentinex].text =
        textInfo[currentinex].text.replaceAll(" ", "\n");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    addField();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.clear();
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      saveToGallery(context);
                    },
                    child: const Icon(
                      Icons.save,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      chnageTextSize(1);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      chnageTextSize(2);
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      // changeFontStyle(FontStyle.va);
                    },
                    child: const Icon(
                      Icons.format_bold,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      changeFontStyle(FontStyle.italic);
                    },
                    child: const Icon(
                      Icons.format_italic,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      changeFontStyle(FontStyle.normal);
                    },
                    child: const Icon(
                      Icons.undo,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      changeTextAlign(TextAlign.center);
                    },
                    child: const Icon(
                      Icons.format_align_center,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      changeTextAlign(TextAlign.left);
                    },
                    child: const Icon(
                      Icons.format_align_left,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      changeTextAlign(TextAlign.right);
                    },
                    child: const Icon(
                      Icons.format_align_right,
                      color: Colors.black,
                      size: 25,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      addNewLine();
                    },
                    child: const Icon(
                      Icons.space_bar,
                      color: Colors.black,
                      size: 25,
                    )),
              )
            ]),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: colorTool.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final data = colorTool[index];
                    return InkWell(
                      onTap: () {
                        changeTextColor(data['color']);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: data['color'], shape: BoxShape.circle),
                      ),
                    );
                  }),
            ),
          )),
      body: Screenshot(
        controller: screenshotController,
        child: SingleChildScrollView(
          child: Container(
            child: Stack(children: [
              Container(
                child: Image(
                  image: FileImage(
                    File(widget.file),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              for (var i = 0; i < textInfo.length; i++) ...[
                Positioned(
                    top: textInfo[i].top,
                    left: textInfo[i].left,
                    child: GestureDetector(
                      onTap: () {
                        stCurrentIndex(context, i);
                      },
                      onLongPress: () {
                        setState(() {
                          currentinex = i;
                        });

                        removeText(context);
                      },
                      child: Draggable(
                        onDragEnd: (drag) {
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          Offset offset = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            textInfo[i].top = offset.dy;
                            textInfo[i].left = offset.dx;
                          });
                        },
                        feedback: Text(
                          textInfo[i].text,
                          textAlign: textInfo[i].align,
                          style: TextStyle(
                              color: textInfo[i].color,
                              fontSize: textInfo[i].size,
                              fontWeight: textInfo[i].weight,
                              overflow: TextOverflow.clip,
                              fontStyle: textInfo[i].style),
                        ),
                        child: Text(
                          textInfo[i].text,
                          textAlign: textInfo[i].align,
                          style: TextStyle(
                              color: textInfo[i].color,
                              overflow: TextOverflow.clip,
                              fontSize: textInfo[i].size,
                              fontWeight: textInfo[i].weight,
                              fontStyle: textInfo[i].style),
                        ),
                      ),
                    ))
              ],
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Add text"),
                    content: Container(
                      child: TextFormField(
                        maxLines: 3,
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                            hintText: "Enter text ...",
                            contentPadding: EdgeInsets.only(left: 4)),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            addText();
                          },
                          child: const Text("Add"))
                    ],
                  ));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
