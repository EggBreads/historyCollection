import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/screens/profile/models/profile_model.dart';
import 'package:historycollection/screens/profile/repos/profile_repository.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends Notifier<ProfileModel> {
  final ProfileRepository _repository = ProfileRepository();

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  @override
  ProfileModel build() {
    // TODO: implement build
    // throw UnimplementedError();
    final strProfile = _preferences.getString(ProfileRepository.storageKey);
    if (strProfile == null) {
      ProfileModel profile = ProfileModel(
        nickName: "테스트1",
        email: "mds1262@gmail.com",
        age: 20,
      );

      _preferences.setString(
        ProfileRepository.storageKey,
        profile.toJson(),
      );
    }
    return _repository.getProfile;
  }
}

final profileProvider = NotifierProvider<ProfileViewModel, ProfileModel>(
  () {
    return ProfileViewModel();
  },
);
