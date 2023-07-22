// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:historycollection/screens/chats/models/chat_model.dart';

class ChatsRoomModel {
  String roomKey;
  String title;
  List<ChatModel> chat;

  ChatsRoomModel({
    required this.roomKey,
    required this.title,
    required this.chat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomKey': roomKey,
      'title': title,
      'chat': chat.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatsRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatsRoomModel(
      roomKey: map['roomKey'] as String,
      title: map['title'] as String,
      chat: List<ChatModel>.from(
        (map['chat'] as List<dynamic>).map<ChatModel>(
          (x) => ChatModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatsRoomModel.fromJson(String source) =>
      ChatsRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
