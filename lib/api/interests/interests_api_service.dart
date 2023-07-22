import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:historycollection/screens/interests/models/interests_model.dart';

class InterestsApiService {
  static Future<List<InterestModel>> getInterestsApi() async {
    final jsonStr =
        await rootBundle.loadString("assets/jsons/interestTempData.json");
    List<dynamic> jsonList = jsonDecode(jsonStr);
    List<InterestModel> items =
        jsonList.map((json) => InterestModel.fromMap(json)).toList();
    return items;
  }

  static Future<List<InterestModel>> getMyInterestsApi() async {
    final jsonStr =
        await rootBundle.loadString("assets/jsons/interestMyTempData.json");
    List<dynamic> jsonList = jsonDecode(jsonStr);
    List<InterestModel> items =
        jsonList.map((json) => InterestModel.fromMap(json)).toList();
    return items;
  }
}
