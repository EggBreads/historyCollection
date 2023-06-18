import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:historycollection/Constants/router_constraint.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/rooms/models/room_model.dart';

class RoomChatInfo extends StatefulWidget {
  final RoomModel room;

  const RoomChatInfo({
    super.key,
    required this.room,
  });

  @override
  State<RoomChatInfo> createState() => _RoomChatInfoState();
}

class _RoomChatInfoState extends State<RoomChatInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _pushChat(String chatKey) {
    context.pushNamed(
      RouterPathAndNameConstraint.chatsRouteNAME,
      pathParameters: {"chatKey": chatKey},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      child: GestureDetector(
        onTap: () => _pushChat(widget.room.chatKey),
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.white,
          child: ListTile(
            visualDensity: const VisualDensity(
              vertical: Sizes.size4,
            ),
            // leadingAndTrailingTextStyle: TextStyle(
            //   fontSize: Sizes.size52,
            // ),
            minVerticalPadding: Sizes.size30,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
            ),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.room.title,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                const CircleAvatar(
                  radius: Sizes.size20,
                  foregroundImage: NetworkImage(
                    "https://lh3.googleusercontent.com/a/AGNmyxY2W1Lnq-TGTU--9Drz_cnU1ctdn3Ygi-G8Jwka=s96-c",
                    // scale: Sizes.size10,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    size: Sizes.size20,
                  ),
                ),
              ],
            ),
            title: AspectRatio(
              aspectRatio: 12 / 8,
              child: FadeInImage.assetNetwork(
                width: 50,
                fit: BoxFit.cover,
                placeholder: "assets/images/waterfall.jpeg",
                image:
                    "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.room.title,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                RichText(
                  maxLines: 4,
                  text: TextSpan(
                      text: widget.room.subTitle,
                      style: const TextStyle(
                        color: Colors.black,
                      )),
                ),
              ],
            ),
          ),
          // child: SizedBox(
          //   width: Sizes.size52,
          //   height: Sizes.size52,
          //   child: Row(
          //     children: [
          //       Column(
          //         children: [
          //           const CircleAvatar(
          //             radius: Sizes.size14,
          //             foregroundImage: NetworkImage(
          //               "https://lh3.googleusercontent.com/a/AGNmyxY2W1Lnq-TGTU--9Drz_cnU1ctdn3Ygi-G8Jwka=s96-c",
          //               // scale: Sizes.size10,
          //             ),
          //             child: FaIcon(
          //               FontAwesomeIcons.user,
          //               size: Sizes.size14,
          //             ),
          //           ),
          //           Row(
          //             children: [
          //               const CircleAvatar(
          //                 radius: Sizes.size14,
          //                 foregroundImage: NetworkImage(
          //                   "https://lh3.googleusercontent.com/a/AGNmyxY2W1Lnq-TGTU--9Drz_cnU1ctdn3Ygi-G8Jwka=s96-c",
          //                   // scale: Sizes.size10,
          //                 ),
          //                 child: FaIcon(
          //                   FontAwesomeIcons.user,
          //                   size: Sizes.size5,
          //                 ),
          //               ),
          //               const CircleAvatar(
          //                 radius: Sizes.size14,
          //                 foregroundImage: NetworkImage(
          //                   "https://lh3.googleusercontent.com/a/AGNmyxY2W1Lnq-TGTU--9Drz_cnU1ctdn3Ygi-G8Jwka=s96-c",
          //                   // scale: Sizes.size10,
          //                 ),
          //                 child: FaIcon(
          //                   FontAwesomeIcons.user,
          //                   size: Sizes.size5,
          //                 ),
          //               ),
          //               const Spacer(),
          //               AspectRatio(
          //                 aspectRatio: 16 / 9,
          //                 child: FadeInImage.assetNetwork(
          //                   fit: BoxFit.cover,
          //                   placeholder: "assets/images/waterfall.jpeg",
          //                   image:
          //                       "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
          //                 ),
          //               ),
          //               Column(
          //                 children: [
          //                   RichText(
          //                     maxLines: 1,
          //                     text: const TextSpan(text: "sdfsadfasdfasdf"),
          //                   ),
          //                   Row(
          //                     children: [
          //                       TextButton(
          //                         onPressed: () {},
          //                         child: const Text("종료"),
          //                       ),
          //                       TextButton(
          //                         onPressed: () {},
          //                         child: const Text("참여"),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //       // ListTileTheme(
          //       //   child: ListTile(
          //       //     leading: const CircleAvatar(
          //       //       radius: Sizes.size14,
          //       //       foregroundImage: NetworkImage(
          //       //         "https://lh3.googleusercontent.com/a/AGNmyxY2W1Lnq-TGTU--9Drz_cnU1ctdn3Ygi-G8Jwka=s96-c",
          //       //         // scale: Sizes.size10,
          //       //       ),
          //       //       child: FaIcon(
          //       //         FontAwesomeIcons.user,
          //       //         size: Sizes.size14,
          //       //       ),
          //       //     ),
          //       //     title: AspectRatio(
          //       //       aspectRatio: 16 / 9,
          //       //       child: FadeInImage.assetNetwork(
          //       //         fit: BoxFit.cover,
          //       //         placeholder: "assets/images/waterfall.jpeg",
          //       //         image:
          //       //             "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
          //       //       ),
          //       //     ),
          //       //     trailing: RichText(
          //       //       maxLines: 1,
          //       //       text: const TextSpan(text: "sdfsadfasdfasdf"),
          //       //     ),
          //       //   ),
          //       // ),
          //       // Row(
          //       //   children: [

          //       //   ],
          //       // ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
