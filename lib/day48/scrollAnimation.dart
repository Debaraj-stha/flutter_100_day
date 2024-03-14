import 'package:flutter/material.dart';

class ScrollAnimation extends StatefulWidget {
  const ScrollAnimation({super.key});

  @override
  State<ScrollAnimation> createState() => _ScrollAnimationState();
}

class _ScrollAnimationState extends State<ScrollAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverAppBar(expandedHeight: size.height * 0.4),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text("List Item $index"),
                );
              },
              childCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.indigo),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: shrinkOffset,
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(
                  top: shrinkOffset > 0 ? 0 : expandedHeight / 2 - 30),
              decoration: const BoxDecoration(
                  color: Colors.pink, shape: BoxShape.circle),
              child: const Icon(Icons.person),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
