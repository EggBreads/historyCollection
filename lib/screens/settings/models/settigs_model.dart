import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingsModel {
  bool notification;

  SettingsModel({
    required this.notification,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notification': notification,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      notification: map['notification'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) =>
      SettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
