import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimationControllerHooks extends HookWidget {
  const AnimationControllerHooks({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: Duration.zero);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Animation controller hook"),
            AnimatedBuilder(
                animation: animationController,
                builder: (child, context) {
                  return AnimatedOpacity(
                    opacity: animationController.value,
                    duration: const Duration(seconds: 2),
                    child: const Text("animated opacity"),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
