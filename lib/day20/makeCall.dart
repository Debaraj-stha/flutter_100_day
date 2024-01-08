import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class MakeCall extends StatelessWidget {
  const MakeCall({super.key});
  void call() async {
    final Uri url = Uri(scheme: 'tel', path: '+9779819020638');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void sendMessage() async {
    final query = encodeQueryParameters(<String, String>{
      'body': "Hello, world",
    });

    final Uri smsUrl = Uri(
        scheme: 'sms', userInfo: "devraj", path: '+97798020638', query: query);
    if (await canLaunchUrl(smsUrl)) {
      await launchUrl(smsUrl);
    }
  }

  void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'smith@example.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
        'body': 'Example body of message',
      }),
    );
    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    call();
                  },
                  child: const Text("Make call")),
              TextButton(
                  onPressed: () {
                    sendEmail();
                  },
                  child: const Text("send Email")),
              TextButton(
                  onPressed: () {
                    sendMessage();
                  },
                  child: const Text("send SMS"))
            ],
          ),
        ),
      ),
    );
  }
}
