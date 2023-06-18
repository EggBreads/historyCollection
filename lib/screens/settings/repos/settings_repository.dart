import 'package:historycollection/screens/settings/models/settigs_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const storageKey = "SAVED_SETTINGS";

  // Local Storate사용
  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  // SettingsRepository(
  //   this._preferences,
  // );

  Future<void> setSettings(SettingsModel model) async {
    _preferences.setString(
      storageKey,
      model.toJson(),
    );
  }

  SettingsModel get getSettings {
    final strJson = _preferences.getString(storageKey) ??
        SettingsModel(notification: false).toJson();

    return SettingsModel.fromJson(strJson);
  }
}
