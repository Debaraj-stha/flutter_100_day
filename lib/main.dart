import 'package:flutter/material.dart';
import 'package:hundred_day/day1/flutterIsolate.dart';
import 'package:hundred_day/day2/home/ui/home.dart';
import 'package:hundred_day/day3/parallexEffect.dart';
import 'package:hundred_day/day3/parallexEffect1.dart';

import 'package:hundred_day/day4/animatedTab.dart';
import 'package:hundred_day/day4/scrollController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      color: Colors.white, // Text color for the button
                      fontSize: 16.0, // Adjust the font size as needed
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.greenAccent),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15)))),
          appBarTheme: const AppBarTheme(
              color: Colors.greenAccent,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  letterSpacing: 2, color: Colors.black, fontSize: 20))),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

TextStyle style = const TextStyle(
    fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(
                context,
                MaterialPageRoute(builder: (context) => const FlutterIsolate()),
                "Isolate day 1"),
            buildButton(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                "Bloc day 2"),
            buildButton(
                context,
                MaterialPageRoute(
                    builder: (context) => const ParallexEffect1()),
                "parallex Effect day 3"),
            buildButton(
                context,
                MaterialPageRoute(
                    builder: (context) => const AnimatedListTab()),
                "Animated tab day 4"),
                buildButton(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScrollControllerExample()),
                "scrollcontrller tab day 4")
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      BuildContext context, MaterialPageRoute route, String text) {
    return InkWell(
      onTap: () {
        Navigator.push(context, route);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.greenAccent),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
