import 'package:flutter/material.dart';

class ParallexEffect1 extends StatefulWidget {
  const ParallexEffect1({super.key});

  @override
  State<ParallexEffect1> createState() => _ParallexEffect1State();
}

class _ParallexEffect1State extends State<ParallexEffect1> {
  ScrollController? controller;
  double scrollOffset = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    controller = ScrollController()
      ..addListener(() {
        handleScroll();
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  handleScroll() {
    setState(() {
      scrollOffset = controller!.offset;
    });
    print(scrollOffset);
  }

  double layer1Speed = 0.5;
  double layer2Speed = 0.45;
  double layer3Speed = 0.42;
  double layer4Speed = 0.37;
  double layer5Speed = 0.30;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var layoutHeight = screenSize.height * 3;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 60, 240, 210),
          Color.fromARGB(255, 253, 244, 193)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                bottom: layer4Speed * scrollOffset,
                child: const Image(image: AssetImage("asset/images/d.jpg"))),
            Positioned(
                left: 0,
                right: 0,
                bottom: layer3Speed * scrollOffset,
                child: const Image(image: AssetImage("asset/images/c.jpg"))),
            Positioned(
                left: 0,
                right: 0,
                bottom: layer2Speed * scrollOffset,
                child: const Image(image: AssetImage("asset/images/b.jpg"))),
            Positioned(
                left: 0,
                right: 0,
                bottom: -20 + layer1Speed * scrollOffset,
                child: const Image(image: AssetImage("asset/images/c.jpg"))),
            Positioned(
                left: 0,
                right: 0,
                top: screenSize.height + (layer1Speed * scrollOffset * -1),
                child: Container(
                  height: screenSize.height,
                  color: Colors.black,
                )),
            Positioned.fill(
              child: SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    height: layoutHeight,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
