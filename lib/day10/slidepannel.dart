import 'package:flutter/material.dart';

class SlideUpPannel extends StatefulWidget {
  const SlideUpPannel({super.key});

  @override
  State<SlideUpPannel> createState() => _SlideUpPannelState();
}

class _SlideUpPannelState extends State<SlideUpPannel> {
  bool _isAnimated = false;
  double _containerHeight = 0.7;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("Slide Pannel"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: size.width,
              height: _isAnimated ? size.height * 0.2 : size.height * 0.8,
              color: Colors.red,
              child: Image(
                image: const AssetImage("assets/background.jpg"),
                errorBuilder: (context, error, stackTrace) {
                  return Text("Unable to load asset image:$error");
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            bottom: 0,
            left: 0,
            right: 0,
            top: _isAnimated ? size.height * 0.2 : null,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isAnimated = !_isAnimated;
                });
              },
              onVerticalDragUpdate: (details) {
                setState(() {
                  _containerHeight += details.primaryDelta! / size.height;
                  _containerHeight = _containerHeight.clamp(0.1, 0.8);
                });
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: size.height * _containerHeight,
                color: Colors.red,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("List Item $index"),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
