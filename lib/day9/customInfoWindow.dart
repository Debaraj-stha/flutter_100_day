import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindows extends StatefulWidget {
  const CustomInfoWindows({super.key});

  @override
  State<CustomInfoWindows> createState() => _CustomInfoWindowsState();
}

class _CustomInfoWindowsState extends State<CustomInfoWindows> {
  final CustomInfoWindowController _controller =
      CustomInfoWindowController(); //
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
  final List<Marker> _markesr = [];
  addMarkers() {
    _markesr.addAll(_markerList);
    for (var i = 0; i < _latLngs.length; i++) {
      _markesr.add(Marker(
        icon: BitmapDescriptor.defaultMarker,
        position: _latLngs[i],
        onTap: () {
          _controller.addInfoWindow!(
              Container(
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage("asset/images/c.jpg"),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Text("Markers $i")
                  ],
                ),
              ),
              _latLngs[i]);
        },
        markerId: MarkerId(i.toString()),
      ));
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addMarkers();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("custom info window"),
      ),
      body: Stack(
        children: [
          GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.googleMapController = controller;
              },
              markers: Set<Marker>.of(_markesr),
              onTap: (position) {
                _controller.hideInfoWindow!();
              },
              onCameraMove: (position) => _controller.onCameraMove!(),
              initialCameraPosition: const CameraPosition(
                  target: LatLng(26.824949, 87.275722), zoom: 14)),
          CustomInfoWindow(
            controller: _controller,
            height: 200,
            width: 250,
            offset: 35,
          )
        ],
      ),
    );
  }
}
