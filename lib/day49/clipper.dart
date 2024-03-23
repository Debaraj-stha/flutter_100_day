import 'package:flutter/material.dart';

class MyClipper extends StatefulWidget {
  const MyClipper({super.key});

  @override
  State<MyClipper> createState() => _MyClipperState();
}

class _MyClipperState extends State<MyClipper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Clipper"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipPath(
              clipper: Clipper1(),
              child: Container(
                height: 200,
                width: 400,
                color: Colors.red,
              ),
            ),
            ClipPath(
              clipper: Clipper2(),
              child: Container(
                height: 200,
                width: 200,
                color: Colors.blue,
              ),
            ),
            ClipPath(
              clipper: Clipper3(),
              child: Container(
                height: 200,
                width: 200,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Clipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
    Path path = Path();
    path.lineTo(0, height);
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

class Clipper2 extends CustomClipper<Path> {
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

class Clipper3 extends CustomClipper<Path> {
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
