import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:historycollection/screens/map/models/map_position_model.dart';
import 'package:historycollection/screens/map/models/marker_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  Future<String> getAddress(double lat, lng) async {
    final client = http.Client();
    String latlng = "$lat,$lng";
    Map<String, String> params = {
      "key": "AIzaSyDx1jM_62He-G4ubC8-uPPlAS3n5fkMCk8",
      "latlng": latlng,
      "language": "ko",
    };
    final url = Uri.https(
      "maps.googleapis.com",
      "/maps/api/geocode/json",
      params,
    );

    final res = await client.get(url).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
      return Response("err", 401);
      // return error;
    });

    if (res.statusCode != 200) {
      return '';
    }

    final jsonRes = jsonDecode(res.body) as Map<String, dynamic>;

    final results = jsonRes['results'];

    final result = results[0];

    final address = result['formatted_address'] as String;
    return address;
  }
}
