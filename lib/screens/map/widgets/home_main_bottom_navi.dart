import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/map/widgets/bottom_navi_menu.dart';
import 'package:historycollection/screens/map/widgets/navi_add_button.dart';

class HomeMainBottomNavi extends StatefulWidget {
  const HomeMainBottomNavi({
    super.key,
    required this.bottomNaviTap,
  });

  final Function bottomNaviTap;

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
          horizontal: Sizes.size10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNaviMenu(
              naviIcon: FontAwesomeIcons.houseChimney,
              naviText: 'Map',
              naviTap: () => widget.bottomNaviTap(0),
              // naviTap: () => _naviTap(0),
            ),
            BottomNaviMenu(
              naviIcon: FontAwesomeIcons.magnifyingGlass,
              naviText: 'Rooms',
              naviTap: () => widget.bottomNaviTap(1),

              // naviTap: () => _naviTap(1),
            ),
            const NaviAddBtn(),
            BottomNaviMenu(
              naviIcon: FontAwesomeIcons.message,
              naviText: 'Chats',
              naviTap: () => widget.bottomNaviTap(3),

              // naviTap: () => _naviTap(3),
            ),
            BottomNaviMenu(
              naviIcon: FontAwesomeIcons.user,
              naviText: 'Profile',
              naviTap: () => widget.bottomNaviTap(4),
              // naviTap: () => _naviTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
