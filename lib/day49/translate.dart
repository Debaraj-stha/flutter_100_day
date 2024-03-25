import 'package:flutter/material.dart';

class Translate extends StatefulWidget {
  const Translate({super.key});

  @override
  State<Translate> createState() => _TranslateState();
}

class _TranslateState extends State<Translate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<Offset>(
            begin: const Offset(0, 0), end: const Offset(150, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _animation.value,
              child: const Text("Translated widget"),
            );
          },
        ),
      ),
    );
  }
}
