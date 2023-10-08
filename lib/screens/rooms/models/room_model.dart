import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomModel {
  String chatKey;
  Map<String, dynamic> joiners;

  RoomModel({
    required this.chatKey,
    required this.joiners,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatKey': chatKey,
      'joiners': joiners,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      chatKey: map['chatKey'] as String,
      joiners: Map<String, String>.from(
        (map['joiners'] as Map<String, dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
