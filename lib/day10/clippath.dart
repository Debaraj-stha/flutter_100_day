import 'package:flutter/material.dart';

class Clippath extends StatelessWidget {
  Clippath({super.key});
  TextStyle style = const TextStyle(
      fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("curve"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("curver on bottom", style: style),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ClipPath(
                    clipper: CurveClipper1(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("curver on left", style: style),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ClipPath(
                    clipper: CurveClipper2(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("curver on right", style: style),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ClipPath(
                    clipper: CurveClipper3(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("curver on top", style: style),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ClipPath(
                    clipper: HeartShape(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 300,
                      color: Colors.red,
                      child: Text("heart", style: style),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ClipPath(
                    clipper: MultipleCurve(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("multiple curve", style: style),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ClipPath(
                    clipper: MultipleCurve1(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("multiple curve", style: style),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ClipPath(
                    clipper: MultipleCurve2(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("multiple curve", style: style),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ClipPath(
                    clipper: MultipleCurve3(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("multiple curve", style: style),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ClipPath(
                    clipper: TopCurve(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("top curve", style: style),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ClipPath(
                    clipper: LeftCurve(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("Left curve", style: style),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ClipPath(
                    clipper: ComplexCurve(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("complex curve", style: style),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ClipPath(
                    clipper: Curve1(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("complex curve", style: style),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ClipPath(
                    clipper: CubicCurve(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 400,
                      color: Colors.red,
                      child: Text("complex curve", style: style),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height);
    path.quadraticBezierTo(width * 0.5, height - 100, width,
        height); // first and second are control points and last two are end points ,the container have curve at center of height height-1
    // path.lineTo(width, height);
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

class CurveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.quadraticBezierTo(width * 0.3, height * 0.5, 0,
        height); //draw a curve on left side of container
    path.lineTo(width, height);
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

class CurveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.quadraticBezierTo(50, height * 0.5, width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class CurveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.quadraticBezierTo(width * 0.5, height * 0.3, width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class HeartShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(width * 0.5, height * 0.35);
    path.cubicTo(width * 0.2, height * 0.1, -0.25 * width, height * 0.6,
        width * 0.5, height);
    path.moveTo(0.5 * width, 0.35 * height);
    path.cubicTo(width * 0.8, height * 0.1, width * 1.25, height * 0.6,
        width * 0.5, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class MultipleCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height);
    final firstStartPoint = Offset(width / 4 - width / 8, height - 60);
    final firstEndPoint = Offset(width / 4 + width / 8, height - 70);
    path.quadraticBezierTo(firstStartPoint.dx, firstStartPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    final secondStartPoint = Offset(width / 2, height - 70);
    final secondEndPoint = Offset(width / 2 + width / 8, height - 50);
    path.quadraticBezierTo(secondStartPoint.dx, secondStartPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    final thirdStartPoint = Offset(3 * (width / 4) + width / 8, height - 30);
    final thirdEndPoint = Offset(width, height - 90);
    path.quadraticBezierTo(thirdStartPoint.dx, thirdStartPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);
    path.lineTo(width, height);
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

class MultipleCurve1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height - 40);
    path.quadraticBezierTo(
        width * 0.2, height, (width * 0.25) + 20, height - 40);
    path.quadraticBezierTo(width * 0.5, height - 100, width * 0.7, height - 50);
    path.quadraticBezierTo(width * 0.9, height - 30, width, height - 70);
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

class MultipleCurve2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, 30);
    path.quadraticBezierTo(width / 6, 0, width / 5 + 25, 30);
    path.quadraticBezierTo(width / 1.5, height / 2, width, height / 2 - 30);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class MultipleCurve3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height - 40);
    path.quadraticBezierTo(width * 0.2, height, width / 3, height - 60);
    path.quadraticBezierTo(width * 0.5, height - 100, width * 0.7, height - 20);
    path.quadraticBezierTo(width * 0.9, height, width, height - 40);
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

class TopCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, 30);
    path.quadraticBezierTo(width * 0.25, 0, width * 0.4, height * 0.3);
    path.quadraticBezierTo(width * 0.5, height * 0.45, width * 0.65, 30);
    path.quadraticBezierTo(width * 0.8, 0, width, 150);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class LeftCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.quadraticBezierTo(width - 70, height * 0.8, width - 20, height * 0.6);
    path.quadraticBezierTo(width, height * 0.5, width - 30, height * 0.2);
    path.quadraticBezierTo(width - 50, height - 20, width - 10, 0);
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

class ComplexCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, 30);
    path.quadraticBezierTo(width * 0.3, 0, width * 0.5, height * 0.2);
    path.quadraticBezierTo(width * 0.65, 0, width - 30, height * 0.3);
    path.quadraticBezierTo(width - 100, height * 0.4, width, height * 0.5);
    path.quadraticBezierTo(width - 150, height * 0.6, width - 200, height);
    path.quadraticBezierTo(width * 0.1, height - 20, width * 0.5, height - 60);
    path.quadraticBezierTo(width * 0.2, height - 50, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class Curve1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    // path.moveTo(0, 30);
    path.moveTo(0, height - 40);
    path.quadraticBezierTo(width * 0.2, height - 20, width * 0.40, height - 70);
    path.quadraticBezierTo(width * 0.55, height * 0.20, width * 0.8, 30);
    path.quadraticBezierTo(width * 0.9, 10, width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class CubicCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    // path.moveTo(0, 30);
    path.moveTo(0, height / 2);
    path.cubicTo(0, height / 8, width, height, width, height / 2);
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
