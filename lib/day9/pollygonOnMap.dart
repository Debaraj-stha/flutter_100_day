import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PollygonOnMap extends StatefulWidget {
  const PollygonOnMap({super.key});

  @override
  State<PollygonOnMap> createState() => _PollygonOnMapState();
}

class _PollygonOnMapState extends State<PollygonOnMap> {
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final List<Marker> _markers = [
    const Marker(
        markerId: MarkerId("2"),
        position: LatLng(26.811575, 87.342711),
        infoWindow: InfoWindow(title: "Current location"))
  ];
  final List<LatLng> _points = [
    const LatLng(26.811575, 87.342711),
    const LatLng(26.848339, 87.203322),
    const LatLng(26.871310, 87.305975),
    const LatLng(26.811575, 87.342711),
  ];
  addPolygon() {
    _polygons.add(Polygon(
        polygonId: const PolygonId("1"),
        points: _points,
        fillColor: const Color.fromARGB(255, 222, 218, 218),
        strokeWidth: 2,
        geodesic: true,
        strokeColor: Colors.blue));
  }

  @override
  void initState() {
    // TODO: implement initState
    addPolygon();
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
        title: const Text("Pollygon on map"),
      ),
      body: GoogleMap(
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_markers),
          myLocationEnabled: true,
          mapType: MapType.normal,
          polygons: _polygons,
          initialCameraPosition: const CameraPosition(
              target: LatLng(26.811575, 87.342711), zoom: 14)),
    );
  }
}
