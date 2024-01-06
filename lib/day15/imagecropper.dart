// import 'dart:io';

// import 'package:flutter/material.dart';
// // import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class ImageCrop extends StatefulWidget {
//   const ImageCrop({super.key});

//   @override
//   State<ImageCrop> createState() => _ImageCropState();
// }

// class _ImageCropState extends State<ImageCrop> {
//   Controller controller = Controller();
//   // File? image;
//   // CroppedFile? croppedFile;
//   // ScreenshotController screenshotController = ScreenshotController();
//   // void pickImage(ImageSource source) async {
//   //   image = null;
//   //   String? imagePath = await controller.picklImage(source);
//   //   if (imagePath != null) {
//   //     image = File(imagePath);
//   //     croppedFile = null;
//   //     setState(() {});
//   //     print(imagePath);
//   //   }
//   // }

//   // Future<void> cropImage() async {
//   //   if (image != null) {
//   //     final crop = await ImageCropper().cropImage(
//   //         sourcePath: image!.path,
//   //         compressFormat: ImageCompressFormat.jpg,
//   //         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//   //         compressQuality: 100,
//   //         uiSettings: [
//   //           AndroidUiSettings(
//   //               toolbarTitle: "ImageCropper",
//   //               toolbarColor: Colors.blueAccent,
//   //               initAspectRatio: CropAspectRatioPreset.original,
//   //               lockAspectRatio: false)
//   //         ]);
//   //     if (crop != null) {
//   //       croppedFile = crop;
//   //       setState(() {});
//   //       print(croppedFile);
//   //     }
//   //   }
//   // }

//   Future<void> saveImage() async {
//     bool isPermissionGranted = await Permission.storage.isGranted;
//     if (!isPermissionGranted) {
//       isPermissionGranted = await Permission.storage.request().isGranted;
//     }

//     if (isPermissionGranted) {
//       final directory = await getExternalStorageDirectory();
//       String path = directory!.path;
//       String fileName = "${DateTime.now()}_cropped.jpg";
//       screenshotController.captureAndSave(path, fileName: fileName);
//       print(path);
//     }
//     print("imaged saved successfully");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Image cropper Flutter"),
//         actions: [
//           InkWell(
//             onTap: () {
//               pickImage(ImageSource.camera);
//             },
//             child: Container(
//               width: 40,
//               height: 40,
//               decoration: const BoxDecoration(shape: BoxShape.circle),
//               child: const Icon(Icons.camera_alt),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           InkWell(
//             onTap: () {
//               pickImage(ImageSource.gallery);
//             },
//             child: Container(
//               width: 40,
//               height: 40,
//               decoration: const BoxDecoration(shape: BoxShape.circle),
//               child: const Icon(Icons.photo),
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               image != null
//                   ? SizedBox(
//                       height: 200,
//                       width: 200,
//                       child: Image.file(
//                         image!,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : Container(
//                       child: const Center(
//                         child: Text("No image to show"),
//                       ),
//                     ),
//               const SizedBox(
//                 height: 20,
//               ),
//               croppedFile != null
//                   ? Screenshot(
//                       controller: screenshotController,
//                       child: SizedBox(
//                         height: 200,
//                         width: 200,
//                         child: Image.file(
//                           File(croppedFile!.path),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     )
//                   : Container(
//                       child: const Text("Cropped image will appear here"),
//                     )
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => croppedFile != null ? saveImage() : cropImage(),
//         child: croppedFile != null
//             ? const Icon(Icons.save)
//             : const Icon(Icons.crop),
//       ),
//     );
//   }
// }

// class Controller {
//   Future<String?> picklImage(ImageSource source) async {
//     try {
//       final pickImage = await ImagePicker().pickImage(source: source);
//       if (pickImage != null) {
//         return pickImage.path;
//       } else {
//         throw Exception("Cannot picked image");
//       }
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }
// }
