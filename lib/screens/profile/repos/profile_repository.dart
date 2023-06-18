import 'package:historycollection/screens/profile/models/profile_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  // 임시
  static const storageKey = "SAVED_PROFILES";

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  void setProfile(ProfileModel model) {
    _preferences.setString(
      storageKey,
      model.toJson(),
    );
  }

  ProfileModel get getProfile {
    String strProfile = _preferences.getString(storageKey)!;
    return ProfileModel.fromJson(strProfile);
  }
}
