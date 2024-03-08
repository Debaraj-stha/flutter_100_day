// import 'dart:math';

// import 'package:flutter/material.dart';

// import 'package:fluttertest/model.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class HiveInFlutter extends StatefulWidget {
//   const HiveInFlutter({Key? key}) : super(key: key);

//   @override
//   State<HiveInFlutter> createState() => _HiveInFlutterState();
// }

// class _HiveInFlutterState extends State<HiveInFlutter> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   // Function to save user data to Hive
//   void save() async {
//     // if (_nameController.text.isNotEmpty && _addressController.text.isNotEmpty) {
//     Users user =
//         Users(name: _nameController.text, address: _addressController.text);
//     //   HiveOperation.saveData(user);
//     // } else {
//     //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//     //     content: Text("Name and address can not be empty"),
//     //   ));

//     HiveOperation.saveData(user);
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: "Name"),
//               ),
//               TextField(
//                 controller: _addressController,
//                 decoration: const InputDecoration(labelText: "Address"),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   save();
//                 },
//                 child: const Text("Save"),
//               ),
//               FutureBuilder<Box<Users>>(
//                   future: Hive.openBox('demo'),
//                   builder: ((context, snapshot) {
//                     return snapshot.hasData
//                         ? ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               final user = snapshot.data!;
//                               print(user);
//                               return ListTile(
//                                 title: Text(user.getAt(index)!.name.toString()),
//                               );
//                             },
//                             itemCount: snapshot.data!.length,
//                           )
//                         : const Text("no data ");
//                   }))
//               // ValueListenableBuilder to listen for changes in Hive box
//               // ValueListenableBuilder<Box<Users>>(
//               //   valueListenable: HiveOperation.getUsersBox().listenable(),
//               //   builder: (context, box, child) {
//               //     final data = box.values.toList().cast<Users>();
//               //     return ListView.builder(
//               //       shrinkWrap: true,
//               //       itemCount: data.length,
//               //       itemBuilder: (context, index) {
//               //         return ListTile(
//               //           title: Text(data[index].name),
//               //           subtitle: Text(data[index].address),
//               //           trailing: Row(
//               //             children: [
//               //               IconButton(
//               //                 onPressed: () {
//               //                   // Handle delete action
//               //                   HiveOperation.deleteUser(data[index].key!);
//               //                 },
//               //                 icon: const Icon(Icons.delete),
//               //               ),
//               //               IconButton(
//               //                 onPressed: () {
//               //                   // Handle edit action
//               //                   // You can navigate to another screen for editing
//               //                 },
//               //                 icon: const Icon(Icons.edit),
//               //               )
//               //             ],
//               //           ),
//               //         );
//               //       },
//               //     );
//               //   },
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HiveOperation {
//   static const String usrBox = "myBox";
//   static saveData(Users user) async {
//     //  Box box()=>Hive.box("demo");
//     // box().putAll(user.toJson());
//     // print(box().get("name"));
//     // print(box().get("address"));
//   }
// }

// class Users extends HiveObject {
//   String name;

//   int? key;
//   String address;
//   Users({required this.name, required this.address, this.key});
//   factory Users.fromJson(Map<dynamic, dynamic> json) =>
//       Users(name: json['name'], address: json['address'], key: json['key']);
//   Map<String, dynamic> toJson() =>
//       {"name": name, "address": address, "key": key};
// }
