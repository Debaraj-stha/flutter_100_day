import 'package:flutter/material.dart';

class CubicTo extends StatelessWidget {
  const CubicTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CubicTo method"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ClipPath(
                clipper: Clipper1(),
                child: Container(
                  height: 200,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper2(),
                child: Container(
                  height: 200,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper3(),
                child: Container(
                  height: 300,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper4(),
                child: Container(
                  height: 300,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper5(),
                child: Container(
                  height: 300,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper6(),
                child: Container(
                  height: 500,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper7(),
                child: Container(
                  height: 500,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper8(),
                child: Container(
                  height: 500,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper9(),
                child: Container(
                  height: 300,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper10(),
                child: Container(
                  height: 300,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipPath(
                clipper: Clipper11(),
                child: Container(
                  height: 300,
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Clipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height - 100);
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

class Clipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, 20);
    path.cubicTo(
        width * 0.4, 0, width * 0.6, height * 0.7, width, height * 0.3);
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

class Clipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, height);
    path.cubicTo(0, height, width * 0.5, 0, width, height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class Clipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height - 40);
    path.cubicTo(width * 0.3, height - 100, width * 0.8, height + 50, width,
        height - 60);
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

class Clipper5 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.cubicTo(width * 0.4, height * 0.1, width * 0.5, height * 0.5,
        width * 0.54, height);
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

class Clipper6 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, height * 0.8);
    path.cubicTo(width * 0.2, height * 0.85, width * 0.3, height * 0.5,
        width * 0.4, height * 0.5);

    path.quadraticBezierTo(
        width * 0.64, height * 0.45, width * 0.7, height * 0.30);
    path.quadraticBezierTo(width * 0.8, height * 0.1, width, 100);
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

class Clipper7 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, height);
    path.cubicTo(width * 0.4, 0, width * 0.2, height, width, height);

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

class Clipper8 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(90, height);
    path.cubicTo(
        width * 0.07, height / 2, width, height / 2, width - 90, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class Clipper9 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, height * 0.7);
    path.cubicTo(width * 0.3, 0, width * 0.7, height, width, 0);
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

class Clipper10 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, height * 0.5);
    path.cubicTo(width * 0.3, 0, width * 0.6, height, width, 0);
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

class Clipper11 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(0, height * 0.9);
    path.cubicTo(
        width * 0.5, height * 0.8, width * 0.6, height * 0.1, width, 10);
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
