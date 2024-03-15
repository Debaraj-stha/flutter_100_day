import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedProgressbar extends StatefulWidget {
  const AnimatedProgressbar({super.key});

  @override
  State<AnimatedProgressbar> createState() => _AnimatedProgressbarState();
}

class _AnimatedProgressbarState extends State<AnimatedProgressbar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _scaledController;
  late Animation<double> _animation;
  late Animation<double> _sequenceAnimation;
  int countdown = 30;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _scaledController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    _sequenceAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1, end: 0.5), weight: 50)
    ]).animate(_scaledController);
    _scaledController.reset();
    _scaledController.forward();
    _controller.reset();
    _controller.forward();
    update();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaledController.dispose();
    super.dispose();
  }

  void update() {
    if (countdown > 0) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          countdown = countdown - 1;
        });
        if (countdown <= 0) {
          timer.cancel();
          _scaledController.reset();
          _scaledController.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedBuilder(
              animation: _scaledController,
              builder: ((context, child) {
                return Transform.scale(
                  scale: _sequenceAnimation.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                );
              })),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: Text(
                    countdown.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 6,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                CustomPaint(
                  painter: MyPainter(progress: _animation.value),
                  foregroundPainter: MyPainter(progress: _animation.value),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double progress;

  MyPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    double y = size.height;
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10
      ..color = Colors.red;
    double sweepAngle = 2 * pi * progress;
    Rect rect = Rect.fromCircle(center: Offset(x / 2, y / 2), radius: x / 2);
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
