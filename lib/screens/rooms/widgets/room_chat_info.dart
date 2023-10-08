import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:historycollection/Constants/router_constraint.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/chats/view_models/chats_view_models.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';

class RoomChatInfo extends ConsumerStatefulWidget {
  final RoomModel room;

  const RoomChatInfo({
    super.key,
    required this.room,
  });

  @override
  ConsumerState<RoomChatInfo> createState() => RoomChatInfoState();
}

class RoomChatInfoState extends ConsumerState<RoomChatInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _pushChat(RoomModel room) {
    context.pushNamed(
      RouterPathAndNameConstraint.chatsRouteNAME,
      pathParameters: {
        "roomJson": room.toJson(),
      },
    );
  }

  List<String> list = [
    "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
    // "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
    "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
    "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
  ];

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    final chats = ref.watch(chatsProvider.notifier).getChats(widget.room);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
        image: DecorationImage(
          image: NetworkImage(
            "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: GestureDetector(
        onTap: () => _pushChat(widget.room),
        child: Card(
          shadowColor: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: ListTile(
            // minLeadingWidth: Sizes.size56,
            // visualDensity: const VisualDensity(
            //   vertical: Sizes.size4,
            // ),

            horizontalTitleGap: Sizes.size10,
            // leadingAndTrailingTextStyle: const TextStyle(
            //     // fontSize: Sizes.size12,

            //     ),
            // minVerticalPadding: Sizes.size10,
            // // contentPadding: const EdgeInsets.symmetric(
            // //   horizontal: Sizes.size10,
            // // ),
            // leadingAndTrailingTextStyle: TextField.materialMisspelledTextStyle,
            leading: Container(
              width: Sizes.size64,
              // height: Sizes.size80,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                //     image: DecorationImage(
                //   image: NetworkImage(
                //     "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
                //   ),
                // )
                // color: Colors.red.shade300,
              ),
              child: makeAvatars(list),
            ),

            title: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final joiners = widget.room.joiners.values.join(',');

                if (chats.isEmpty) {
                  return roomChatBox(
                    width,
                    joiners,
                    '',
                  );
                }

                final lastMessage = chats[chats.length - 1].message;
                return roomChatBox(
                  width,
                  joiners,
                  lastMessage,
                );
              },
            ),
            trailing: LayoutBuilder(
              builder: (context, constraints) {
                if (chats.isEmpty) {
                  return roomTail('', '0');
                }
                final chat = chats[chats.length - 1];
                final date =
                    (DateTime.fromMicrosecondsSinceEpoch(chat.createdAt).day)
                        .toString();
                // final lastTime = DateFormat('yyyy-MM-dd – kk:mm').format();
                final cnt = (0).toString();
                return roomTail(date, cnt);
              },
            ),
          ),
        ),
      ),
    );
  }

  Column roomTail(String date, String cnt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          date,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Badge.count(
          count: 0,
        ),
        // RichText(
        //   maxLines: 4,
        //   text: TextSpan(
        //       text: cnt,
        //       style: const TextStyle(
        //         color: Colors.white,
        //       )),
        // ),
      ],
    );
  }

  Row roomChatBox(double width, String joiners, String lastMessage) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: joiners,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: lastMessage,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // FadeInImage.assetNetwork(
        //   width: width / 2,
        //   height: width / 4,
        //   // imageScale: 0.5,
        //   fit: BoxFit.fill,
        //   placeholder: "assets/images/waterfall.jpeg",
        //   image:
        //       "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
        // ),
      ],
    );
  }

  Column makeAvatars(List<String> images) {
    final sized = images.length > 1 ? Sizes.size32 : Sizes.size60;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              avatarContaier(
                images[0],
                sized,
              ),
              if (images.length == 2) const Spacer(),
              if (images.length > 2)
                avatarContaier(
                  images[2],
                  sized,
                ),
            ],
          ),
        ),
        if (images.length > 1)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (images.length == 2) const Spacer(),
                avatarContaier(
                  images[1],
                  sized,
                ),
                if (images.length > 3)
                  avatarContaier(
                    images[3],
                    sized,
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Container avatarContaier(String images, double sized) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        // image: DecorationImage(
        //   fit: BoxFit.fill,
        //   image: NetworkImage(
        //       "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
        // ),
        shape: BoxShape.circle,
      ),
      child: Image.network(
        images,
        fit: BoxFit.fill,
        width: sized,
        height: sized,
      ),
    );
  }
}
