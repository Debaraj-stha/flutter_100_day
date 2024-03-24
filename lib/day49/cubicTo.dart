import 'package:flutter/material.dart';

class CubicTo extends StatelessWidget {
  const CubicTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubic To"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ClipPath(
          clipper: MyClipper(),
          child: Container(
            color: Colors.red,
            height: 400,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(0, height - 100);
    path.cubicTo(width * 0.2, height * 0.2, width * 0.6, height + 100, width,
        height - 100);
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
