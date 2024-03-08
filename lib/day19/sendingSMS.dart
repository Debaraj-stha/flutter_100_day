import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class sendingSMS extends StatefulWidget {
  const sendingSMS({super.key});

  @override
  State<sendingSMS> createState() => _sendingSMSState();
}

class _sendingSMSState extends State<sendingSMS> {
  void sendSM() async {
    List<String> recipients = ['+9779812345678'];
    await sendSMS(
            message: "hello there", recipients: recipients, sendDirect: true)
        .then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print("error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(onPressed: () {}, child: const Text("send sms")),
    );
  }
}
