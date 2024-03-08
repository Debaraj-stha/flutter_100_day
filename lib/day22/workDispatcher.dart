import 'package:flutter/material.dart';

import 'package:hundred_day/day22/notiClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';


@pragma('vm:entry-point')
dispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print(inputData.toString());
    int? totalExecution;
    final sharedPreference = await SharedPreferences.getInstance();
    const key = "totalExecution";

    print(inputData.toString());
    try {
      print("called");
      greet();
      await ShowNotificationClass().showNotification(inputData!['context']);
      print("called bellow");
      // Your other code here
    } catch (e) {
      print(e.toString());
    }
    return Future.value(true);
  });
}
