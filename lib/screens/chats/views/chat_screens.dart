import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/chats/view_models/chats_view_models.dart';

class ChatsScreens extends ConsumerStatefulWidget {
  final String chatKey;

  const ChatsScreens({
    super.key,
    required this.chatKey,
  });

  @override
  ConsumerState<ChatsScreens> createState() => ChatsScreensState();
}

class ChatsScreensState extends ConsumerState<ChatsScreens> {
  // final int _chatsSize = 0;
  // late Future<List<ChatModel>> _chats;

  // final String _searchWords = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initChats();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _initChats() async {
    // _chats = ChatsApiService.getChatsItems();
  }

  // void _onChangeSearch(value) {
  //   setState(() {
  //     _searchWords = value;
  //   });
  // }

  // void _onTapSearch() {
  //   print(_searchWords);
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final rRef = ref.watch(roomsProvider('닉네임1'));

    // AsyncValue<List<ChatsRoomModel>> cRef;
    // if (!rRef.isLoading) {
    // final cRef = ref.watch(chatsProvider);
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text("참여제목방명"),
      ),
      body: Container(
        child: rRef.isLoading
            ? const CircularProgressIndicator.adaptive()
            : rRef.hasError
                ? Text(
                    "Could not load videos: ${rRef.error}",
                  )
                : ref.watch(chatsProvider).whenOrNull(
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      },
                      error: (error, stackTrace) => Center(
                        child: Text("Could not load videos: $error"),
                      ),
                      data: (data) {
                        final chats = data.singleWhere(
                            (item) => item.roomKey == 'uuuu_dddd_1111');
                        return Stack(
                          children: [
                            Positioned(
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
                                    ),
                                  ),
                                ),
                                width: width,
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size20,
                                    horizontal: Sizes.size5,
                                  ),
                                  itemBuilder: (context, index) {
                                    final chatItem = chats.chat[index];
                                    return BubbleSpecialThree(
                                      text: chatItem.contents.text,
                                      color: const Color(0xFFE8E8EE),
                                      tail: true,
                                      isSender: chatItem.contents.isSender,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Gaps.v5;
                                  },
                                  itemCount: chats.chat.length,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: Sizes.size1,
                              width: width,
                              // left: Sizes.size5,
                              child: TextField(
                                // cursorHeight: Sizes.size24,
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: Sizes.size16,
                                  color: Colors.black54,
                                ),
                                // textInputAction: TextInputAction.send,
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle,
                                  // enabledBorder: const OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: Colors.black54,
                                  //     width: 2.0,
                                  //   ),
                                  // ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: Theme.of(context)
                                      .inputDecorationTheme
                                      .contentPadding,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                      left: Sizes.size14,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.solidSquarePlus,
                                          color: Colors.black45,
                                          size: Sizes.size24,
                                        ),
                                      ],
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      right: Sizes.size14,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // if (_isWriting)
                                        GestureDetector(
                                          // onTap: _onStopWrite,
                                          child: const FaIcon(
                                            FontAwesomeIcons.circleArrowRight,
                                            color: Colors.grey,
                                            size: Sizes.size24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
      ),
      // future: ,
    );
  }
}
