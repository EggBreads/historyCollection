import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:historycollection/screens/map/models/marker_model.dart';

class MapApiService {
  static Future<List<MarkerModel>> getAreaItems() async {
    final jsonStr =
        await rootBundle.loadString("assets/jsons/mapMarkersTempData.json");
    List<dynamic> jsonList = jsonDecode(jsonStr);

    List<MarkerModel> items =
        jsonList.map((json) => MarkerModel.fromMap(json)).toList();

    return items;
  }
}
