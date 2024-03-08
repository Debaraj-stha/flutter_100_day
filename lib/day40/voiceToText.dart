import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceToText extends StatefulWidget {
  const VoiceToText({super.key});

  @override
  State<VoiceToText> createState() => _VoiceToTextState();
}

class _VoiceToTextState extends State<VoiceToText> {
  bool _isInitialized = false;
  final SpeechToText _speechToText = SpeechToText();
  String recognizedWord = "";
  double _confidenceLevel = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    _initPlugin();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  Future<void> _initPlugin() async {
    _isInitialized = await _speechToText.initialize();
    setState(() {});
  }

  _startListening() async {
    print("startListening...");
    _confidenceLevel = 0;
    recognizedWord = "";
    await _speechToText.listen(
      onResult: (result) {
        setState(() {
          recognizedWord = result.recognizedWords;
          _confidenceLevel = result.confidence * 100;
        });
        print(result.toString());
      },
    );
    setState(() {});
  }

  _stopListening() async {
    print("stop listening...");
    await _speechToText.stop();
    setState(() {
      _confidenceLevel = 0;
      recognizedWord = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            _speechToText.isListening
                ? const Text("listening")
                : _isInitialized
                    ? const Text("tap mic to start listening")
                    : const Text("speech is not available"),
            const Text("Listening word:"),
            Text(recognizedWord),
            Text("Confidence:${_confidenceLevel.toStringAsFixed(1)}")
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        child: Icon(
          _speechToText.isListening ? Icons.mic_off : Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }
}
