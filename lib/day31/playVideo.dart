import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({super.key});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;
  final StreamController<Duration> _streamController = StreamController();
  final StreamController _streamController1 = StreamController();
  final StreamController _streamController2 = StreamController();
  final ValueNotifier<bool> _isShow = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isOverLayShow = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isPlaying = ValueNotifier(false);
  double _sliderValue = 0.0;
  final List<String> _videos = [
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
  ];
  int _currentIndex = 0;
  late Stream<Duration> stream;
  @override
  void initState() {
    // TODO: implement initState

    _controller =
        VideoPlayerController.networkUrl(Uri.parse(_videos[_currentIndex]))
          ..setVolume(0.5)
          ..setLooping(true)
          ..initialize().then((value) {
            print("volume is ${_controller.value.volume}");
            setState(() {
              // _controller.play();
              updateValue();
            });
          });

    super.initState();
  }

  void handlePreviousNext(int type) {
    //type = 1 is for next and 0 for previous
    if (type == 0) {
      if (_currentIndex > 0) {
        _currentIndex--; // Decrement to go to the previous video
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("This is the first video")));
      }
    } else {
      if (_currentIndex < _videos.length - 1) {
        _currentIndex++; // Increment to go to the next video
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No more video")));
      }
    }
    print("_currentIndex $_currentIndex");
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(_videos[_currentIndex]))
          ..setVolume(0.5)
          ..setLooping(true)
          ..initialize().then((_) {
            setState(() {
              _controller.play();
            });
          });
  }

  seek(int type) {
    //type = 1 is for forward and 0 for backward
    final Duration newPosition;
    Duration seekTo = const Duration(seconds: 5);
    if (type == 0) {
      newPosition = _controller.value.position - seekTo;
    } else {
      newPosition = _controller.value.position + seekTo;
    }
    var maxDuration = _controller.value.duration;
    if (newPosition > Duration.zero && newPosition <= maxDuration) {
      _controller.seekTo(newPosition);
    }
    setState(() {});
  }

  updateValue() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final videoPosition = _controller.value.isInitialized
          ? _controller.value.position
          : Duration.zero;
      _streamController.add(videoPosition);
      final progress = _controller.value.isInitialized
          ? _controller.value.position.inMilliseconds /
              _controller.value.duration.inMilliseconds
          : 00;
      _streamController1.add(progress);
      final remainigDuration = _controller.value.isInitialized
          ? _controller.value.duration - _controller.value.position
          : 00;
      _streamController2.add(remainigDuration);
    });
  }

  handleDragProgressBar(DragUpdateDetails details) {
    final newProgress =
        (details.localPosition.dx / context.size!.width).clamp(0.0, 1.0);
    _controller.seekTo(Duration(
        milliseconds:
            (_controller.value.duration * newProgress).inMilliseconds));
    _streamController1.add(newProgress);
    print("newProgress: $newProgress");
    print("details $details");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _controller.value.isInitialized
                ? GestureDetector(
                    onDoubleTap: () {
                      if (!_isOverLayShow.value) {
                        _isOverLayShow.value = true;
                      } else {
                        _isOverLayShow.value = false;
                      }
                    },
                    child: Stack(
                      children: [
                        AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller)),
                        ValueListenableBuilder(
                            valueListenable: _isOverLayShow,
                            builder: (context, value, child) {
                              if (value) {
                                return Container(
                                  color:
                                      const Color.fromARGB(31, 107, 105, 105),
                                  width: size.width,
                                  height: size.height * 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            seek(0);
                                          },
                                          icon: const Icon(Icons.forward_10)),
                                      ValueListenableBuilder(
                                          valueListenable: _isShow,
                                          builder: ((context, value, child) {
                                            if (value) {
                                              return Slider(
                                                activeColor: Colors.blue,
                                                inactiveColor: Colors.black,
                                                min: 0.0,
                                                max: 1.0,
                                                onChanged: (value) {
                                                  print(value);
                                                  _sliderValue = value;
                                                  _controller.setVolume(value);
                                                  print(
                                                      "changfe volumw ${_controller.value.volume}");
                                                  setState(() {});
                                                },
                                                onChangeEnd: (value) {
                                                  _isShow.value = false;
                                                },
                                                value: _sliderValue,
                                              );
                                            } else {
                                              return Container();
                                            }
                                          })),
                                      IconButton(
                                          onPressed: () {
                                            _isShow.value = true;
                                          },
                                          icon: const Icon(Icons.volume_down)),
                                      IconButton(
                                          onPressed: () {
                                            seek(1);
                                          },
                                          icon: const Icon(Icons.forward_10)),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.black12,
                    width: size.width,
                    height: size.height * 0.5,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            Row(
              children: [
                StreamBuilder(
                    stream: _streamController.stream,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.toString().split('.')[0]);
                      } else {
                        return const Text("00");
                      }
                    })),
                SizedBox(
                  width: size.width * 0.8,
                  child: StreamBuilder(
                      stream: _streamController1.stream,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              handleDragProgressBar(details);
                            },
                            child: LinearProgressIndicator(
                              value: snapshot.data!,
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.red),
                              backgroundColor: Colors.white,
                            ),
                          );
                        } else {
                          return const LinearProgressIndicator(
                            backgroundColor: Colors.white,
                          );
                        }
                      })),
                ),
                StreamBuilder(
                    stream: _streamController2.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text((snapshot.data!).toString().split('.')[0]);
                      } else {
                        return const Text("00:00");
                      }
                    })
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      handlePreviousNext(0);
                    },
                    icon: const Icon(Icons.skip_previous_rounded)),
                IconButton(
                  onPressed: () {
                    if (_isPlaying.value) {
                      _controller.pause();
                      _isPlaying.value = false;
                    } else {
                      _controller.play();
                      _isPlaying.value = true;
                    }
                  },
                  icon: ValueListenableBuilder(
                      valueListenable: _isPlaying,
                      builder: (context, value, child) {
                        if (_isPlaying.value) {
                          return const Icon(Icons.pause_circle_filled_rounded);
                        } else {
                          return const Icon(Icons.play_circle_fill_rounded);
                        }
                      }),
                ),
                IconButton(
                    onPressed: () {
                      handlePreviousNext(1);
                    },
                    icon: const Icon(Icons.skip_next_rounded))
              ],
            )
          ],
        ),
      ),
    );
  }
}
