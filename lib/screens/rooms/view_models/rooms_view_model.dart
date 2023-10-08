import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/screens/rooms/repos/rooms_repository.dart';

class RoomsViewModel extends AutoDisposeAsyncNotifier<void> {
  late final RoomRepository _repository;

  // API 대신 사용중
  // final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;
  // static const storageKey = "SAVED_ROOMS";

  Future<void> createRoom(RoomModel model) async {
    state = const AsyncValue.loading();

    AsyncValue.guard(() async {
      await _repository.createRoom(model);
    });
  }

  List<RoomModel> getRoomList(String? email) {
    // final auth = ref.read(authProvider.notifier);
    return _repository.getRooms(email);
  }

  Future<RoomModel?> getRoom(String chatKey) async {
    return _repository.getRoom(chatKey);
  }

  Future<void> joinRoom(RoomModel room) async {
    await _repository.setRoom(room);
  }

  // Stream<List<RoomModel>> getRoomsStream() async* {
  //   while (true) {
  //     await Future.delayed(const Duration(seconds: 1));

  //     yield getRoomList();
  //   }
  // }

  @override
  FutureOr<void> build() async {
    _repository = RoomRepository();

    // return getRoomList();
  }
}

final roomsProvider = AsyncNotifierProvider.autoDispose<RoomsViewModel, void>(
  () {
    return RoomsViewModel();
  },
);

final roomsFormProvider = StateProvider<Map<String, dynamic>>((ref) => {});

// final roomsStreamProvider = StreamProvider.autoDispose<List<RoomModel>>(
//   (ref) {
//     // final chatRef = ref.read(roomsProvider.notifier);

//     return joinStreamProvider;
//   },
// );
