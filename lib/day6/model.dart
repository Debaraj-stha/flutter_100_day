import 'package:flutter/material.dart';

class TextInfo {
   Color color;
   double size;
   FontWeight weight;
   double top;
   double left;
   TextAlign align;
   FontStyle style;
   String text;
  TextInfo(
      {required this.align,
      required this.color,
      required this.text,
      required this.size,
      required this.weight,
      required this.top,
      required this.left,
      required this.style});
}
