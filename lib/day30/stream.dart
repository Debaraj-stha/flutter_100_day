import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';

class MyStream extends StatefulWidget {
  const MyStream({super.key});

  @override
  State<MyStream> createState() => _MyStreamState();
}

class _MyStreamState extends State<MyStream> {
  final StreamController<String> _controller = StreamController<String>();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<String>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return const Text("no data");
                  }
                }),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: _textEditingController,
            ),
            TextButton(
                onPressed: () {
                  _controller.add(_textEditingController.text);
                  // _controller.sink.add(_textEditingController.text);

                  _textEditingController.clear();
                },
                child: const Text("Submit"))
          ],
        ),
      )),
    );
  }
}

class BroadCastStream extends StatefulWidget {
  const BroadCastStream({super.key});

  @override
  State<BroadCastStream> createState() => _BroadCastStreamState();
}

class _BroadCastStreamState extends State<BroadCastStream> {
   StreamController<String> _controller = StreamController();
  final TextEditingController _textEditingController = TextEditingController();
  final StreamController<Duration> _streamController = StreamController();
  final StreamController _streamController1 = StreamController();
  final StreamController _streamController2 = StreamController();
 late Stream<String> broadcastStream;
  @override
  void initState() {
    // TODO: implement initState
    broadcastStream = _controller.stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //stream 1
            StreamBuilder<String>(
                stream: broadcastStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return const Text("no data");
                  }
                }),
            //stream 2
            StreamBuilder<String>(
                stream: broadcastStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return const Text("no data");
                  }
                }),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: _textEditingController,
            ),
            TextButton(
                onPressed: () {
                  _controller.add(_textEditingController.text);
                  // _controller.sink.add(_textEditingController.text);

                  _textEditingController.clear();
                },
                child: const Text("Submit"))
          ],
        ),
      )),
    );
  }
}
