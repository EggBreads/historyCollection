import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/chats/view_models/chats_view_models.dart';
import 'package:historycollection/screens/home/view_models/auth_view_model.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';
import 'package:historycollection/webrtc/providers/socket_client_provider.dart';

class ChatsScreens extends ConsumerStatefulWidget {
  final String roomJson;

  const ChatsScreens({
    super.key,
    required this.roomJson,
  });

  @override
  ConsumerState<ChatsScreens> createState() => ChatsScreensState();
}

class ChatsScreensState extends ConsumerState<ChatsScreens> {
  late TextEditingController _textEditingController;
  late RoomModel room;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: "");
    room = RoomModel.fromJson(widget.roomJson);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _sendChatMessage() async {
    if (_textEditingController.text.isNotEmpty) {
      final chatProvider = ref.read(chatsProvider.notifier);

      await chatProvider.sendChatMessage(
        room,
        _textEditingController.text,
      );

      _textEditingController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final rRef = ref.watch(roomsProvider('닉네임1'));
    final chatRef = ref.watch(
      chatStreamProvider(
        widget.roomJson,
      ),
    );

    final autoProvider = ref.read(authProvider.notifier);

    final auth = autoProvider.getUserInfo;
    // AsyncValue<List<ChatsRoomModel>> cRef;
    // if (!rRef.isLoading) {
    // final cRef = ref.watch(chatsProvider);
    // }
    return Scaffold(
      appBar: AppBar(
          // title: Text(room.title),
          ),
      body: Stack(
        children: [
          chatRef.when(
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            error: (error, stackTrace) => Center(
              child: Text("Could not load chat: $error"),
            ),
            data: (data) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
                    ),
                  ),
                ),
                // width: width,
                child: ListView.separated(
                  reverse: true,
                  padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom:
                          MediaQuery.of(context).padding.bottom + Sizes.size60),
                  itemBuilder: (context, index) {
                    final chatItem = data[index];

                    return BubbleSpecialThree(
                      text: chatItem.message,
                      color: const Color(0xFFE8E8EE),
                      tail: true,
                      isSender: chatItem.senderEmail == auth!.userEmail,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.v5;
                  },
                  itemCount: data.length,
                ),
              );
            },
          ),
          Positioned(
            bottom: Sizes.size1,
            width: width,
            // left: Sizes.size5,
            child: TextField(
              // cursorHeight: Sizes.size24,
              controller: _textEditingController,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
              // textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                // hintText: "Search",
                // hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                // enabledBorder: const OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.black54,
                //     width: 2.0,
                //   ),
                // ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    Theme.of(context).inputDecorationTheme.contentPadding,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.size14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // if (_isWriting)
                      GestureDetector(
                        onTap: _sendChatMessage,
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
      ),
      // future: ,
    );
  }
}
