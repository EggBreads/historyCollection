// ignore_for_file: public_member_api_docs, sort_constructors_first


// class ChatsModel {
//   String userName;
//   List<ChatRoomModel> chats;

//   ChatsModel({
//     required this.userName,
//     required this.chats,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'userName': userName,
//       'chats': chats.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory ChatsModel.fromMap(Map<String, dynamic> map) {
//     return ChatsModel(
//       userName: map['userName'] as String,
//       chats: List<ChatRoomModel>.from(
//         (map['chats'] as List<dynamic>).map<ChatRoomModel>(
//           (x) => ChatRoomModel.fromMap(x as Map<String, dynamic>),
//         ),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ChatsModel.fromJson(String source) =>
//       ChatsModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
