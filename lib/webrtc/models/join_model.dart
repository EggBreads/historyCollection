import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JoinModel {
  String roomId;
  String userName;

  JoinModel({
    required this.roomId,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'userName': userName,
    };
  }

  factory JoinModel.fromMap(Map<String, dynamic> map) {
    return JoinModel(
      roomId: map['roomId'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JoinModel.fromJson(String source) =>
      JoinModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
