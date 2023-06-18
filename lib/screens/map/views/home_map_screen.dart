import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/map/models/map_position_model.dart';
import 'package:historycollection/screens/map/view_models/map_view_model.dart';
import 'package:historycollection/screens/map/widgets/google_map.dart';

class HomeMapScreen extends ConsumerStatefulWidget {
  const HomeMapScreen({Key? key}) : super(key: key);

  @override
  HomeMapScreenState createState() => HomeMapScreenState();
}

class HomeMapScreenState extends ConsumerState<HomeMapScreen> {
  late Position _mapPosition;
  late LocationPermission _permission;

  bool _hasLocationPermission = false;

  int _markerIdCounter = 1;
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CameraPosition _kInitPosition = const CameraPosition(
    target: LatLng(37.6189623, 127.1628922),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initGoogleMap();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initGoogleMap() async {
    // PermissionStatus status = await Permission.location.request();
    // if (status.isGranted) {
    //   _hasLocationPermission = true;
    // }
    await _chkPermission();

    await _setCurrentPosition();

    await _addMarker();
  }

  Future<void> _chkPermission() async {
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
    }

    setState(() {
      _hasLocationPermission = true;
    });
  }

  Future<void> _setCurrentPosition() async {
    Position position = await _getCurrentPosition();

    ref.read(mapProvider.notifier).setThisPosition(
          MapPosition(
            lat: position.latitude,
            lng: position.longitude,
          ),
        );
  }

  Future<void> _addMarker() async {
    // DateTime start = DateTime.now();
    _mapPosition = await _getCurrentPosition();
    await _goToPosition(_mapPosition);

    final int markerCount = _markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        _mapPosition.latitude,
        _mapPosition.longitude,
      ),
      // position: LatLng(
      //   mapPosition.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
      //   mapPosition.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
      // ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      // icon: BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, ),
      infoWindow: const InfoWindow(
        title: '123lkjdaflkjsd',
      ),
      // infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      // onTap: () => _onMarkerTapped(markerId),
      // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    setState(() {
      _markers[markerId] = marker;
      print(_markers);
    });
  }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      // forceAndroidLocationManager: true,
    );
  }

  Future<void> _goToPosition(Position p) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition carmeraPosition = CameraPosition(
      target: LatLng(p.latitude, p.longitude),
      zoom: 14.00,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(carmeraPosition));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: width,
            child: !_hasLocationPermission
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Requesting permissions....",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size20,
                        ),
                      ),
                      Gaps.v20,
                      CircularProgressIndicator.adaptive(),
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: GoogleMapWidget(
                          kPosition: _kInitPosition,
                          markers: Set<Marker>.of(_markers.values),
                          gController: _controller,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      // body: SafeArea(
      //   child: Column(
      //     children: [
      //       FractionallySizedBox(
      //         alignment: Alignment.center,
      //         heightFactor: 0.3,
      //         widthFactor: 0.3,
      //         child: Container(
      //           padding: EdgeInsets.zero,
      //           child: Stack(
      //             alignment: Alignment.center,
      //             children: [
      //               GoogleMap(
      //                 mapType: MapType.normal,
      //                 initialCameraPosition: _kInitPosition,
      //                 onMapCreated: (GoogleMapController controller) {
      //                   _controller.complete(controller);
      //                 },
      //                 myLocationButtonEnabled: false,
      //                 zoomControlsEnabled: false,
      //                 markers: Set<Marker>.of(markers.values),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       // Row(
      //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       //   children: <Widget>[
      //       //     TextButton(
      //       //       onPressed: addMarker,
      //       //       child: const Text('Add'),
      //       //     ),
      //       //     // TextButton(
      //       //     //   onPressed:
      //       //     //       selectedId == null ? null : () => _remove(selectedId),
      //       //     //   child: const Text('Remove'),
      //       //     // ),
      //       //   ],
      //       // ),
      //       // Visibility(
      //       //   visible: true,
      //       //   child: Container(
      //       //     color: Colors.white70,
      //       //     height: 30,
      //       //     padding: const EdgeInsets.only(left: 12, right: 12),
      //       //     child: Row(
      //       //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       //       children: const [
      //       //         Expanded(child: Text('test123123')),
      //       //       ],
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }
}
