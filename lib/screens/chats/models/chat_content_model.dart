import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatContentModel {
  String text;
  String senderEmail;

  ChatContentModel({
    required this.text,
    required this.senderEmail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'senderEmail': senderEmail,
    };
  }

  factory ChatContentModel.fromMap(Map<String, dynamic> map) {
    return ChatContentModel(
      text: map['text'] as String,
      senderEmail: map['senderEmail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatContentModel.fromJson(String source) =>
      ChatContentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
