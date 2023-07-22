import 'dart:async';

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

  Map<MarkerId, Marker> getMarkers(List<MarkerModel> markerList) {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

    if (markerList.isNotEmpty) {
      List<Marker> list = markerList.asMap().values.map((obj) {
        // Map<MarkerId, Marker> markerMap = <MarkerId, Marker>{};
        MarkerId markerId = MarkerId(obj.markerId);

        // Uint8List bytes = await _getImgBytes(obj.winIcon);

        Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            obj.mapPosition.lat,
            obj.mapPosition.lng,
          ),
          icon:
              // BitmapDescriptor.fromBytes(bytes),
              BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueYellow,
          ),
          infoWindow: InfoWindow(
            title: obj.title,
            snippet: obj.snippet,
          ),
        );

        // markerMap[markerId] = marker;
        return marker;
      }).toList();

      for (var obj in list) {
        Marker m = obj;
        markers[m.markerId] = m;
      }
    }

    return markers;
  }

  Future<Uint8List> _getImgBytes(String imgUrl) async {
    // Uint8List bytes = (await NetworkAssetBundle(
    //   Uri.parse(imgUrl),
    // ).load(
    //   "",
    // ))
    //     .buffer
    //     .asUint8List();

    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(imgUrl)).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();

    // BitmapDescriptor d = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(),
    //   "assets/images/bike.png",
    // );

    IMG.Image? img = IMG.decodeImage(bytes);
    IMG.Image resized = IMG.copyResize(img!, width: 80, height: 80);
    Uint8List resizedImg = Uint8List.fromList(
      IMG.encodePng(resized),
    );

    return resizedImg;
  }

  @override
  FutureOr<MapModel> build() async {
    // TODO: implement build
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
