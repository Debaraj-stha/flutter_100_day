import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GetLocationFromCordinate extends StatefulWidget {
  const GetLocationFromCordinate({super.key});

  @override
  State<GetLocationFromCordinate> createState() =>
      _GetLocationFromCordinateState();
}

class _GetLocationFromCordinateState extends State<GetLocationFromCordinate> {
  String country = "";
  String couyntrycode = "";
  List location = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get location from coordinate"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text("country  + $country"),
              TextButton.icon(
                  onPressed: () async {
                    List<Placemark> place =
                        await placemarkFromCoordinates(26.809821, 87.3000599);
                    final data = place[0];
                    print(data);
                    setState(() {
                      country = data.country!;
                      couyntrycode = data.isoCountryCode!;
                    });
                  },
                  icon: const Icon(Icons.search),
                  label: const Text("Search from coordinate")),
              TextButton.icon(
                  onPressed: () async {
                    List<Location> place =
                        await locationFromAddress("Dharan bagarkot,Nepal");
                    final data = place[0];
                    setState(() {
                      location.addAll(
                          [data.latitude.toString(), data.longitude.toString(), data.timestamp.toString()]);
                    });
                    print(data);
                  },
                  icon: const Icon(Icons.search),
                  label: const Text("Search from address")),
              location.isNotEmpty
                  ? Wrap(
                      children:
                          List.generate(3, (index) => Text(location[index])),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
