import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/map/widgets/bottom_navi_menu.dart';
import 'package:historycollection/screens/map/widgets/navi_add_button.dart';

class HomeMainBottomNavi extends StatefulWidget {
  const HomeMainBottomNavi({
    super.key,
    required this.bottomNaviTap,
    required this.selectedTabIdx,
  });

  final Function bottomNaviTap;
  final int selectedTabIdx;

  @override
  State<HomeMainBottomNavi> createState() => _HomeMainBottomNaviState();
}

class _HomeMainBottomNaviState extends State<HomeMainBottomNavi> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      elevation: 1,
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size10,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => widget.bottomNaviTap(0),
              child: BottomNaviMenu(
                naviIcon: FontAwesomeIcons.houseChimney,
                naviText: 'Map',
                isNaviTab: widget.selectedTabIdx == 0,
              ),
            ),
            GestureDetector(
              onTap: () => widget.bottomNaviTap(1),
              child: BottomNaviMenu(
                naviIcon: FontAwesomeIcons.magnifyingGlass,
                naviText: 'Rooms',
                isNaviTab: widget.selectedTabIdx == 1,

                // naviTap: () => _naviTap(1),
              ),
            ),
            const NaviAddBtn(),
            GestureDetector(
              onTap: () => widget.bottomNaviTap(3),
              child: BottomNaviMenu(
                naviIcon: FontAwesomeIcons.message,
                naviText: 'Chats',
                isNaviTab: widget.selectedTabIdx == 3,
              ),
            ),
            GestureDetector(
              onTap: () => widget.bottomNaviTap(4),
              child: BottomNaviMenu(
                naviIcon: FontAwesomeIcons.user,
                naviText: 'Profile',
                isNaviTab: widget.selectedTabIdx == 4,

                // naviTap: () => _naviTap(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
