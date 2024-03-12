import 'package:flutter/material.dart';

class MyOpacityAnimation extends StatefulWidget {
  const MyOpacityAnimation({super.key});

  @override
  State<MyOpacityAnimation> createState() => _MyOpacityAnimationState();
}

class _MyOpacityAnimationState extends State<MyOpacityAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  double itemHeight = 150;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opacity Animation"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 15,
        itemExtent: itemHeight,
        itemBuilder: (context, index) {
          final offsetHeight = itemHeight * index;
          final diff = _scrollController.offset - offsetHeight;
          final percent = 1 - (diff / (itemHeight / 2));
          double opacity = percent;
          double scale = percent;
          if (percent > 1.0) {
            opacity = 1.0;
          }
          if (percent < 0.0) {
            opacity = 0.0;
          }
          if (scale > 1.0) {
            scale = 1.0;
          }
          return AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 200),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(scale, 1.0),
              child: Card(
                color:
                    Colors.indigo.withOpacity(0.5), // Adjust card color opacity
                child: Center(
                  child: Text("Card $index"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
