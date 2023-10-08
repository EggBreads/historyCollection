import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/screens/rooms/widgets/room_chat_info.dart';
import 'package:historycollection/webrtc/providers/socket_client_provider.dart';

class RoomsScreen extends ConsumerStatefulWidget {
  const RoomsScreen({super.key});

  @override
  RommsScreenState createState() => RommsScreenState();
}

class RommsScreenState extends ConsumerState<RoomsScreen> {
  // List<Widget> searchWidgets = [];
  // String _searchWords = '';
  @override
  void initState() {
    super.initState();
    // _keyDownSearch();
  }

  @override
  void dispose() {
    super.dispose();
    // searchWidgets.clear();
    // _searchWords = "";
  }

  // void _createRoomTap() async {
  //   final roomsRef = ref.read(roomsProvider.notifier);

  //   await roomsRef.createRoom(
  //     RoomModel(
  //       chatKey: "test1",
  //       title: "테스트룸",
  //       subTitle: "테스트룸 서브타이틀",
  //       userName: "mds1262@naver.com",
  //       maxCnt: 3,
  //       joiners: ["mds1262@naver.com"],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Center(
            child: Text("채팅방전체목록"),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: _createRoomTap,
          //     icon: const FaIcon(
          //       FontAwesomeIcons.plus,
          //     ),
          //   ),
          // ],
        ),
        body: ref.watch(roomStreamProvider).whenOrNull(
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (error, stackTrace) => Center(
                child: Text("Could not load videos: $error"),
              ),
              data: (data) {
                return SafeArea(
                  child: data.isEmpty
                      ? const Center(
                          child: Text("근처에 참여할 모임이 없어요......"),
                        )
                      : SingleChildScrollView(
                          child: ListView.separated(
                            // itemExtent: ,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => Gaps.v10,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return RoomChatInfo(
                                room: data[index],
                              );
                            },
                          ),
                        ),
                );
              },
            ));
  }
}
