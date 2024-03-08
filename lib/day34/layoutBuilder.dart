import 'package:flutter/material.dart';

class MyLayoutBuilder extends StatelessWidget {
  const MyLayoutBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                
                  Container(
                      width: size.width * 0.7,
                      color: Colors.green,
                      child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                30,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("list items $index"),
                                    ))),
                      )),
                  Container(
                      width: size.width * 0.3,
                      color: Colors.red,
                      child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                40,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("list items $index"),
                                    ))),
                      )),
                ],
              ),
            ),
          );
        } else if (constraints.maxWidth > 500 && constraints.maxWidth < 800) {
          return Container(
              color: Colors.yellow,
              child: SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        40,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("list items $index"),
                            ))),
              ));
        } else {
          return const Scaffold(
            body: Text("this is default text"),
          );
        }
      },
    );
  }
}
