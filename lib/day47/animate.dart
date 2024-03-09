import 'package:flutter/material.dart';

class AnimatePromt extends StatelessWidget {
  const AnimatePromt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MyAnimation(
            title: "Thank you",
            subtitle: "Your order has been placed successfuly",
            child: Icon(
              Icons.check,
              size: 30,
              // color: Colors.green,
            )),
      ),
    );
  }
}

class MyAnimation extends StatefulWidget {
  const MyAnimation(
      {super.key,
      required this.child,
      required this.title,
      required this.subtitle});

  final Widget child;
  final String title;
  final String subtitle;

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconAnimation, _containerAnimation;
  late Animation<Offset> _yAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _iconAnimation = Tween<double>(begin: 7, end: 6)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _containerAnimation = Tween<double>(begin: 2, end: 0.4)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _yAnimation = Tween<Offset>(
            begin: const Offset(0, 0), end: const Offset(0, -0.23))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.reset();
    _controller.forward();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      constraints: BoxConstraints(
          minHeight: 100,
          minWidth: 100,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.8),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                widget.title,
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w800, color: Colors.black),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.subtitle,
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
              )
            ],
          ),
          Positioned.fill(
              child: SlideTransition(
            position: _yAnimation,
            child: ScaleTransition(
              scale: _containerAnimation,
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
                child: ScaleTransition(
                  scale: _iconAnimation,
                  child: widget.child,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
