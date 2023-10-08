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
  late LocationPermission _permission;

  bool _hasLocationPermission = false;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CameraPosition _kInitPosition = const CameraPosition(
    target: LatLng(37.6189623, 127.1628922),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _initGoogleMap();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initGoogleMap() async {
    await _chkPermission();

    await _setCurrentPosition();
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

  // FutureProvider<Map<MarkerId, Marker>> _getMarkersProvider(
  //     List<MarkerModel> data) {
  //   final markerProvider = FutureProvider<Map<MarkerId, Marker>>(
  //     (ref) async {
  //       final map = ref.read(mapProvider.notifier).getMarkers(data);
  //       return map;
  //     },
  //   );

  //   return markerProvider;
  // }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      // forceAndroidLocationManager: true,
    );
  }

  // Future<void> _goToPosition(Position p) async {
  //   final GoogleMapController controller = await _controller.future;
  //   CameraPosition carmeraPosition = CameraPosition(
  //     target: LatLng(p.latitude, p.longitude),
  //     zoom: 14.00,
  //   );
  //   controller.animateCamera(CameraUpdate.newCameraPosition(carmeraPosition));
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ref.watch(mapProvider).whenOrNull(
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (error, stackTrace) => Center(
                child: Text("Could not load videos: $error"),
              ),
              data: (data) {
                // Map<MarkerId, Marker> mapMarks = {};

                // if (data.markerList.isNotEmpty) {
                // mapMarks = ref
                //     .read(mapProvider.notifier)
                //     .getMarkers(data.markerList);
                // }
                return SizedBox(
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
                            FutureBuilder(
                              future: ref
                                  .read(mapProvider.notifier)
                                  .getMarkers(data.markerList),
                              builder: (context, snapshot) {
                                return Positioned(
                                  child: GoogleMapWidget(
                                    kPosition: _kInitPosition,
                                    markers: snapshot.data == null
                                        ? {}
                                        : Set<Marker>.of(snapshot.data!.values),
                                    gController: _controller,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                );
              },
            ),
      ),
    );
  }
}
