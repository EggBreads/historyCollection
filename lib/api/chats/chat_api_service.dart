import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:historycollection/screens/chats/models/chats_model.dart';

class ChatsApiService {
  static Future<List<ChatsModel>> getChatsItems(String nickName) async {
    final jsonStr =
        await rootBundle.loadString("assets/jsons/chatTempData.json");
    List<dynamic> jsonList = jsonDecode(jsonStr);
    List<ChatsModel> items = jsonList
        .where((json) {
          final list = ChatsModel.fromMap(json);
          if (list.userName == nickName) {
            return true;
          }
          return false;
        })
        .map(
          (json) => ChatsModel.fromMap(json),
        )
        .toList();
    return items;
  }
}
