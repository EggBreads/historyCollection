import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/api/chats/chat_api_service.dart';
import 'package:historycollection/models/chats/chats_model.dart';

class ChatsScreens extends StatefulWidget {
  final String chatKey;

  const ChatsScreens({
    super.key,
    required this.chatKey,
  });

  @override
  State<ChatsScreens> createState() => _ChatsScreensState();
}

class _ChatsScreensState extends State<ChatsScreens> {
  // final int _chatsSize = 0;
  late Future<List<ChatModel>> _chats;

  String _searchWords = "";

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
    _chats = ChatsApiService.getChatsItems();
    print("test => ${widget.chatKey}");
  }

  void _onChangeSearch(value) {
    setState(() {
      _searchWords = value;
    });
  }

  void _onTapSearch() {
    print(_searchWords);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("참여제목방명"),
      ),
      body: FutureBuilder(
        future: _chats,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            print("test ${snapshot.error}");
            return const Center(
              child: FaIcon(
                FontAwesomeIcons.bugs,
              ),
            );
          }
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
                        final chatItem = snapshot.data![index];
                        return BubbleSpecialThree(
                          text: chatItem.contents.text,
                          color: const Color(0xFFE8E8EE),
                          tail: true,
                          isSender: chatItem.isSender,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.v5;
                      },
                      itemCount: snapshot.data!.length),
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
                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
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
        // future: ,
      ),
    );
  }
}
