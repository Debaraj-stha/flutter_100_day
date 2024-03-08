import 'package:flutter/material.dart';
import 'package:hundred_day/day22/notiClass.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketInFlutter extends StatefulWidget {
  const SocketInFlutter({super.key});

  @override
  State<SocketInFlutter> createState() => _SocketInFlutterState();
}

class _SocketInFlutterState extends State<SocketInFlutter> {
  late IO.Socket socket;
  initSocket() {
    socket = IO.io(
      "http://10.0.0.2:8000/",
    );
    socket.on(
        'notify',
        (data) => {
              ShowNotificationClass().initMessage(context),
              ShowNotificationClass().showMessage(
                  {"title": "This is title", "body": "this is body"})
            });
  }

  notify() {
    socket.emit("notify");
  }

  @override
  void initState() {
    // TODO: implement initState
    initSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              notify();
            },
            child: const Text("notify")),
      ),
    );
  }
}
