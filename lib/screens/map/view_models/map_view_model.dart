import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        markerModel: _repository.getMarkers,
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
        markerModel: state.value == null ? list : state.value!.markerModel,
        mapPosition: _repository.getThisPosition,
      ),
    );
  }

  @override
  FutureOr<MapModel> build() {
    // TODO: implement build
    // throw UnimplementedError();
    List<MarkerModel> markers = [];

    if (_repository.isMarkers) {
      markers = [
        ..._repository.getMarkers,
      ];
    }

    MapPosition position = _repository.getThisPosition;

    return MapModel(markerModel: markers, mapPosition: position);
  }
}

final mapProvider = AsyncNotifierProvider<MapViewModel, MapModel>(
  () => MapViewModel(),
);
