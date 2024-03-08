import 'package:flutter/material.dart';

class MyClipper extends StatelessWidget {
  const MyClipper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          ClipPath(
            clipper: ContainerClipper(),
            child: Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: Parallelogram(),
            child: Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: TraingleClip(),
            child: Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: TraingleClipInverted(),
            child: Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: DimondClip(),
            child: Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: ArcClip(),
            child: Container(
              height: 200,
              width: 300,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: PolygonClipper(),
            child: Container(
              height: 200,
              width: 300,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: CurveClip(),
            child: Container(
              height: 200,
              width: 300,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: CurveClip(),
            child: Container(
              height: 200,
              width: 300,
              color: Colors.red,
            ),
          ),
          ClipPath(
            clipper: CurveClipper0(),
            child: Container(
              height: 300,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: CurveClipper1(),
            child: Container(
              height: 300,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ClipPath(
            clipper: CurveClipper2(),
            child: Container(
              height: 300,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }
}

class ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(width, 0);
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

class Parallelogram extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.moveTo(30, 0);
    path.lineTo(width - 30, 0);
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

class TraingleClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.moveTo(width / 2, 0);
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class TraingleClipInverted extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.lineTo(width / 2, height);
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

class DimondClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.moveTo(width / 2, 0);
    path.lineTo(0, height / 2);
    path.lineTo(width / 2, height);
    path.lineTo(width, height / 2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class ArcClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();

    // path.addArc(
    //     Rect.fromCircle(
    //         center: Offset(width / 2, height / 2), radius: width / 2),
    //     0,
    //     180);
    // path.addRRect(RRect.fromRectXY(
    //     Rect.fromCircle(
    //         center: Offset(width / 2, height / 2), radius: width / 2),
    //     width / 2,
    //     height / 2));
    path.addOval(Rect.fromCircle(
        center: Offset(width / 2, height / 2), radius: width / 2));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class PolygonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();

    List<Offset> points = [
      Offset(width * 0.5, 0),
      Offset(width, height * 0.5),
      Offset(width * 0.5, height),
      Offset(0, height * 0.5),
    ];
    path.addPolygon(points, true);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class CurveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double width = size.width;
    double height = size.height;
    Path path = Path();

    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.quadraticBezierTo(100, height - 100, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class CurveClipper0 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height - 100);
    path.cubicTo(50, height, width * 0.5, height * 0.5, width, height);
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
    path.lineTo(0, height - 140);
    path.cubicTo(150, height, width * 0.6, 10, width, height);
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
    path.cubicTo(100, height * 0.3, width * 0.6, 0, width, 0);
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
