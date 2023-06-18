import 'package:flutter/material.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';

class ChatRoomItem extends StatelessWidget {
  const ChatRoomItem({
    super.key,
    required this.idx,
  });

  final int idx;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   padding: const EdgeInsets.all(
        //     Sizes.size10,
        //   ),
        //   clipBehavior: Clip.antiAlias,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Colors.lime.shade300,
        //     borderRadius: BorderRadius.circular(
        //       Sizes.size10,
        //     ),
        //   ),
        //   child: Text(
        //     '테스트$idx',
        //     textAlign: TextAlign.start,
        //     style: const TextStyle(
        //       fontSize: Sizes.size16,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        // Gaps.v10,
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size14),
            // boxShadow: [
            //   BoxShadow(
            //     blurRadius: Sizes.size10,
            //     offset: const Offset(10, 10),
            //     color: Colors.black.withOpacity(0.5),
            //   )
            // ],
          ),
          // width: 250,
          // child: Container(),
          child: Image.network(
              "https://www.shutterstock.com/image-photo/beautiful-scenic-landscape-mountain-fuji-600w-1450515365.jpg"),
        ),
        Gaps.v10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              // cartoon.title,
              "테스트",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size20,
              ),
            ),
            Text(
              // cartoon.title,
              "테스트123",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              // cartoon.title,
              textAlign: TextAlign.start,
              "테스트123123123123123123123123",
              softWrap: true,
              style: Theme.of(context).textTheme.displayMedium,
              // style: TextStyle(
              //   color: Colors.grey.shade400,
              //   fontWeight: FontWeight.w600,
              //   fontSize: Sizes.size16,
              // ),
            ),
            Gaps.v3,
            Text(
              // cartoon.title,
              textAlign: TextAlign.start,
              "테스트123123123123123123123123",
              softWrap: true,
              style: Theme.of(context).textTheme.displayMedium,
              // style: TextStyle(
              //   color: Colors.grey.shade400,
              //   fontWeight: FontWeight.w600,
              //   fontSize: Sizes.size16,
              // ),
            )
          ],
        ),
        Gaps.v20,
      ],
    );
  }
}
