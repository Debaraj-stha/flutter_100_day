import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(26.824949, 87.275722), zoom: 14);
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markesr = [];
  final List<String> images = [
    "asset/images/university.png",
    "asset/images/market.png",
    "asset/images/hospital-building.png"
  ];
  final List<LatLng> _latLngs = [
    const LatLng(26.824949, 87.275722),
    const LatLng(26.2, 87.2),
    const LatLng(26.3, 87.3)
  ];
  final List<Marker> _markerList = [
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(26.824949, 87.275722),
        infoWindow: InfoWindow(title: "My location")),
    const Marker(
      markerId: MarkerId("2"),
      position: LatLng(37.212, 86.275722),
    )
  ];
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo framinfo = await codec.getNextFrame();
    return (await framinfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> addMarkers() async {

    _markesr.addAll(_markerList);
    for (var i = 0; i < images.length; i++) {
      final Uint8List icon = await getBytesFromAsset(images[i], 100);

      _markesr.add(Marker(
          icon: BitmapDescriptor.fromBytes(icon),
          position: _latLngs[i],
          markerId: MarkerId(i.toString()),
          infoWindow: InfoWindow(title: "Marker $i")));
    }
    setState(() {});
  }

  Future<void> movetToPosition(CameraPosition position) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        position)); //move to the camera to given latitude and longitude
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission() //ask the permission for using location
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error: $error");
    });
    return await Geolocator
        .getCurrentPosition(); //return the user current latuitude and longitude
  }

  @override
  void initState() {
    // TODO: implement initState
    addMarkers();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google map"),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_markesr),
        myLocationEnabled: true,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //  movetToPosition(CameraPosition(target: LatLng(37.212, 86.275722)));
          getUserCurrentLocation().then((value) {
            _markesr.add(Marker(
                // infoWindow: const InfoWindow(title: "my current location"),
                markerId: const MarkerId("3"),
                position: LatLng(value.latitude, value.longitude)));
            CameraPosition position = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14);
            movetToPosition(position);
          });
          setState(() {});
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
