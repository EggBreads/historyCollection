import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomModel {
  String chatKey;
  String title;
  String subTitle;
  String host;
  int maxCnt;
  List<String> joiners;

  RoomModel({
    required this.chatKey,
    required this.title,
    required this.subTitle,
    required this.host,
    required this.maxCnt,
    required this.joiners,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatKey': chatKey,
      'title': title,
      'subTitle': subTitle,
      'host': host,
      'maxCnt': maxCnt,
      'joiners': joiners,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      chatKey: map['chatKey'] as String,
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      host: map['host'] as String,
      maxCnt: map['maxCnt'] as int,
      joiners: List<String>.from(
        (map['joiners'] as List<dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
