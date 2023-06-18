// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatModel {
  final String uuid;
  final String roomKey;
  final bool isInvited;
  final bool isSender;
  final bool isReciver;
  final ChatContentModel contents;

  ChatModel({
    required this.uuid,
    required this.roomKey,
    required this.isInvited,
    required this.isSender,
    required this.isReciver,
    required this.contents,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'roomKey': roomKey,
      'isInvited': isInvited,
      'isSender': isSender,
      'isReciver': isReciver,
      'contents': contents.toMap(),
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> map) {
    return ChatModel(
      uuid: map['uuid'] as String,
      roomKey: map['roomKey'] as String,
      isInvited: map['isInvited'] as bool,
      isSender: map['isSender'] as bool,
      isReciver: map['isReciver'] as bool,
      contents: ChatContentModel.fromJson(
        map['contents'],
      ),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory ChatModel.fromJson(String source) =>
  //     ChatModel.fromMap(json.decode(source));
}

class ChatContentModel {
  final String text;

  ChatContentModel({
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory ChatContentModel.fromJson(Map<String, dynamic> map) {
    return ChatContentModel(
      text: map['text'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory ChatContentModel.fromJson(String source) =>
  //     ChatContentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
