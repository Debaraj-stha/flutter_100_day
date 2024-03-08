import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MasoniryGrid extends StatelessWidget {
  MasoniryGrid({super.key});
  List<String> images = [
    "asset/grid/a.jpg",
    "asset/grid/b.jpg",
    "asset/grid/c.jpg",
    "asset/grid/d.jpg",
    "asset/grid/e.jpg",
    "asset/grid/f.jpg",
    "asset/grid/g.jpg",
    "asset/grid/h.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid view"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 3000,
              width: double.infinity,
              child: MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: images.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image(
                          image: AssetImage(images[index]),
                          fit: BoxFit.contain,
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
