// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:historycollection/screens/map/models/map_position_model.dart';

class AraeModel {
  String chatKey;
  String title;
  String subTitle;
  String hostEmail;
  String nickName;
  String shotImg;
  String interest;
  String location;
  MapPosition position;
  int enterCnt;
  int createdAt;

  AraeModel({
    required this.chatKey,
    required this.title,
    required this.subTitle,
    required this.hostEmail,
    required this.nickName,
    required this.shotImg,
    required this.interest,
    required this.location,
    required this.position,
    required this.enterCnt,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatKey': chatKey,
      'title': title,
      'subTitle': subTitle,
      'hostEmail': hostEmail,
      'nickName': nickName,
      'shotImg': shotImg,
      'interest': interest,
      'location': location,
      'position': position.toMap(),
      'enterCnt': enterCnt,
      'createdAt': createdAt,
    };
  }

  factory AraeModel.fromMap(Map<String, dynamic> map) {
    return AraeModel(
      chatKey: map['chatKey'] as String,
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      hostEmail: map['hostEmail'] as String,
      nickName: map['nickName'] as String,
      shotImg: map['shotImg'] as String,
      interest: map['interest'] as String,
      location: map['location'] as String,
      position: MapPosition.fromMap(map['position'] as Map<String, dynamic>),
      enterCnt: map['enterCnt'] as int,
      createdAt: map['createdAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AraeModel.fromJson(String source) =>
      AraeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
