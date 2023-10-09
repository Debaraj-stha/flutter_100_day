import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hundred_day/day8/bloc/translate_bloc.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  List<String> translateToCode = [];
  List<Map<String, dynamic>> translateToLnaguage = [
    {"lang": "English", "code": "en"},
    {"lang": "Nepali", "code": "ne"},
    {"lang": "French", "code": "fr"}
  ];
  TranslateBloc translatebloc = TranslateBloc();
  TextEditingController textcontroller = TextEditingController();
  String value = "English";
  String selectedCode = "en";
  String translatedMessage = "";
  void a(String value) {
    final x = translateToLnaguage.where((element) => element['lang'] == value);
    print(x);
  }

  tranalate() async {
    if (textcontroller.text.isNotEmpty) {
      // Check if text is not empty
      await GoogleTranslator()
          .translate(textcontroller.text, to: selectedCode)
          .then((value) {
        translatedMessage = value.text;
        setState(() {});
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter some text")));
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language translator"),
      ),
      body: BlocConsumer<TranslateBloc, TranslateState>(
        bloc: translatebloc,
        // buildWhen: (previous, current) => current is! TranslateActionState,
        // listenWhen: (previous, current) => current is TranslateActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChangedLanguageState:
              final changedLanguageState = state as ChangedLanguageState;
              value = changedLanguageState.language.first['lang'];
              selectedCode = changedLanguageState.language.first['code'];
              print(value);
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("To"),
                          DropdownButton(
                            value: value,
                            items: translateToLnaguage
                                .map((e) => DropdownMenuItem<String>(
                                      value: e['lang'],
                                      child: Text(e['lang']),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              a(value!);
                              translatebloc.add(ChnageLanguageTo(
                                  language: translateToLnaguage.where(
                                      (element) => element['lang'] == value)));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: textcontroller,
                    decoration:
                        const InputDecoration(hintText: "Enter here..."),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Translatd to $value"),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    translatedMessage,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextButton(
                      onPressed: () {
                        tranalate();
                      },
                      child: const Text("Translate"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
