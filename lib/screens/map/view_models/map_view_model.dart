import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:historycollection/api/map/map_api_service.dart';
import 'package:image/image.dart' as IMG;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:historycollection/screens/map/models/map_model.dart';
import 'package:historycollection/screens/map/models/map_position_model.dart';
import 'package:historycollection/screens/map/models/marker_model.dart';
import 'package:historycollection/screens/map/repos/map_repository.dart';

class MapViewModel extends AsyncNotifier<MapModel> {
  final MapRepository _repository = MapRepository();
  Map<MarkerId, Marker> markers = {};

  void setMapMarker(MarkerModel model) {
    state = const AsyncValue.loading();

    _repository.setMarkers(model);

    state = AsyncValue.data(
      MapModel(
        markerList: _repository.getMarkers,
        mapPosition: state.value!.mapPosition,
      ),
    );
  }

  void setThisPosition(MapPosition position) {
    state = const AsyncValue.loading();

    _repository.setThisPosition(position);

    List<MarkerModel> list = [];

    state = AsyncValue.data(
      MapModel(
        markerList: state.value == null ? list : state.value!.markerList,
        mapPosition: _repository.getThisPosition,
      ),
    );
  }

  MapPosition get getThisPosition {
    return _repository.getThisPosition;
  }

  Future<Map<MarkerId, Marker>> getMarkers(List<MarkerModel> markerList) async {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

    if (markerList.isNotEmpty) {
      List<Future<Marker>> list = markerList.asMap().values.map((obj) async {
        // Map<MarkerId, Marker> markerMap = <MarkerId, Marker>{};
        MarkerId markerId = MarkerId(obj.markerId);

        Uint8List? bytes = await _getImgBytes(obj.winIcon);
// await  ImageConfiguration((size: Size(48, 48)), 'assets/my_icon.png'));
        // ImageConfiguration(bundle: AssetBundl);
        // BitmapDescriptor.fromAssetImage();

        Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            obj.mapPosition.lat,
            obj.mapPosition.lng,
          ),
          icon: bytes == null
              ? BitmapDescriptor.defaultMarker
              : BitmapDescriptor.fromBytes(bytes),

          //   BitmapDescriptor.defaultMarkerWithHue(
          // BitmapDescriptor.hueYellow,
          // ),
          infoWindow: InfoWindow(
            title: obj.title,
            snippet: obj.snippet,
          ),
        );

        // markerMap[markerId] = marker;
        return marker;
      }).toList();

      for (var obj in list) {
        Marker m = await obj;
        markers[m.markerId] = m;
      }
    }

    return markers;
  }

  Future<Uint8List?> _getImgBytes(String imgUrl) async {
    Uint8List? resizedImg;
    try {
      final ByteData imageData =
          await NetworkAssetBundle(Uri.parse(imgUrl)).load("");

      final Uint8List bytes = imageData.buffer.asUint8List();

      IMG.Image? img = IMG.decodeImage(bytes);
      IMG.Image resized = IMG.copyResize(img!, width: 80, height: 80);
      resizedImg = Uint8List.fromList(
        IMG.encodePng(resized),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return resizedImg;
    }

    return (resizedImg);
  }

  Future<String> getAddress(double lat, lng) async {
    return await _repository.getAddress(lat, lng);
  }

  @override
  FutureOr<MapModel> build() async {
    // throw UnimplementedError();
    List<MarkerModel> markers = [];

    if (_repository.isMarkers) {
      markers = [
        ..._repository.getMarkers,
      ];
    } else {
      List<MarkerModel> list = await MapApiService.getAreaItems();
      markers = [
        ...list,
      ];

      for (var obj in list) {
        _repository.setMarkers(obj);
      }
    }

    // _getImgBytes("https://www.fluttercampus.com/img/banner.png");

    MapPosition position = _repository.getThisPosition;

    return MapModel(
      markerList: markers,
      mapPosition: position,
    );
  }
}

final mapProvider = AsyncNotifierProvider<MapViewModel, MapModel>(
  () => MapViewModel(),
);
