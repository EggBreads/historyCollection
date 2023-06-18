import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/api/rooms/rooms_api_service.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/screens/rooms/repos/rooms_repository.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomsViewModel extends AsyncNotifier<List<RoomModel>> {
  final RoomRepository _repository = RoomRepository();

  // API 대신 사용중
  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;
  // static const storageKey = "SAVED_ROOMS";

  Future<bool> createRoom(RoomModel model) async {
    state = const AsyncValue.loading();

    List<String>? strRooms = _preferences.getStringList(
      RoomRepository.storageKey,
    );
    if (strRooms == null) {
      strRooms = [];
      strRooms.add(model.toJson());
      return true;
    }

    int sizes = strRooms
        .where((room) {
          RoomModel saveRoom = RoomModel.fromJson(room);
          return saveRoom.chatKey == model.chatKey;
        })
        .map(
          (room) => RoomModel.fromJson(room),
        )
        .toList()
        .length;

    if (sizes > 0) {
      return false;
    }

    _repository.setRoom(model);

    state = AsyncValue.data(_repository.getRooms);

    return true;
  }

  @override
  FutureOr<List<RoomModel>> build() async {
    // TODO: implement build
    // throw UnimplementedError();
    // RoomsApiService

    // state = const AsyncValue.loading();

    List<RoomModel> list = [];

    final strRooms = _preferences.getStringList(
      RoomRepository.storageKey,
    );

    if (strRooms == null) {
      list = await RoomsApiService.getAreaItems();
      return list;
    }

    list = _repository.getRooms;

    return list;
  }
}

final roomsProvider = AsyncNotifierProvider<RoomsViewModel, List<RoomModel>>(
  () {
    return RoomsViewModel();
  },
);
