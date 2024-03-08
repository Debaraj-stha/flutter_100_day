import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class WorkingWithWorkManager extends StatefulWidget {
  const WorkingWithWorkManager({super.key});

  @override
  State<WorkingWithWorkManager> createState() => _WorkingWithWorkManagerState();
}

class _WorkingWithWorkManagerState extends State<WorkingWithWorkManager> {
  int _totalExecutiom = 0;
  @override
  void initState() {
    // TODO: implement initState
    Workmanager().registerPeriodicTask("periodicTaskId", "periodicTaskName",
        frequency: const Duration(minutes: 15));
    Workmanager().registerOneOffTask("one", "one",
        inputData: Map.from({"name": "Manish"}));
    super.initState();
    Timer.periodic(Duration(seconds: 1),(t){
getExectionTimes();
    });
    
  }

  Future<void> getExectionTimes() async {
    final sp = await SharedPreferences.getInstance();
    int x = sp.getInt("totalExecution") ?? 0;
    setState(() {
      _totalExecutiom = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(_totalExecutiom.toString()),
            const Center(
              child: Text("scheduling work"),
            ),
          ],
        ),
      ),
    );
  }
}
