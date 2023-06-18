import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:historycollection/models/chats/chats_model.dart';

class ChatsApiService {
  static Future<List<ChatModel>> getChatsItems() async {
    final jsonStr =
        await rootBundle.loadString("assets/jsons/chatTempData.json");
    List<dynamic> jsonList = jsonDecode(jsonStr);
    List<ChatModel> items =
        jsonList.map((json) => ChatModel.fromJson(json)).toList();
    return items;
  }
}
