import 'package:flutter/material.dart';
import 'package:hundred_day/day3/buildBackground.dart';

class ParallexEffect extends StatefulWidget {
  const ParallexEffect({super.key});

  @override
  State<ParallexEffect> createState() => _ParallexEffectState();
}

class _ParallexEffectState extends State<ParallexEffect> {
  ScrollController? controller;
  double one = 0;
  double two = 0;
  double three = 0;
  double four = 0;
  double five = 0;

  @override
  void initState() {
    // TODO: implement initState
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.scrollDelta == null) return true;
            setState(() {
              five = five - notification.scrollDelta! / 2;
              four = four - notification.scrollDelta! / 1.7;
              three = three - notification.scrollDelta! / 1.4;
              two = two - notification.scrollDelta! / 1.2;
              one = one - notification.scrollDelta! / 1;
            });
            print(
              one,
            );
          }
          return true;
        },
        child: Stack(
          children: [
            BuildBackground(
              image: "asset/images/a.jpg",
              top: five * 0.2,
            ),
            BuildBackground(
              image: "asset/images/b.jpg",
              top: four,
            ),
            BuildBackground(
              image: "asset/images/c.jpg",
              top: three,
            ),
            BuildBackground(
              image: "asset/images/d.jpg",
              top: two,
            ),
            BuildBackground(
              image: "asset/images/d.jpg",
              top: one,
            ),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: Text("Parallex effect",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
