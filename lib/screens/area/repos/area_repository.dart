import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AreaRepository {
  static const areasKey = "SAVED_AREAS";

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  Future<void> setArea(AraeModel model) async {
    List<String>? list = _preferences.getStringList(areasKey);

    if (list == null || list.isEmpty) {
      await _preferences.setStringList(
        areasKey,
        [
          model.toJson(),
        ],
      );
      return;
    }

    await _preferences.setStringList(
      areasKey,
      [
        ...list,
        model.toJson(),
      ],
    );
  }

  List<AraeModel> get getAreas {
    List<String>? list = _preferences.getStringList(areasKey);

    if (list == null || list.isEmpty) {
      return [];
    }

    final result = list.map((item) => AraeModel.fromJson(item)).toList();

    return result;
  }
}
