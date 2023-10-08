import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/screens/chats/models/chat_model.dart';
import 'package:historycollection/screens/chats/repos/chats_repository.dart';
import 'package:historycollection/screens/home/view_models/auth_view_model.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/webrtc/providers/socket_client_provider.dart';

class ChatsViewModels extends AutoDisposeAsyncNotifier<void> {
  // late final ChatsRepository _repository;

  Future<void> sendChatMessage(RoomModel room, String message) async {
    // ChatsRepository repository = ref.read(chatProvider(room.chatKey));

    final autoProvider = ref.read(authProvider.notifier);

    final webrtcServiceRef = ref.read(webrtcServiceProvider);

    final auth = autoProvider.getUserInfo;

    if (auth == null) {
      return;
    }
    // final chatRoom = _getChatRoom(room);

    // const uuid = Uuid();

    final chat = ChatModel(
      message: message,
      senderEmail: auth.userEmail ?? "",
      createdAt: DateTime.now().millisecondsSinceEpoch,
      chatKey: room.chatKey,
    );

    // await repository.saveChatMessage(chat);

    webrtcServiceRef.onSendChat(chat);
  }

  List<ChatModel> getChats(RoomModel room) {
    final repository = ref.read(chatProvider(room.chatKey));

    return repository.getChats;
  }

  Future<void> saveChat(String chatKey, ChatModel chat) async {
    ChatsRepository repository = ref.read(chatProvider(chatKey));
    await repository.saveChatMessage(chat);
  }

  // Stream<List<ChatModel>> getChatStream(RoomModel room) async* {
  //   // for (final chat in chats) {
  //   while (true) {
  //     await Future.delayed(const Duration(seconds: 1));
  //     final chats = getChats(room);
  //     chats.sort((a, b) => b.createdAt - a.createdAt);
  //     yield chats;
  //   }
  //   // }
  // }

  // yield tempResult;

  @override
  FutureOr<void> build() async {
    // _repository = ChatsRepository(chatKey: arg);
  }
}

final chatsProvider = AutoDisposeAsyncNotifierProvider<ChatsViewModels, void>(
  () => ChatsViewModels(),
);

// final chatStreamProvider =
//     StreamProvider.autoDispose.family<List<ChatModel>, String>((ref, params) {
//   final chatRef = ref.read(chatsProvider.notifier);
//   // final channel = WebSocketChannel.connect(
//   //   // Uri.
//   //   Uri.parse('ws://192.168.200.156:3005'),
//   // );

//   return chatRef.getChatStream(RoomModel.fromJson(params));
// });
