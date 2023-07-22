import 'package:historycollection/screens/map/models/map_position_model.dart';
import 'package:historycollection/screens/map/models/marker_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapRepository {
  static const storageMarkersKey = "SAVED_MARKERS";
  static const storagePositionKey = "SAVED_LOCATION";

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  bool get isMarkers {
    List<String>? strMarkers = _preferences.getStringList(storageMarkersKey);

    if (strMarkers == null) {
      return false;
    }

    if (strMarkers.isEmpty) {
      return false;
    }

    return true;
  }

  void setMarkers(MarkerModel model) {
    List<String>? strMarkers = _preferences.getStringList(storageMarkersKey);

    if (strMarkers == null) {
      _preferences.setStringList(
        storageMarkersKey,
        [
          model.toJson(),
        ],
      );
      return;
    }

    _preferences.setStringList(
      storageMarkersKey,
      [...strMarkers, model.toJson()],
    );
  }

  List<MarkerModel> get getMarkers {
    List<String> strMarkers = _preferences.getStringList(storageMarkersKey)!;

    return strMarkers
        .map(
          (strMarker) => MarkerModel.fromJson(strMarker),
        )
        .toList();
  }

  void setThisPosition(MapPosition position) {
    String? strPosition = _preferences.getString(storagePositionKey);
    if (strPosition == null) {
      _preferences.setString(
        storagePositionKey,
        position.toJson(),
      );
      return;
    }

    strPosition = position.toJson();
    _preferences.setString(
      storagePositionKey,
      position.toJson(),
    );
  }

  MapPosition get getThisPosition {
    String? strPosition = _preferences.getString(storagePositionKey);
    if (strPosition == null || strPosition.isEmpty) {
      return MapPosition(
        lat: 37.7189623,
        lng: 127.1628922,
      );
    }

    return MapPosition.fromJson(
      strPosition,
    );
  }
}
