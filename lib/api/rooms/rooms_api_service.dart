import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';

class RoomsApiService {
  static Future<List<RoomModel>> getAreaItems() async {
    final jsonStr =
        await rootBundle.loadString("assets/jsons/roomsTempData.json");
    List<dynamic> jsonList = jsonDecode(jsonStr);

    List<RoomModel> items =
        jsonList.map((json) => RoomModel.fromMap(json)).toList();

    return items;
  }
}
