import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:historycollection/screens/area/models/area_model.dart';

class AreaApiService {
  static Future<List<AraeModel>> getAreaItems() async {
    final jsonStr =
        await rootBundle.loadString("assets/jsons/areaTempData.json");
    List<dynamic> jsonList = jsonDecode(jsonStr);
    List<AraeModel> items = jsonList.map((json) {
      return AraeModel.fromMap(json);
    }).toList();
    return items;
  }
}
