import 'dart:math';

import 'package:flutter/material.dart';

class MyCustomPaint extends StatelessWidget {
  const MyCustomPaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Paint"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPaint(
              painter: MyPaint1(),
              child: const SizedBox(
                height: 200,
                width: 300,
                // color: Colors.red,
              ),
            ),
            CustomPaint(
              painter: MyPaint2(),
              child: const SizedBox(
                height: 200,
                width: 300,
                // color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyPaint1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.height / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class MyPaint2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10;
    paint.strokeCap = StrokeCap.round;
    // canvas.drawLine(const Offset(100, 50), const Offset(200, 50), paint);
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.height / 2);
    canvas.drawArc(rect, pi / 2, 2 * pi * 0.5, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
