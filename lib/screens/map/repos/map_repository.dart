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
    List<String> strMarkers = _preferences.getStringList(storageMarkersKey)!;

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
    _preferences.setString(
      storagePositionKey,
      position.toJson(),
    );
  }

  MapPosition get getThisPosition {
    String strPosition = _preferences.getString(storagePositionKey)!;

    return MapPosition.fromJson(
      strPosition,
    );
  }
}
