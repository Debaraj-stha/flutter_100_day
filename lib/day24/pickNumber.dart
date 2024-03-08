import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class PickNumber extends StatefulWidget {
  const PickNumber({super.key});

  @override
  State<PickNumber> createState() => _PickNumberState();
}

class _PickNumberState extends State<PickNumber> {
  int _currentValue = 4;
  int minValue = 1;
  int maxValue = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number picker"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NumberPicker(
                minValue: minValue,
                maxValue: maxValue,
                value: _currentValue,
                onChanged: (val) {
                  setState(() {
                    _currentValue = val;
                  });
                  print("change value is $val");
                }),
            Text("current value is $_currentValue")
          ],
        ),
      ),
    );
  }
}
