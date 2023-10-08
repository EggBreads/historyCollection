import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/screens/area/view_models/area_view_model.dart';
import 'package:historycollection/screens/chats/models/chat_model.dart';
import 'package:historycollection/screens/chats/view_models/chats_view_models.dart';
import 'package:historycollection/screens/home/view_models/auth_view_model.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/screens/rooms/view_models/rooms_view_model.dart';
import 'package:historycollection/webrtc/service/webrtc_service.dart';

final webrtcServiceProvider =
    Provider.autoDispose<WebrtcService>((ref) => WebrtcService());

final areaSteamProvider = StreamProvider.autoDispose<List<AraeModel>>(
  (ref) async* {
    WebrtcService webrtcService = WebrtcService();
    StreamController<List<AraeModel>> streamController =
        StreamController<List<AraeModel>>();

    final area = ref.read(areaProvider.notifier);

    List<AraeModel> areas = area.getAreas;

    streamController.add(areas);

    webrtcService.socketListenFn("areas", (data) {
      AraeModel newArea = AraeModel.fromJson(data);
      areas = [...areas, newArea];
      streamController.add(areas);
    });

    await for (final value in streamController.stream) {
      yield value;
    }
  },
);

final roomStreamProvider =
    StreamProvider.autoDispose<List<RoomModel>>((ref) async* {
  StreamController<List<RoomModel>> streamController =
      StreamController<List<RoomModel>>();

  WebrtcService webrtcService = WebrtcService();
  final room = ref.read(roomsProvider.notifier);
  final auth = ref.read(authProvider.notifier);

  List<RoomModel> roomList = room.getRoomList(auth.getUserInfo?.userEmail);

  streamController.add(roomList);

  webrtcService.socketListenFn("room", (data) {
    RoomModel newRoom = RoomModel.fromJson(data);
    roomList = [...roomList, newRoom];
    streamController.add(roomList);
  });

  await for (final value in streamController.stream) {
    yield value;
  }
});

final joinProvider = Provider<void>((ref) {
  final rRef = ref.read(roomsProvider.notifier);
  WebrtcService webrtcService = WebrtcService();

  webrtcService.socketListenFn("join", (data) async {
    RoomModel room = RoomModel.fromJson(data);
    await rRef.joinRoom(room);
  });
});

final chatStreamProvider = StreamProvider.autoDispose
    .family<List<ChatModel>, String>((ref, params) async* {
  StreamController<List<ChatModel>> streamController =
      StreamController<List<ChatModel>>();

  WebrtcService webrtcService = WebrtcService();
  final chat = ref.read(chatsProvider.notifier);

  RoomModel room = RoomModel.fromJson(params);

  List<ChatModel> chatList = chat.getChats(room);

  chatList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

  streamController.add(chatList);

  webrtcService.socketListenFn("chat", (data) {
    ChatModel newChat = ChatModel.fromJson(data);
    chatList = [...chatList, newChat];
    chat.saveChat(room.chatKey, newChat);
    streamController.add(chatList);
  });

  await for (final value in streamController.stream) {
    yield value;
  }
});
