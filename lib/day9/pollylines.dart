import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PollylineOnMap extends StatefulWidget {
  const PollylineOnMap({super.key});

  @override
  State<PollylineOnMap> createState() => _PollylineOnMapState();
}

class _PollylineOnMapState extends State<PollylineOnMap> {
  final Completer<GoogleMapController> _controller = Completer();
  String themeData = "";
  final List<Marker> _markesr = [];
  final Set<Polyline> _pollyline = {};
  final List<LatLng> _latLngs = [
    const LatLng(26.811575, 87.342711),
    const LatLng(26.848339, 87.203322),
    const LatLng(26.811578, 87.3932731),
    const LatLng(26.348339, 87.903322),
  ];
  addMarker() {
    for (int i = 0; i < _latLngs.length; i++) {
      _markesr.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latLngs[i],
          infoWindow: InfoWindow(
            title: "location $i",
            snippet: "ddjjd",
          )));
    }
  }

  addPollylines() {
    _pollyline.add(Polyline(
        polylineId: const PolylineId("1"),
        points: _latLngs,
        color: Colors.red));
  }

  @override
  void initState() {
    // TODO: implement initState
    addPollylines();
    addMarker();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pollylines"),
        actions: [
          PopupMenuButton<int>(
              onSelected: (value) {},
              itemBuilder: ((context) => [
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString("asset/style/nighttheme.json")
                              .then((style) {
                            value.setMapStyle(style);
                          });
                        });
                      },
                      value: 1,
                      child: const Text("Night theme"),
                    ),
                    PopupMenuItem(
                      value: 2,
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString("asset/style/darktheme.json")
                              .then((style) {
                            value.setMapStyle(style);
                          });
                        });
                      },
                      child: const Text("Dark theme"),
                    ),
                    PopupMenuItem(
                        value: 3,
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("asset/style/retro.json")
                                .then((style) {
                              value.setMapStyle(style);
                            });
                          });
                        },
                        child: const Text("Retro theme"))
                  ]))
        ],
      ),
      body: GoogleMap(
          // compassEnabled: true,
          // buildingsEnabled: true,
          // liteModeEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_markesr),
          onMapCreated: (GoogleMapController c) {
            themeData == "" ? null : c.setMapStyle(themeData);
            _controller.complete(c);
          },
          polylines: _pollyline,
          initialCameraPosition: const CameraPosition(
              target: LatLng(26.811575, 87.342711), zoom: 14)),
    );
  }
}
