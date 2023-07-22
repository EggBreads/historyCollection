// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:historycollection/screens/map/models/map_position_model.dart';
import 'package:historycollection/screens/map/models/marker_model.dart';

class MapModel {
  List<MarkerModel> markerList;
  MapPosition mapPosition;

  MapModel({
    required this.markerList,
    required this.mapPosition,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'markerList': markerList.map((x) => x.toMap()).toList(),
      'mapPosition': mapPosition.toMap(),
    };
  }

  factory MapModel.fromMap(Map<String, dynamic> map) {
    return MapModel(
      markerList: List<MarkerModel>.from(
        (map['markerList'] as List<dynamic>).map<MarkerModel>(
          (x) => MarkerModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      mapPosition:
          MapPosition.fromMap(map['mapPosition'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MapModel.fromJson(String source) =>
      MapModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
