import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AreaPosition {
  final double lat;
  final double lng;

  AreaPosition({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory AreaPosition.fromMap(Map<String, dynamic> map) {
    return AreaPosition(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaPosition.fromJson(String source) =>
      AreaPosition.fromMap(json.decode(source) as Map<String, dynamic>);
}
