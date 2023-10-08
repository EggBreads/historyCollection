import 'package:flutter/material.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/home/widgets/home_theme_widget.dart';

class HomeTheme extends StatelessWidget {
  const HomeTheme({super.key});

  static const List<String> mainImages = [
    "assets/images/fall.jpeg",
    "assets/images/summer.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '여행 메모리즈~',
          style: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).highlightColor,
          ),
        ),
        Gaps.v20,
        LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight;
            final maxWidth = constraints.maxWidth;
            return HomeThemes(
              imgList: mainImages,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            );
          },
        ),
        Gaps.v20,
        Text(
          "지금 이 순간 모든 곳 모두 이 곳 여기 메모리에 모두 담아봐~",
          style: TextStyle(
            fontSize: Sizes.size20,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
    // return ListView.separated(
    //   scrollDirection: Axis.horizontal,
    //   padding: const EdgeInsets.symmetric(
    //     vertical: 10,
    //     horizontal: 10,
    //   ),
    //   itemCount: mainImages.length,
    //   itemBuilder: (context, index) {
    //     return Row(
    //       children: [
    //         Container(
    //           clipBehavior: Clip.hardEdge,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(35),
    //             // boxShadow: [
    //             //   BoxShadow(
    //             //     blurRadius: 10,
    //             //     offset: const Offset(10, 10),
    //             //     color: Colors.black.withOpacity(0.5),
    //             //   ),
    //             // ],
    //           ),
    //           // width: 250,
    //           // height: 250,
    //           child: Image.asset(mainImages[index]),
    //         ),
    //       ],
    //     );
    //   },
    //   separatorBuilder: (context, index) {
    //     return const SizedBox(
    //       width: 20,
    //     );
    //   },
    // );
  }
}
