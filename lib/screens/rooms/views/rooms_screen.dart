import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/rooms/view_models/rooms_view_model.dart';
import 'package:historycollection/screens/rooms/widgets/room_chat_info.dart';

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
    // TODO: implement initState
    super.initState();
    // _keyDownSearch();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // searchWidgets.clear();
    // _searchWords = "";
  }

  // void _keyDownSearch() {
  //   setState(
  //     () {
  //       searchWidgets = List.generate(
  //         5,
  //         (index) {
  //           // return const SearchList();
  //           return const RoomChatInfo();
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Center(
            child: Text("Rooms"),
          ),
        ),
        body: ref.watch(roomsProvider).whenOrNull(
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (error, stackTrace) => Center(
                child: Text("Could not load videos: $error"),
              ),
              data: (data) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size20,
                        horizontal: Sizes.size10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SearchingBar(
                          //   onChangeSearch: _onChangeSearch,
                          //   onTapSearch: _onTapSearch,
                          // ),
                          ...data.map(
                            (room) => RoomChatInfo(room: room),
                          ),
                          // ),
                          // SearchList(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ));
  }
}
