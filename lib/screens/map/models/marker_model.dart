// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:historycollection/screens/map/models/map_position_model.dart';

class MarkerModel {
  String markerId;
  MapPosition mapPosition;
  String title;
  String winIcon;
  String snippet;
  String evtLoactionInfo;

  MarkerModel({
    required this.markerId,
    required this.mapPosition,
    required this.title,
    required this.winIcon,
    required this.snippet,
    required this.evtLoactionInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'markerId': markerId,
      'mapPosition': mapPosition.toMap(),
      'title': title,
      'winIcon': winIcon,
      'snippet': snippet,
      'evtLoactionInfo': evtLoactionInfo,
    };
  }

  factory MarkerModel.fromMap(Map<String, dynamic> map) {
    return MarkerModel(
      markerId: map['markerId'] as String,
      mapPosition:
          MapPosition.fromMap(map['mapPosition'] as Map<String, dynamic>),
      title: map['title'] as String,
      winIcon: map['winIcon'] as String,
      snippet: map['snippet'] as String,
      evtLoactionInfo: map['evtLoactionInfo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MarkerModel.fromJson(String source) =>
      MarkerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
