import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOClients {
  // final String socketIP = "192.168.200.107";

  late IO.Socket _socket;

  final String _socketUri = "http://192.168.200.192:3002";

  final Map<String, dynamic> _ops = {
    'transports': ['websocket'],
  };

  @protected
  Future<void> connectSocket() async {
    _socket = IO.io(
      _socketUri,
      _ops,
    );

    _socket = _socket.connect();
  }

  @protected
  void socketOn(String event, Function cb) {
    _socket.on(event, (data) => cb(data));
  }

  @protected
  void socketEmit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  @protected
  void get disConnectSocket => _socket.disconnect();

  bool get isSocketConnected => _socket.connected;
}
