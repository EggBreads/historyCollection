import 'package:flutter/material.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/utils/app_theme.dart';

class AreaPersistentTabar extends SliverPersistentHeaderDelegate {
  final int tabSize;

  AreaPersistentTabar({
    required this.tabSize,
  });

  _onTabbar(val) {
    // print("test1 $val");
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    final selectedIdx = DefaultTabController.of(context).index;
    final isDark = isDarkMod(context);
    return FractionallySizedBox(
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        automaticIndicatorColorAdjustment: false,
        indicatorColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: _onTabbar,
        splashFactory: NoSplash.splashFactory,
        labelColor: Theme.of(context).tabBarTheme.labelColor,
        labelStyle: Theme.of(context).tabBarTheme.labelStyle,
        unselectedLabelColor:
            Theme.of(context).tabBarTheme.unselectedLabelColor,
        unselectedLabelStyle:
            Theme.of(context).tabBarTheme.unselectedLabelStyle,
        // padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: Sizes.size3,
          vertical: Sizes.size5,
        ),
        tabs: [
          ...Iterable.generate(tabSize).map(
            (idx) {
              // test.asMap().entries.map((e) {
              //   print("test2 => $e");
              //   return e;
              // });
              return _tabClib(context, isDark, selectedIdx == idx);
            },
          ),
        ],
      ),
    );
  }

  Container _tabClib(BuildContext context, bool isDark, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(
        Sizes.size5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size20,
        ),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isSelected
                ? (isDark ? Colors.white : Colors.black)
                : Theme.of(context).scaffoldBackgroundColor,
            width: Sizes.size5,
          ),
          vertical: BorderSide(
            color: isSelected
                ? (isDark ? Colors.white : Colors.black)
                : Theme.of(context).scaffoldBackgroundColor,
            width: Sizes.size5,
          ),
        ),
        color: isSelected
            ? (isDark ? Colors.white : Colors.orangeAccent)
            : Theme.of(context).scaffoldBackgroundColor,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: Sizes.size16,
          color: isSelected
              ? (isDark ? Colors.black45 : Colors.white54)
              : (isDark ? Colors.white54 : Colors.black45),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "전체",
            ),
            Gaps.h5,
            Text(
              "123123123",
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 80;

  @override
  // TODO: implement minExtent
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    // throw UnimplementedError();
    return false;
  }
}
