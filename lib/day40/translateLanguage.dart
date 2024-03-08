import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class LanguageTranslater extends StatefulWidget {
  const LanguageTranslater({Key? key}) : super(key: key);

  @override
  State<LanguageTranslater> createState() => _LanguageTranslaterState();
}

class _LanguageTranslaterState extends State<LanguageTranslater> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> translateLanguage = [
    'Afrikaans',
    'Albanian',
    'Arabic',
    'Belarusian',
    'Bengali',
    'Bulgarian',
    'Catalan',
    'Chinese',
    'Croatian',
    'Czech',
    'Danish',
    'Dutch',
    'English',
    'Esperanto',
    'Estonian',
    'Finnish',
    'French',
    'Galician',
    'Georgian',
    'German',
    'Greek',
    'Gujarati',
    'Haitian',
    'Hebrew',
    'Hindi',
    'Hungarian',
    'Icelandic',
    'Indonesian',
    'Irish',
    'Italian',
    'Japanese',
    'Kannada',
    'Korean',
    'Latvian',
    'Lithuanian',
    'Macedonian',
    'Malay',
    'Maltese',
    'Marathi',
    'Norwegian',
    'Persian',
    'Polish',
    'Portuguese',
    'Romanian',
    'Russian',
    'Slovak',
    'Slovenian',
    'Spanish',
    'Swahili',
    'Swedish',
    'Tagalog',
    'Tamil',
    'Telugu',
    'Thai',
    'Turkish',
    'Ukrainian',
    'Urdu',
    'Vietnamese',
    'Welsh',
  ];

  TranslateLanguage? targetLanguage;
  String translatedText = "";
  String pickLanguage = "";
  void _handleLanguageChange(String? value) {
    targetLanguage =
        TranslateLanguage.values[translateLanguage.indexOf(value!)];
    pickLanguage = value;
    setState(() {});
  }

  Future<void> translate() async {
    if (_textEditingController.text.isNotEmpty) {
      final translator = GoogleMlKit.nlp.onDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: targetLanguage!,
      );
      translatedText =
          await translator.translateText(_textEditingController.text);

      setState(() {});
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(labelText: "Enter Text"),
              ),
              DropdownButton<String>(
                autofocus: true,
                dropdownColor: Colors.grey,
                icon: const Icon(Icons.language),
                underline: const Divider(
                  thickness: 2,
                ),
                items: translateLanguage.map((e) {
                  return DropdownMenuItem<String>(
                    value: e, // Use the language itself as the value
                    child: Text(e),
                  );
                }).toList(),
                hint: Text(targetLanguage == null
                    ? "Select language to translate"
                    : pickLanguage),
                onChanged: (value) {
                  _handleLanguageChange(value);
                },
              ),
              const Text("translated language:"),
              Text(translatedText),
              TextButton(
                onPressed: () {
                  translate();
                },
                child: const Text("Translate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
