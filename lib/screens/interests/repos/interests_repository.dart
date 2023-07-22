import 'package:historycollection/screens/interests/models/interests_model.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestSRepository {
  static const interestsKey = "SAVED_INTERESTS";
  static const myInterestKey = "SAVED_INTEREST";

  final SharedPreferences _preferences = SharedPrefs().getSharedPrefs;

  Future<void> setIntersts(InterestModel interest) async {
    List<String>? interests = _preferences.getStringList(interestsKey);

    if (interests == null || interests.isEmpty) {
      await _preferences.setStringList(
        interestsKey,
        [
          interest.toJson(),
        ],
      );
      return;
    }

    await _preferences.setStringList(
      interestsKey,
      [
        ...interests,
        interest.toJson(),
      ],
    );
  }

  List<InterestModel> get getInterests {
    List<String>? interests = _preferences.getStringList(interestsKey);

    if (interests == null || interests.isEmpty) {
      return [];
    }

    return interests.map(
      (interest) {
        return InterestModel.fromJson(interest);
      },
    ).toList();
  }

  Future<void> setMyInterst(InterestModel interest) async {
    List<String>? interests = _preferences.getStringList(myInterestKey);

    if (interests == null || interests.isEmpty) {
      await _preferences.setStringList(
        myInterestKey,
        [
          interest.toJson(),
        ],
      );
      return;
    }

    await _preferences.setStringList(
      myInterestKey,
      [
        ...interests,
        interest.toJson(),
      ],
    );
  }

  Future<void> removeMyInterst() async {
    await _preferences.remove(myInterestKey);
  }

  List<InterestModel> get getMyInterests {
    List<String>? interests = _preferences.getStringList(myInterestKey);

    if (interests == null || interests.isEmpty) {
      return [];
    }

    return interests.map(
      (interest) {
        return InterestModel.fromJson(interest);
      },
    ).toList();
  }
}
