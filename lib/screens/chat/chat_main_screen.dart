import 'package:flutter/material.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/chat/widgets/chat_room_item.dart';
import 'package:historycollection/screens/rooms/widgets/search_bar.dart';

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({super.key});

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  String _searchWords = "";
  List<ChatRoomItem> _roomItems = [];
  late ScrollController _scrollController;

  int _currentIdx = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateRoomItems();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchWords = "";
    _roomItems = [];
    _scrollController.dispose();
  }

  void _onChangeSearch(value) {
    setState(() {
      _searchWords = value;
    });
  }

  void _onTapSearch() {
    print(_searchWords);
  }

  void _generateRoomItems() {
    _roomItems = List.generate(
      20,
      (index) {
        return ChatRoomItem(
          idx: index,
        );
      },
    );
  }

  void _onTapCategory(idx) {
    _currentIdx = idx;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size5,
            horizontal: Sizes.size14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v5,
              // SearchBar(onChangeSearch: _onChangeSearch, onTapSearch: _onTapSearch),
              SearchingBar(
                onChangeSearch: _onChangeSearch,
                onTapSearch: _onTapSearch,
              ),
              Gaps.v16,
              // Expanded(
              //   child: ListView.builder(
              //     itemBuilder: (context, index) => Container(),
              //   ),
              // ),
              SizedBox(
                height: Sizes.size40,
                child: ListView.separated(
                  // clipBehavior: Clip.antiAlias,
                  // controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _onTapCategory(index);
                      },
                      child: AnimatedOpacity(
                        opacity: index == _currentIdx ? 1 : 0.5,
                        duration: const Duration(milliseconds: 600),
                        child: Chip(
                          label: const Text("칩 테스트 중"),
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                          // labelStyle: const TextStyle(
                          //   color: Colors.black,
                          //   fontSize: Sizes.size16,
                          //   fontWeight: FontWeight.w400,
                          // ),
                          shape: const StadiumBorder(
                            side: BorderSide.none,
                          ),
                          backgroundColor:
                              Theme.of(context).chipTheme.backgroundColor,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Gaps.h5,
                  itemCount: 10,
                ),
              ),
              Gaps.v10,
              // const Text(
              //   '액자 확인중',
              //   style: TextStyle(
              //     fontSize: Sizes.size32,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Gaps.v5,
              // const Text(
              //   '세부내역 액자 확인중',
              //   style: TextStyle(
              //     fontSize: Sizes.size8,
              //   ),
              // ),
              // const Chip(
              //   label: Text("칩 테스트 중"),
              //   shape: StadiumBorder(
              //     side: BorderSide(
              //       color: Color(0xFFBDBDBD),
              //     ),
              //   ),
              // ),
              _roomItems.isNotEmpty
                  ?
                  // 리스트 사이즈 작을때
                  // Expanded(
                  //     child: ListView.separated(
                  //       itemBuilder: (context, index) {
                  //         return _roomItems[index];
                  //       },
                  //       separatorBuilder: (context, index) => Gaps.v3,
                  //       itemCount: _roomItems.length,
                  //     ),
                  //   )
                  //========
                  // 양이 많을때
                  Expanded(
                      child: ListView.separated(
                        clipBehavior: Clip.antiAlias,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return ChatRoomItem(
                            idx: index,
                          );
                        },
                        separatorBuilder: (context, index) => Gaps.v5,
                        itemCount: 10,
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              Gaps.v10,
              const Chip(
                label: Text("칩 테스트 중"),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
