// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart' as R;

class RecordingAudio extends StatefulWidget {
  const RecordingAudio({super.key});

  @override
  State<RecordingAudio> createState() => _RecordingAudioState();
}

class _RecordingAudioState extends State<RecordingAudio> {
  String audioPath = "";
  late R.AudioRecorder record;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  bool isPlaying = false;

  Future<void> startRecording() async {
    try {
      print("started recording");
      if (await record.hasPermission()) {
        final dir = await getExternalStorageDirectory();
        audioPath = "${dir!.path}record.mp3";
        print(audioPath);
        await record.start(const R.RecordConfig(), path: audioPath);
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> uploadAndDeleteRecording() async {
    try {
      File file = File(audioPath);

      final request = http.MultipartRequest('POST', Uri.parse("uri"))
        ..files.add(http.MultipartFile(
            'audio', file.readAsBytes().asStream(), file.lengthSync(),
            filename: "audio.mp3"));
      print("request$request");

      final res = await http.Response.fromStream(await request.send());
      if (res.statusCode == 200) {
        print("success");
      } else {
        print("something bad happened");
      }
    } catch (e) {}
  }

  Future<void> stopRecording() async {
    try {
      setState(() {
        isRecording = false;
        recoding_now = false;
      });
      final path = await record.stop();
      print("path $path");
    } catch (e) {
      print("$e");
    }
  }

  Future<void> deleteRecord() async {
    try {
      File f = File(audioPath);
      if (f.existsSync()) {
        f.deleteSync();
      }
      isPlaying = false;
      recoding_now = false;
    } catch (e) {
      print("$e");
    }
  }

  Future<void> pauseAudio() async {
    try {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } catch (e) {}
  }

  Future<void> playAudio() async {
    try {
      Source url = UrlSource(audioPath);
      await audioPlayer.play(url);
      audioPlayer.onPlayerStateChanged.listen((event) {
        if (event == PlayerState.completed) {
          isPlaying = false;
        }
      });

      setState(() {
        isPlaying = true;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    record = R.AudioRecorder();
    audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Voice Recorder'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            recoding_now
                ? IconButton(
                    icon: !isRecording
                        ? const Icon(
                            Icons.mic_none,
                            color: Colors.red,
                            size: 50,
                          )
                        : const Icon(Icons.fiber_manual_record,
                            color: Colors.red, size: 50),
                    onPressed: isRecording ? stopRecording : startRecording,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: !isPlaying
                            ? const Icon(Icons.play_circle,
                                color: Colors.green, size: 50)
                            : const Icon(Icons.pause_circle,
                                color: Colors.green, size: 50),
                        onPressed: !isPlaying ? playAudio : pauseAudio,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red, size: 50),
                        onPressed: deleteRecord,
                      ),
                      IconButton(
                        icon: const Icon(Icons.trending_up,
                            color: Colors.green, size: 50),
                        onPressed: uploadAndDeleteRecording,
                      ),
                    ],
                  ),
          ],
        ));
  }

  bool recoding_now = true;
}
