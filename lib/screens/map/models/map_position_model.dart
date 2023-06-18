import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MapPosition {
  double lat;
  double lng;

  MapPosition({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory MapPosition.fromMap(Map<String, dynamic> map) {
    return MapPosition(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory MapPosition.fromJson(String source) =>
      MapPosition.fromMap(json.decode(source) as Map<String, dynamic>);
}
