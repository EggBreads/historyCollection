// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:historycollection/screens/chats/models/chat_content_model.dart';

class ChatModel {
  final String uuid;
  final bool isInvited;
  final ChatContentModel contents;

  ChatModel({
    required this.uuid,
    required this.isInvited,
    required this.contents,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'isInvited': isInvited,
      'contents': contents.toMap(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      uuid: map['uuid'] as String,
      isInvited: map['isInvited'] as bool,
      contents:
          ChatContentModel.fromMap(map['contents'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
