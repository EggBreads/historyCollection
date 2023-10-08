import 'dart:async';

import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/screens/chats/models/chat_model.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/webrtc/service/socket_io_clients.dart';
import 'package:historycollection/webrtc/service/webrtc_module.dart';

class WebrtcService with WebrtcSignal, SocketIOClients {
  static final WebrtcService _instance = WebrtcService._internal();

  factory WebrtcService() => _instance;

  WebrtcService._internal();

  @override
  Future<void> connectSocket() async {
    await super.connectSocket();
    // await _listenersocket();
  }

  @override
  void get disConnectSocket => super.disConnectSocket;

  // Future<void> _listenersocket() async {
  //   super.socketOn("join", _joinRoomCb);

  //   super.socketOn("chat", _onReceiveChat);

  //   super.socketOn("chats", _onReceiveChats);
  // }

  void socketListenFn(event, cb) {
    super.socketOn(event, cb);
  }

  // void socketEmitFn(event, data) {
  //   super.socketEmit(event, data);
  // }

  Future<void> initWebrtc() async {
    await super.connectPeer();
  }

  void createArea(AraeModel data) {
    final strData = data.toJson();
    super.socketEmit("areas", strData);
  }

  void createRoom(RoomModel data) {
    final strData = data.toJson();
    super.socketEmit("room", strData);
  }

  void joinRoom(RoomModel data) {
    final strData = data.toJson();
    super.socketEmit("join", strData);
  }

  void onSendChat(ChatModel data) {
    final strData = data.toJson();

    super.socketEmit("chats", strData);
  }

  Future<void> sendLocalOffer() async {
    await super.setLocaltOffer();

    final localOffer = super.localOffer;

    super.socketEmit("LocalOffer", localOffer);
  }
}
