import 'package:flutter/material.dart';

class DrawPolygon extends StatelessWidget {
  const DrawPolygon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        clipper: MyClipper(),
        child: Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    List<Offset> points = [
      const Offset(100, 20),
      const Offset(200, 80),
      const Offset(160, 180),
      const Offset(40, 180),
      const Offset(0, 80),
    ];

    path.addPolygon(points, false);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
