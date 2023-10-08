import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SocketChatModel {
  String userName;
  String message;
  List<String> roomIds;

  SocketChatModel({
    required this.userName,
    required this.message,
    required this.roomIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'message': message,
      'roomIds': roomIds,
    };
  }

  factory SocketChatModel.fromMap(Map<String, dynamic> map) {
    return SocketChatModel(
      userName: map['userName'] as String,
      message: map['message'] as String,
      roomIds: List<String>.from(
        (map['roomIds'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketChatModel.fromJson(String source) =>
      SocketChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
