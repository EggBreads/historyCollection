import 'package:historycollection/screens/chats/models/chat_model.dart';
import 'package:historycollection/screens/chats/models/chats_room_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsRepository {
  static const chatsKey = "SAVED_CHATS";
  static const chatUserKey = "CHATS_NICKNAME";
  // static const chatsOtherstKey = "SAVED_INTEREST";

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  Future<void> initChats(String nickName) async {
    await _preferences.setString(chatUserKey, nickName);
  }

  Future<String> get getNickName async {
    String? chatUser = _preferences.getString(chatUserKey);

    if (chatUser == null || chatUser.isEmpty) {
      return "";
    }

    return chatUser;
  }

  Future<void> addChatOnRoom(ChatModel chat, String roomKey) async {
    List<String> chatsRoom = _preferences.getStringList(chatsKey)!;

    List<String> list = chatsRoom.map((room) {
      ChatsRoomModel result = ChatsRoomModel.fromJson(room);

      if (result.roomKey == roomKey) {
        result.chat.add(chat);
        return result.toJson();
      }
      return room;
    }).toList();

    await _preferences.setStringList(
      chatsKey,
      [
        ...list,
      ],
    );
  }

  Future<void> setRoomOnUser(ChatsRoomModel chatRoom) async {
    List<String>? chatsRoom = _preferences.getStringList(chatsKey);

    if (chatsRoom == null || chatsRoom.isEmpty) {
      await _preferences.setStringList(
        chatsKey,
        [
          chatRoom.toJson(),
        ],
      );
      return;
    }

    final result = chatsRoom.map((room) {
      final roomModel = ChatsRoomModel.fromJson(room);

      if (roomModel.roomKey == chatRoom.roomKey) {
        return chatRoom.toJson();
      }

      return room;
    });

    if (result.isNotEmpty) {
      await _preferences.setStringList(
        chatsKey,
        [
          ...result,
        ],
      );
      return;
    }

    await _preferences.setStringList(
      chatsKey,
      [
        ...result,
        chatRoom.toJson(),
      ],
    );
  }

  List<ChatsRoomModel> get getChatsRoomList {
    List<String> chatsRoom = _preferences.getStringList(chatsKey)!;

    return chatsRoom.map((e) => ChatsRoomModel.fromJson(e)).toList();
  }

  Future<bool> hasRoom(String roomKey) async {
    List<String>? chatsRoom = _preferences.getStringList(chatsKey);

    if (chatsRoom == null || chatsRoom.isEmpty) {
      return false;
    }

    List<String> list = chatsRoom.where((room) {
      ChatsRoomModel result = ChatsRoomModel.fromJson(room);
      return result.roomKey == roomKey;
    }).toList();

    return list.isNotEmpty;
  }

  //   Future<void> setChatUser(ChatsRoomModel chatRoom) async {
  //   List<String>? chatsRoom = _preferences.getStringList(chatsKey);

  //   if (chatsRoom == null || chatsRoom.isEmpty) {
  //     await _preferences.setStringList(
  //       chatsKey,
  //       [
  //         chatRoom.toJson(),
  //       ],
  //     );
  //     return;
  //   }

  //   await _preferences.setStringList(
  //     chatsKey,
  //     [
  //       ...chatsRoom,
  //       chatRoom.toJson(),
  //     ],
  //   );
  // }
}
