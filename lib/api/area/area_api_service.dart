import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:historycollection/models/area/area_model.dart';

class AreaApiService {
  static Future<List<AraeModel>> getAreaItems() async {
    final jsonStr =
        await rootBundle.loadString("assets/jsons/areaTempData.json");
    List<dynamic> jsonList = jsonDecode(jsonStr);
    List<AraeModel> items =
        jsonList.map((json) => AraeModel.fromJson(json)).toList();
    return items;
  }
}
