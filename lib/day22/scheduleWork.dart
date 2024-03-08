import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hundred_day/day22/notiClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';


import 'onTapHandler.dart';

class SchedulingWork extends StatefulWidget {
  const SchedulingWork({super.key});

  @override
  State<SchedulingWork> createState() => _SchedulingWorkState();
}

class _SchedulingWorkState extends State<SchedulingWork> {
  final int _totalExecutiom = 0;
  @override
  void initState() {
    // TODO: implement initState
    Workmanager().registerPeriodicTask("periodicTaskId", "periodicTaskName",
        inputData: Map.from({"name": "Manish", "context": context.toString()}),
        frequency: const Duration(minutes: 15));
    // Workmanager().registerOneOffTask("one", "one",
    //     inputData: Map.from({"name": "Manish", "context": context.toString()}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(_totalExecutiom.toString()),
            TextButton(
                onPressed: () {
                  ShowNotificationClass().showNotification(context);
                },
                child: const Text("show notification")),
            const Center(
              child: Text("scheduling work"),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowNotification extends StatefulWidget {
  const ShowNotification({super.key});

  @override
  State<ShowNotification> createState() => _ShowNotificationState();
}

class _ShowNotificationState extends State<ShowNotification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                ShowNotificationClass().showNotification(context);
              },
              child: const Text("show notification"))
        ],
      ),
    ));
  }
}
