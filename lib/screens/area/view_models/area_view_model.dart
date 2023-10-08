import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/screens/area/repos/area_repository.dart';
import 'package:historycollection/screens/home/view_models/auth_view_model.dart';
import 'package:historycollection/screens/login/models/user_model.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/screens/rooms/view_models/rooms_view_model.dart';
import 'package:historycollection/webrtc/providers/socket_client_provider.dart';
import 'package:uuid/uuid.dart';

class AreaViewModel extends AsyncNotifier<List<AraeModel>> {
  final AreaRepository _repository = AreaRepository();

  Future<void> createArea(AraeModel area) async {
    state = const AsyncValue.loading();

    await _repository.setArea(area);
    final webrtcServiceRef = ref.read(webrtcServiceProvider);

    webrtcServiceRef.createArea(area);

    state = AsyncData(_repository.getAreas);
  }

  Future<String> createAreaRoom() async {
    final roomRef = ref.read(roomsProvider.notifier);
    final webrtcServiceRef = ref.read(webrtcServiceProvider);

    UserModel userInfo = ref.read(authProvider.notifier).getUserInfo!;

    const uuid = Uuid();

    final chatKey = uuid.v4();
    // roomState['chatKey'] = chatKey;

    // final userName = userInfo.userName!;

    final form = {
      'chatKey': chatKey,
      // 'userName': userName,
      'joiners': {
        "${userInfo.userEmail}": "${userInfo.userName}",
      },
      // ...roomState,
    };

    final strRoom = RoomModel.fromMap(form);

    await roomRef.createRoom(strRoom);

    webrtcServiceRef.createRoom(strRoom);

    return chatKey;
  }

  List<AraeModel> get getAreas {
    final list = _repository.getAreas;

    if (list.isEmpty) {
      // final areas = await AreaApiService.getAreaItems();

      // for (var area in areas) {
      //   await _repository.setArea(area);
      // }
      return [];
    }
    return list;
  }

  Future<void> onRefresh() async {
    state = AsyncValue.data(getAreas);
  }

  @override
  FutureOr<List<AraeModel>> build() async {
    // throw UnimplementedError();

    return getAreas;
  }
}

final areaFormProvider = StateProvider<Map<String, dynamic>>((ref) {
  // UserModel userInfo = ref.read(authProvider.notifier).getUserInfo!;
  Map<String, dynamic> map = {};

  return map;

  // final mapRef = ref.read(mapProvider.notifier);

  // MapPosition mapPosition = mapRef.getThisPosition;

  // String address = "경기도 남양주시";
  // try {
  //   address = await mapRef.getAddress(mapPosition.lat, mapPosition.lng);
  // } catch (e) {
  //   if (kDebugMode) {
  //     print(e);
  //   }
  // }
  // return AraeModel(
  //   chatKey: '',
  //   title: '',
  //   subTitle: '',
  //   hostEmail: userInfo.userEmail ?? '',
  //   shotImg: '',
  //   nickName: userInfo.userName!,
  //   interest: interest,
  //   enterCnt: 0,
  //   location: address,
  //   position: AreaPosition(
  //     lat: mapPosition.lat,
  //     lng: mapPosition.lng,
  //   ),
  //   createdAt: 0,
  // );
});

final areaProvider = AsyncNotifierProvider<AreaViewModel, List<AraeModel>>(
  () => AreaViewModel(),
);
