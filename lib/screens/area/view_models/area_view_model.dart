import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/api/area/area_api_service.dart';
import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/screens/area/repos/area_repository.dart';

class AreaViewModel extends AsyncNotifier<List<AraeModel>> {
  final AreaRepository _repository = AreaRepository();

  @override
  FutureOr<List<AraeModel>> build() async {
    // TODO: implement build
    // throw UnimplementedError();
    final list = _repository.getAreas;

    if (list.isEmpty) {
      final areas = await AreaApiService.getAreaItems();

      for (var area in areas) {
        await _repository.setArea(area);
      }
    }

    return _repository.getAreas;
  }
}

final areaProvider = AsyncNotifierProvider<AreaViewModel, List<AraeModel>>(
  () => AreaViewModel(),
);
