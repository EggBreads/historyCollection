import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
  }

  SharedPreferences get getSharedPrefs => _sharedPrefs;
  // String get username => _sharedPrefs.getString(keyUsername) ?? "";

  // set username(String value) {
  //   _sharedPrefs.setString(keyUsername, value);
  // }
}
