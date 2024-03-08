import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hundred_day/day1/flutterIsolate.dart';
import 'package:hundred_day/day10/clippath.dart';
import 'package:hundred_day/day12/advancedBloc.dart';
import 'package:hundred_day/day13/readingAndWritingFile.dart';
import 'package:hundred_day/day14/PPSizePhotoMaker.dart';
import 'package:hundred_day/day15/imagecropper.dart';
import 'package:hundred_day/day16/sharedpreference.dart';
import 'package:hundred_day/day17/calculator.dart';
import 'package:hundred_day/day18/shareFile.dart';
import 'package:hundred_day/day2/home/ui/home.dart';
import 'package:hundred_day/day3/parallexEffect.dart';
import 'package:hundred_day/day3/parallexEffect1.dart';
import 'package:hundred_day/day4/animatedTab.dart';
import 'package:hundred_day/day4/scrollController.dart';
import 'package:hundred_day/day6/dragablwwidget.dart';
import 'package:hundred_day/day6/photoEditor.dart';
import 'package:hundred_day/day7/clip.dart';
import 'package:hundred_day/day7/masoniryGrid.dart';
import 'package:hundred_day/day8/textReconizer.dart';
import 'package:hundred_day/day9/customInfoWindow.dart';
import 'package:hundred_day/day9/getLocationFromCord.dart';
import 'package:hundred_day/day9/placeSearch.dart';
import 'package:hundred_day/day9/pollygonOnMap.dart';
import 'package:hundred_day/day9/pollylines.dart';

import 'day11/cubicto.dart';
import 'day8/translater.dart';
import 'day9/googlemap.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
        home: const MyFadeTransition()
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
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const FlutterIsolate()),
              //     "Isolate day 1"),
              buildButton(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  "Bloc day 2"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ParallexEffect1()),
              //     "parallex Effect day 3"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const AnimatedListTab()),
              //     "Animated tab day 4"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ScrollControllerExample()),
              //     "scrollcontrller  day 5"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(builder: (context) => const PhotoEditor()),
              //     "dragable widget  day 6"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(builder: (context) => MasoniryGrid()),
              //     "gridview   day 7"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(builder: (context) => const Clip()),
              //     "cuctompath cliper day 7"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(builder: (context) => const ReconizeText()),
              //     "Text Reconizer day 8"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const LanguageTranslator()),
              //     "language translator day 8"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(builder: (context) => const Map()),
              //     "google map day 9"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const GetLocationFromCordinate()),
              //     "google map get location from coordinate day 9"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(builder: (context) => const SearchPlace()),
              //     "google map place search day 9"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const CustomInfoWindows()),
              //     "Custom info window day 9"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const PollygonOnMap()),
              //     "pollygon on map day 9"),
              // buildButton(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const PollylineOnMap()),
              //     "Pollyline on map day 9"),
              buildButton(
                  context,
                  MaterialPageRoute(builder: (context) => Clippath()),
                  "clippath day 10"),
              buildButton(
                  context,
                  MaterialPageRoute(builder: (context) => const CubicTo()),
                  "clippath cubicTo day 11"),
              buildButton(
                  context,
                  MaterialPageRoute(builder: (context) => const AdvancedBloc()),
                  "Advanced Bloc day 12"),
              buildButton(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReadingAndWritingFile()),
                  "reading and writing file"),

              buildButton(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PPSizePhotoMaker()),
                  "Passport size photo maker"),
              //   buildButton(
              // context,
              // MaterialPageRoute(
              //     builder: (context) => const ImageCrop()),
              // "Cropimage"),
              buildButton(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SharedPreferences()),
                  "Shared preferences"),
              buildButton(
                  context,
                  MaterialPageRoute(builder: (context) => const Calculator()),
                  "Calculator"),
              buildButton(
                  context,
                  MaterialPageRoute(builder: (context) => const ShareFile()),
                  "share file"),
            ],
          ),
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
