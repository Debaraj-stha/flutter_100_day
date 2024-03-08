import 'package:flutter/material.dart';

class BuildBackground extends StatelessWidget {
  const BuildBackground({super.key, this.top, required this.image});
  final double? top;
  final String image;
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: 0,
      right: 0,
      left: 0,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
