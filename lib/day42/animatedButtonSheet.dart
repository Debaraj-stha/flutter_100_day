import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedButtonSheet extends StatelessWidget {
  const AnimatedButtonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: 400,
                  width: 400,
                  decoration: const BoxDecoration(color: Colors.green),
                ),
              ],
            ),
            const BottomSheetTransition(),
          ],
        ),
      ),
    );
  }
}

class BottomSheetTransition extends StatefulWidget {
  const BottomSheetTransition({super.key});

  @override
  _BottomSheetTransitionState createState() => _BottomSheetTransitionState();
}

class _BottomSheetTransitionState extends State<BottomSheetTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double get maxHeight => MediaQuery.of(context).size.height - 40;
  double songImgStartSize = 45;
  double songImgEndSize = 120;
  double songVerticalSpace = 25;
  double songHorizontalSpace = 15;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? lerp(double min, double max) {
    return lerpDouble(min, max, _controller.value);

    /// lerpDouble: Linearly interpolate between two numbers,
    /// `a` and `b`, by an extrapolation factor `t`.
    /// will help to change font,icon,image size,margin with _controller.value
  }

  void toggle() {
    final bool isCompleted = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isCompleted ? -1 : 1);

    /// velocity < 0.0 ? _AnimationDirection.reverse : _AnimationDirection.forward
    /// onTap open the sheet if it's closed and vise versa
  }

  void verticalDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / maxHeight;

    /// when drag the sheet => update _controller.value => lerp function work =>
    /// update the sheet height and font,icon,image size,margin
  }

  void verticalDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;

    if (flingVelocity < 0) {
      _controller.fling(velocity: math.max(1, -flingVelocity));
    } else if (flingVelocity > 0) {
      _controller.fling(velocity: math.min(-1, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -1 : 1);
    }

    /// to finish the animation once the user has finished the gesture
  }

  double? songTopMargin(int index) {
    return lerp(20, 10 + index * (songVerticalSpace + songImgEndSize));
  }

  double? songLeftMargin(int index) {
    return lerp(index * (songHorizontalSpace + songImgStartSize), 0);
  }

  Widget buildSongContainer(Song song) {
    int index = songs.indexOf(song);
    return SongContainer(
      song: song,
      key: Key(index.toString()),
      imgSize: lerp(songImgStartSize, songImgEndSize)!,
      topMargin: songTopMargin(index)!,
      leftMargin: songLeftMargin(index)!,
      isCompleted: _controller.status == AnimationStatus.completed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: lerp(120, maxHeight),
          child: GestureDetector(
            onTap: toggle,
            onVerticalDragUpdate: verticalDragUpdate,
            onVerticalDragEnd: verticalDragEnd,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff920201),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      top: lerp(20, 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Songs',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: lerp(15, 25),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            _controller.status == AnimationStatus.completed
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: Colors.white,
                            size: lerp(15, 25),
                          )
                        ],
                      )),
                  Positioned(
                    top: lerp(35, 80),
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SingleChildScrollView(
                      scrollDirection:
                          _controller.status == AnimationStatus.completed
                              ? Axis.vertical
                              : Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: SizedBox(
                        height:
                            (songImgEndSize + songVerticalSpace) * songs.length,
                        width: (songImgStartSize + songHorizontalSpace) *
                            songs.length,
                        child: Stack(
                          children: [
                            for (Song song in songs) buildSongContainer(song),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SongContainer extends StatelessWidget {
  final Song song;
  final double topMargin;
  final double leftMargin;
  final double imgSize;
  final bool isCompleted;

  const SongContainer(
      {required Key key,
      required this.song,
      required this.topMargin,
      required this.leftMargin,
      required this.imgSize,
      required this.isCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      child: Row(
        children: [
          SizedBox(
            height: imgSize,
            width: imgSize,
            child: Image.asset(
              'assets/${song.image}',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: isCompleted
                  ? Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            song.year,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}

class Song {
  final String image;
  final String title;
  final String year;

  Song(this.image, this.title, this.year);
}

final List<Song> songs = [
  Song('sourceImage.jpg', 'Asyad El Sout', '2021'),
  Song('sourceImage.jpg', 'Asyad El Sout', '2021'),
  Song('sourceImage.jpg', 'Asyad El Sout', '2021'),
  Song('sourceImage.jpg', 'Asyad El Sout', '2021'),
  Song('sourceImage.jpg', 'Asyad El Sout', '2021'),
  Song('sourceImage.jpg', 'Asyad El Sout', '2021'),
  Song('sourceImage.jpg', 'Asyad El Sout', '2021'),
  Song('sourceImage.jpg', 'Asyad El Sout', '2021'),
];
