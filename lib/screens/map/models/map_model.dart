// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:historycollection/screens/map/models/map_position_model.dart';
import 'package:historycollection/screens/map/models/marker_model.dart';

class MapModel {
  List<MarkerModel> markerModel;
  MapPosition mapPosition;

  MapModel({
    required this.markerModel,
    required this.mapPosition,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'markerModel': markerModel.map((x) => x.toMap()).toList(),
      'mapPosition': mapPosition.toMap(),
    };
  }

  factory MapModel.fromMap(Map<String, dynamic> map) {
    return MapModel(
      markerModel: List<MarkerModel>.from(
        (map['markerModel'] as List<int>).map<MarkerModel>(
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
