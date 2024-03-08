import 'dart:isolate';

import 'package:flutter/material.dart';

class FlutterIsolate extends StatefulWidget {
  const FlutterIsolate({super.key});

  @override
  State<FlutterIsolate> createState() => _FlutterIsolateState();
}

class _FlutterIsolateState extends State<FlutterIsolate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter isolate"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("asset/images/ball.gif")),
              TextButton(
                  onPressed: () async {
                    double x = await taskOne();
                    print(x);
                  },
                  child: const Text("task 1")),
              TextButton(
                  onPressed: () {
                    ReceivePort receivePort = ReceivePort();
                    Isolate.spawn(taskTwo, receivePort.sendPort);
                    receivePort.listen((message) {
                      print(message);
                    });
                  },
                  child: const Text("task 2")),
            ],
          ),
        ),
      ),
    );
  }

  taskOne() {
    double total = 0;
    for (int i = 0; i <= 100000000000; i++) {
      total += i;
    }
    return total;
  }
}

taskTwo(SendPort sendPort) {
  print("called");
  double total = 0;
  for (int i = 0; i <= 1000000000; i++) {
    total += i;
  }
  print("completed");
  sendPort.send(total);
}
