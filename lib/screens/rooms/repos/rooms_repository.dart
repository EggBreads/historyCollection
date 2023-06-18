import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomRepository {
  // 임시
  static const storageKey = "SAVED_ROOMS";

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  /// API을 통해 데이터을 저장해야함
  Future<void> setRoom(RoomModel model) async {
    List<String> strRooms = _preferences.getStringList(storageKey)!;

    List<RoomModel> savedRooms = strRooms
        .map(
          (room) => RoomModel.fromJson(room),
        )
        .toList();

    strRooms = savedRooms
        .map(
          (room) => room.toJson(),
        )
        .toList();

    strRooms = [
      ...strRooms,
      model.toJson(),
    ];

    _preferences.setStringList(storageKey, strRooms);
  }

  List<RoomModel> get getRooms {
    final strRooms = _preferences.getStringList(storageKey)!;

    List<RoomModel> list = strRooms
        .map(
          (room) => RoomModel.fromJson(room),
        )
        .toList();

    return list;
  }
}
