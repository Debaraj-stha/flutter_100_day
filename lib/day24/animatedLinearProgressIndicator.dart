import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({super.key});

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animation = List.generate(
        3,
        (index) => Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: _controller,
            curve: Interval((index / 3) + 0.2, (index + 1) / 3))));
    _controller.addListener(() {});
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: size.width *
                            0.29, // Set a fixed height or use constraints that suit your layout
                        child: AnimatedBuilder(
                            animation: _animation[0],
                            builder: (context, child) {
                              return LinearProgressIndicator(
                                value: _animation[0].value,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.red),
                              );
                            })),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(
                        width: size.width *
                            0.29, // Set a fixed height or use constraints that suit your layout
                        child: AnimatedBuilder(
                            animation: _animation[1],
                            builder: (context, child) {
                              return LinearProgressIndicator(
                                value: _animation[1].value,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.red),
                              );
                            })),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(
                        width: size.width *
                            0.29, // Set a fixed height or use constraints that suit your layout
                        child: AnimatedBuilder(
                            animation: _animation[2],
                            builder: (context, child) {
                              return LinearProgressIndicator(
                                value: _animation[2].value,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.red),
                              );
                            })),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Animated progress indicator",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .titleMedium!
                      .copyWith(color: Colors.blue, fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
