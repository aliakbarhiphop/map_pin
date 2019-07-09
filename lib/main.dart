import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void setUpMarker() {
    final MarkerId markerId = MarkerId("marker_id_1");
    final Marker marker = Marker(
        markerId: markerId,
        consumeTapEvents: false,
        position: LatLng(37.42796133580664, -122.085749655962),
        infoWindow: InfoWindow(title: 'Just Text'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    super.initState();
    setUpMarker();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        markers: Set<Marker>.of(markers.values),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
