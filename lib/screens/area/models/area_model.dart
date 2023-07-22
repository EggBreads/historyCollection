// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:historycollection/screens/area/models/area_position_model.dart';

class AraeModel {
  final String shotImg;
  final String nickName;
  final String interest;
  final int enterCnt;
  final String location;
  final AreaPosition position;

  AraeModel({
    required this.shotImg,
    required this.nickName,
    required this.interest,
    required this.enterCnt,
    required this.location,
    required this.position,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shotImg': shotImg,
      'nickName': nickName,
      'interest': interest,
      'enterCnt': enterCnt,
      'location': location,
      'position': position.toMap(),
    };
  }

  factory AraeModel.fromMap(Map<String, dynamic> map) {
    return AraeModel(
      shotImg: map['shotImg'] as String,
      nickName: map['nickName'] as String,
      interest: map['interest'] as String,
      enterCnt: map['enterCnt'] as int,
      location: map['location'] as String,
      position: AreaPosition.fromMap(map['position'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AraeModel.fromJson(String source) =>
      AraeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
