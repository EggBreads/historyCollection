// ignore_for_file: public_member_api_docs, sort_constructors_first


// class ChatRoomModel {
//   String roomKey;
//   String title;
//   List<ChatModel> chat;

//   ChatRoomModel({
//     required this.roomKey,
//     required this.title,
//     required this.chat,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'roomKey': roomKey,
//       'title': title,
//       'chat': chat.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
//     return ChatRoomModel(
//       roomKey: map['roomKey'] as String,
//       title: map['title'] as String,
//       chat: List<ChatModel>.from(
//         (map['chat'] as List<dynamic>).map<ChatModel>(
//           (x) => ChatModel.fromMap(x as Map<String, dynamic>),
//         ),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ChatRoomModel.fromJson(String source) =>
//       ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
