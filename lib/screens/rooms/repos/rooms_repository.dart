import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomRepository {
  // 임시
  static const storageKey = "SAVED_ROOMS";

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  /// API을 통해 데이터을 저장해야함
  Future<void> createRoom(RoomModel model) async {
    List<String>? strRooms = _preferences.getStringList(storageKey);

    if (strRooms == null) {
      _preferences.setStringList(
        storageKey,
        [
          model.toJson(),
        ],
      );
      return;
    }

    final list = strRooms.where(
        (strRoom) => RoomModel.fromJson(strRoom).chatKey == model.chatKey);

    if (list.isNotEmpty) {
      return;
    }

    strRooms = [
      ...strRooms,
      model.toJson(),
    ];

    await _preferences.setStringList(storageKey, strRooms);
  }

  Future<void> setRoom(RoomModel roomModel) async {
    List<String>? strRooms = _preferences.getStringList(storageKey);

    if (strRooms == null) {
      return;
    }

    final list = strRooms.map(
      (strRoom) {
        final room = RoomModel.fromJson(strRoom);
        if (room.chatKey == roomModel.chatKey) {
          return roomModel.toJson();
        }

        return room.toJson();
      },
    ).toList();

    if (list.isNotEmpty) {
      return;
    }

    await _preferences.setStringList(storageKey, list);
  }

  List<RoomModel> getRooms(String? userEmail) {
    final strRooms = _preferences.getStringList(storageKey);

    if (strRooms == null) {
      return [];
    }

    List<RoomModel> list = strRooms
        .map(
          (room) => RoomModel.fromJson(room),
        )
        .toList();

    if (userEmail != null) {
      list = list.where((room) {
        final subList =
            room.joiners.keys.where((key) => key == userEmail).toList();
        // final idx = room.joinerEmails.indexOf(userEmail);
        return subList.isNotEmpty;
      }).toList();
    }

    return list;
  }

  RoomModel? getRoom(String chatKey) {
    final strRooms = _preferences.getStringList(storageKey);

    if (strRooms == null) {
      return null;
    }

    List<RoomModel> list = strRooms
        .map(
          (room) => RoomModel.fromJson(room),
        )
        .toList();

    final room = list.singleWhere((l) => l.chatKey == chatKey);

    return room;
  }
}
