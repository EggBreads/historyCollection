// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:historycollection/screens/chats/models/chats_room_model.dart';

class ChatsModel {
  String userName;
  List<ChatsRoomModel> chats;

  ChatsModel({
    required this.userName,
    required this.chats,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'chats': chats.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatsModel.fromMap(Map<String, dynamic> map) {
    return ChatsModel(
      userName: map['userName'] as String,
      chats: List<ChatsRoomModel>.from(
        (map['chats'] as List<dynamic>).map<ChatsRoomModel>(
          (x) => ChatsRoomModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatsModel.fromJson(String source) =>
      ChatsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
