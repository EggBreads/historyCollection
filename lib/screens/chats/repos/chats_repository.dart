// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/screens/chats/models/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:historycollection/utils/databse.dart';

class ChatsRepository {
  String chatKey;

  ChatsRepository({
    required this.chatKey,
  });

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  Future<void> saveChatMessage(ChatModel chat) async {
    List<String>? list = _preferences.getStringList(chatKey);

    if (list == null) {
      await _preferences.setStringList(chatKey, [chat.toJson()]);
      return;
    }

    await _preferences.setStringList(chatKey, [...list, chat.toJson()]);
  }

  List<ChatModel> get getChats {
    List<String>? chatsRoom = _preferences.getStringList(chatKey);

    if (chatsRoom == null) {
      return [];
    }

    return chatsRoom.map((e) => ChatModel.fromJson(e)).toList();
  }
}

final chatProvider = Provider.family<ChatsRepository, String>(
    (ref, arg) => ChatsRepository(chatKey: arg));
