import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/api/interests/interests_api_service.dart';
import 'package:historycollection/screens/interests/models/interests_model.dart';
import 'package:historycollection/screens/interests/repos/interests_repository.dart';

class InterestViewModel extends AutoDisposeAsyncNotifier<List<InterestModel>> {
  final InterestSRepository _repository = InterestSRepository();

  Future<void> setInterests(InterestModel interest) async {
    state = const AsyncLoading();

    await _repository.setIntersts(interest);

    state = AsyncData(
      _repository.getInterests,
    );
  }

  Future<List<InterestModel>> getInerests() async {
    final result = _repository.getInterests;

    if (result.isEmpty) {
      final list = await InterestsApiService.getInterestsApi();

      for (var item in list) {
        await _repository.setIntersts(item);
      }
    }

    return _repository.getInterests;
  }

  Future<void> setMyInterest(InterestModel interest) async {
    state = const AsyncLoading();

    await _repository.setMyInterst(interest);

    // state = AsyncData(
    //   _repository.getMyInterests,
    // );
  }

  Future<void> removeMyInterest() async {
    await _repository.removeMyInterst();
  }

  Future<List<InterestModel>> getMyInterest() async {
    final result = _repository.getMyInterests;

    if (result.isEmpty) {
      final list = await InterestsApiService.getMyInterestsApi();

      for (var item in list) {
        await _repository.setMyInterst(item);
      }
    }

    return _repository.getMyInterests;
  }

  @override
  FutureOr<List<InterestModel>> build() async {
    // throw UnimplementedError();
    final result = _repository.getInterests;

    if (result.isEmpty) {
      final list = await InterestsApiService.getInterestsApi();

      for (var item in list) {
        await _repository.setIntersts(item);
      }
    }

    return _repository.getInterests;
  }
}

final interestsProvider =
    AutoDisposeAsyncNotifierProvider<InterestViewModel, List<InterestModel>>(
  () => InterestViewModel(),
);

final myInterestsProvider =
    FutureProvider.autoDispose<List<InterestModel>>((ref) async {
  // final list = await ref.read(interestsProvider.notifier).getMyInterest();
  // ref.state = AsyncData(list);

  final list = await InterestsApiService.getMyInterestsApi();
  return list;
});
