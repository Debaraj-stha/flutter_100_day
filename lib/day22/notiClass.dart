import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hundred_day/day22/onTapHandler.dart';


import 'secondScreen.dart';

class ShowNotificationClass {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  showNotification(BuildContext context) {
    initMessage(context);
    print("init message called");
    Map<String, dynamic> message = {
      'body': "testing message",
      'title': "this is title",
      "context": context
    };
    showMessage(message);
  }

  initMessage(BuildContext context) async {
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings darwinSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: darwinSettings);
    await _plugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (details) {
        onDidReceiveLocalNotification(
            1, "title", "body", details.payload, context);
      },
    );
  }

  showMessage(Map<String, dynamic> message) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('1', 'testing',
            color: Colors.red,
            priority: Priority.max,
            importance: Importance.max);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await Future.delayed(const Duration(seconds: 2), () {
      _plugin.show(1, message['title'], message['body'], notificationDetails);
    });
  }

  void onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondScreen(),
      ),
    );
  }
}
void greet(){
  print("hello everyone!");
}