import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MyCustomPaint extends StatefulWidget {
  const MyCustomPaint({super.key});

  @override
  State<MyCustomPaint> createState() => _MyCustomPaintState();
}

class _MyCustomPaintState extends State<MyCustomPaint>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animate;
  @override
  void initState() {
    // TODO: implement initState
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  _initAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animate = List.generate(
        4,
        (index) => Tween<double>(begin: 1.2, end: 2).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval((index / 4) + 0.2, (index + 1) / 4))));
    _animationController.addListener(() {});
    _animationController.addStatusListener((status) {
      print(status);
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animate[0].value, _animate[0].value),
                  child: CustomPaint(
                    painter: MyPainter(angle: _animate[0].value),
                    foregroundPainter: MyPainter(angle: _animate[0].value),
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animate[1].value, _animate[1].value),
                  child: CustomPaint(
                    painter: MyPainter2(angle: _animate[1].value),
                    foregroundPainter: MyPainter2(angle: _animate[1].value),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animate[2].value, _animate[2].value),
                  child: CustomPaint(
                    painter: MyPainter3(angle: _animate[2].value),
                    foregroundPainter: MyPainter3(angle: _animate[2].value),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animate[3].value, _animate[3].value),
                  child: CustomPaint(
                    painter: MyPainter4(angle: _animate[3].value),
                    foregroundPainter: MyPainter4(angle: _animate[3].value),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}

class MyPainter extends CustomPainter {
  final double angle;

  MyPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    print(angle);
    double width = size.width;
    double height = size.height;
    final strokeWidth = size.width / 10;

    final paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.yellow;

    Rect rect = Rect.fromCircle(
        center: Offset(width / 2, height / 2), radius: width / 2);
    canvas.drawArc(rect, 0, pi * angle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter2 extends CustomPainter {
  final double angle;
  MyPainter2({required this.angle});
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 10;
    Rect rect = Rect.fromCircle(
        center: Offset(width / 2, height / 2), radius: width / 2);
    canvas.drawArc(rect, 0, pi * angle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter3 extends CustomPainter {
  final double angle;
  MyPainter3({required this.angle});
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.pink
      ..strokeWidth = 30
      ..style = PaintingStyle.stroke;
    Offset center = Offset(width / 2, height / 2);
    double radius = width / 2;
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, pi * 1.5, pi * angle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter4 extends CustomPainter {
  final double angle;
  MyPainter4({required this.angle});
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.indigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;
    Offset center = Offset(width / 2, height / 2);
    double radius = width / 2;
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, pi * 0.5, pi * angle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
