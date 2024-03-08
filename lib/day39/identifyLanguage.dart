import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class LanguageIdentigier extends StatefulWidget {
  const LanguageIdentigier({super.key});

  @override
  State<LanguageIdentigier> createState() => _LanguageIdentigierState();
}

class _LanguageIdentigierState extends State<LanguageIdentigier> {
  final TextEditingController _controller = TextEditingController();
  String _identifiedLanguage = "";
  List<IdentifiedLanguage> _identifiedLanguages = <IdentifiedLanguage>[];
  final _languageidentifier = LanguageIdentifier(confidenceThreshold: 0.6);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
            ),
            TextButton(
                onPressed: () {
                  identifyLanguage();
                },
                child: const Text("indentify language")),
            TextButton(
                onPressed: () {
                  identifyLanguages();
                },
                child: const Text("indentify possible language"))
          ],
        ),
      )),
    );
  }

  void identifyLanguage() async {
    if (_controller.text.isNotEmpty) {
      String lang;
      try {
        lang = await _languageidentifier.identifyLanguage(_controller.text);
      } on PlatformException catch (pe) {
        if (pe.code == _languageidentifier.undeterminedLanguageCode) {
          lang = "no language detected";
        }
        lang = "error:${pe.code}:${pe.message}";
      } catch (e) {
        lang = "error:$e";
      }
      _identifiedLanguage = lang;
      setState(() {});
    }
  }

  void identifyLanguages() async {
    if (_controller.text.isNotEmpty) {
      String error;
      try {
        final res = await _languageidentifier
            .identifyPossibleLanguages(_controller.text);
        _identifiedLanguages = res;
        setState(() {});
        return;
      } on PlatformException catch (pe) {
        if (pe.code == _languageidentifier.undeterminedLanguageCode) {
          error = "no erroruage detected";
        }
        error = "error:${pe.code}:${pe.message}";
      } catch (e) {
        error = "error:$e";
      }

      setState(() {
        _identifiedLanguage = error;
        _identifiedLanguages = [];
      });
    }
  }
}
