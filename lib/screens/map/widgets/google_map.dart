// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const _initPosition = CameraPosition(
  target: LatLng(37.6189623, 127.1628922),
  zoom: 14.4746,
);

const Set<Marker> _empty = {};

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    super.key,
    this.kPosition = _initPosition,
    this.markers = _empty,
    required this.gController,
  });

  final CameraPosition kPosition;
  final Set<Marker> markers;

  final Completer<GoogleMapController> gController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: kPosition,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: markers,
      onMapCreated: (controller) {
        if (!gController.isCompleted) {
          gController.complete(controller);
        }
      },
    );
  }
}
