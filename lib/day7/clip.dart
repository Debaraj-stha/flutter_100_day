import 'dart:math';

import 'package:flutter/material.dart';

class Clip extends StatelessWidget {
  const Clip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Path Clipper"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
                clipper: TraingleClipper(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: 200,
                  color: Colors.greenAccent,
                  child: const Text("traingle"),
                )),
            ClipPath(
                clipper: ContainerClipper(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: 200,
                  color: Colors.greenAccent,
                  child: const Text("rectangle"),
                )),
            ClipPath(
                clipper: TraingleClipperInverted(),
                child: Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                  color: Colors.greenAccent,
                  child: const Text("Traingle inverted"),
                )),
            ClipPath(
                clipper: DiamondClipper(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: 200,
                  color: Colors.greenAccent,
                  child: const Text("diamond"),
                )),
            ClipPath(
                clipper: CircleClipper(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: 200,
                  color: Colors.greenAccent,
                  child: const Text("circle"),
                )),
            ClipPath(
                clipper: LineClipper(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: 200,
                  color: Colors.blue,
                  child: const Text("Line"),
                )),
            ClipPath(
                clipper: PolygonClipper(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: 200,
                  color: Colors.blue,
                  child: const Text("Line"),
                )),
            ClipPath(
                clipper: RectangleClippeer(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: 200,
                  color: Colors.blue,
                  child: const Text("Line"),
                )),
            ClipPath(
                clipper: ParrellogramClipper(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: 200,
                  color: Colors.blue,
                  child: const Text("Line"),
                )),
          ],
        ),
      ),
    );
  }
}

class ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
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

class TraingleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
    Path path = Path();
    path.lineTo(width, 0);
    path.lineTo(width / 2, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class TraingleClipperInverted extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
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

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
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

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(width / 2, height / 2), radius: height / 2));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class LineClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
    Path path = Path();
    path.addArc(
        Rect.fromCircle(
            center: Offset(width / 2, height / 2), radius: width / 2),
        pi,
        1);

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
    double height = size.height;
    double width = size.width;
    Path path = Path();
    bool close = false;
    path.addPolygon([
      const Offset(50, 50),
      const Offset(150, 50),
      const Offset(100, 150),
    ], close);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class RectangleClippeer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
    Path path = Path();
    path.addRect(Rect.fromLTRB(0, height, width, height - 200));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class ParrellogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
    Path path = Path();
    double topLength = width * 0.8;
    path.moveTo((width - topLength) / 2, 0);
    path.lineTo((width + topLength) / 2, 0);
    path.lineTo(
        size.width, size.height); // Draw a line to the bottom-right corner
    path.lineTo(0, size.height); // Draw a line to the bottom-left corner
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
