import 'package:flutter/material.dart';

import 'package:zego_zimkit/zego_zimkit.dart';

import 'chat.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async {
              await ZIMKit().connectUser(id: "12", name: "Devraj Shrestha");
              MaterialPageRoute(
                builder: (context) => const Chat(),
              );
            },
            child: const Text("click")),
      ),
    );
  }
}
