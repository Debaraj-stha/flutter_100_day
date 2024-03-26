import 'package:flutter/material.dart';

class MyTweenAnimation extends StatefulWidget {
  const MyTweenAnimation({super.key});

  @override
  State<MyTweenAnimation> createState() => _MyTweenAnimationState();
}

class _MyTweenAnimationState extends State<MyTweenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sequenceAnimation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _sequenceAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 30, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 50, end: 30), weight: 50)
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Icon(
                    Icons.favorite,
                    size: _sequenceAnimation.value,
                    color: Colors.red,
                  );
                }),
            TextButton(
                onPressed: () {
                  _controller.reset();
                  _controller.forward();
                },
                child: const Text("Animate"))
          ],
        ),
      ),
    );
  }
}
