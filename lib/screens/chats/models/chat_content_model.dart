import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatContentModel {
  String text;
  bool isSender;
  bool isReciver;

  ChatContentModel({
    required this.text,
    required this.isSender,
    required this.isReciver,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isSender': isSender,
      'isReciver': isReciver,
    };
  }

  factory ChatContentModel.fromMap(Map<String, dynamic> map) {
    return ChatContentModel(
      text: map['text'] as String,
      isSender: map['isSender'] as bool,
      isReciver: map['isReciver'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatContentModel.fromJson(String source) =>
      ChatContentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
