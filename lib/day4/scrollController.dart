import 'package:flutter/material.dart';

class ScrollControllerExample extends StatefulWidget {
  const ScrollControllerExample({Key? key}) : super(key: key);

  @override
  State<ScrollControllerExample> createState() =>
      _ScrollControllerExampleState();
}

class _ScrollControllerExampleState extends State<ScrollControllerExample> {
  ScrollController controller = ScrollController();
  int scrollToIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text("Scroll to top"),
            ),
            TextButton(
              onPressed: () {
                double itemPosition = scrollToIndex * 16; //16 is height
                controller.animateTo(
                  itemPosition,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: Text("scroll to index $scrollToIndex"),
            ),
            SizedBox(
              height: 400, // Set a fixed height for the inner list
              child: ListView.builder(
                controller: controller,
                itemCount: 25,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("List item $index"),
                  );
                }),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.animateTo(controller.position.maxScrollExtent,
                    duration: const Duration(microseconds: 600),
                    curve: Curves.easeInOut);
              },
              child: const Text("Scroll to bottom"),
            ),
          ],
        ),
      ),
    );
  }
}
