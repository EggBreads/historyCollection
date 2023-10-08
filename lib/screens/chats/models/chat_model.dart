import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatModel {
  final String chatKey;
  final String message;
  final String senderEmail;
  final int createdAt;

  ChatModel({
    required this.chatKey,
    required this.message,
    required this.senderEmail,
    required this.createdAt,
  });

  // final ChatContentModel contents;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatKey': chatKey,
      'message': message,
      'senderEmail': senderEmail,
      'createdAt': createdAt,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatKey: map['chatKey'] as String,
      message: map['message'] as String,
      senderEmail: map['senderEmail'] as String,
      createdAt: map['createdAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
