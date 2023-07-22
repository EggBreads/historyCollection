import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/api/chats/chat_api_service.dart';
import 'package:historycollection/screens/chats/models/chats_model.dart';
import 'package:historycollection/screens/chats/models/chats_room_model.dart';
import 'package:historycollection/screens/chats/repos/chats_repository.dart';

class ChatsViewModels extends AutoDisposeAsyncNotifier<List<ChatsRoomModel>> {
  final ChatsRepository _repository = ChatsRepository();

  Future<void> setRoomOnUser(ChatsRoomModel chatRoom) async {
    // state = const AsyncLoading();

    await _repository.setRoomOnUser(chatRoom);

    // state = AsyncData(value)
  }

  @override
  FutureOr<List<ChatsRoomModel>> build() async {
    // TODO: implement build
    // List<ChatsModel> chats = await ChatsApiService.getChatsItems();
    // String nickName = await _repository.getNickName;

    // return chats
    //     .where(
    //       (chat) => chat.userName == nickName,
    //     )
    //     .map((rooms) => rooms.chats)
    //     .single;
    final list = _repository.getChatsRoomList;
    return _repository.getChatsRoomList;
    // throw UnimplementedError();
  }
}

final chatsProvider =
    AutoDisposeAsyncNotifierProvider<ChatsViewModels, List<ChatsRoomModel>>(
  () => ChatsViewModels(),
);

final roomsProvider = FutureProvider.autoDispose.family<void, String>(
  (ref, nickName) async {
    List<ChatsModel> chats = await ChatsApiService.getChatsItems(nickName);

    final chatNotifier = ref.read(chatsProvider.notifier);

    List<ChatsRoomModel> result = chats
        .map(
          (rooms) => rooms.chats,
        )
        .single;

    for (var item in result) {
      chatNotifier.setRoomOnUser(item);
    }

    // return result;
  },
);
