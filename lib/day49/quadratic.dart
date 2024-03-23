import 'package:flutter/material.dart';

class Quadratic extends StatelessWidget {
  const Quadratic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quadratic Bazzier"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ClipPath(
          clipper: CubicClipper(),
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class CubicClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(0, height);
    path.quadraticBezierTo(width * 0.5, height - 300, width, height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
