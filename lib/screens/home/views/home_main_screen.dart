import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:historycollection/screens/area/views/area_screen.dart';
import 'package:historycollection/screens/map/views/home_map_screen.dart';
import 'package:historycollection/screens/map/widgets/home_main_bottom_navi.dart';
import 'package:historycollection/screens/profile/views/profile_screen.dart';
import 'package:historycollection/screens/rooms/views/rooms_screen.dart';

class HomeMainScreen extends StatefulWidget {
  final String main;
  const HomeMainScreen({
    super.key,
    required this.main,
  });

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  final List<String> _mains = [
    "map",
    "rooms",
    "xxxx",
    "chats",
    "profile",
  ];

  late int _curHomeScreenIdx = _mains.indexOf(widget.main);

  void _bottomNaviTap(int idx) {
    context.go("/${_mains[idx]}");

    setState(() {
      _curHomeScreenIdx = idx;
      // _naviPush();
    });
  }

  @override
  void initState() {
    super.initState();
    // print("test $_curHomeScreenIdx");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // const Center(
            //   child: HomeMapScreen(),
            // ),
            Offstage(
              offstage: _curHomeScreenIdx != 0,
              child: const HomeMapScreen(),
            ),
            Offstage(
              offstage: _curHomeScreenIdx != 1,
              child: const AreaScreen(),
            ),
            Offstage(
              offstage: _curHomeScreenIdx != 3,
              child: const RoomsScreen(),
            ),
            Offstage(
              offstage: _curHomeScreenIdx != 4,
              child: const ProfileScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeMainBottomNavi(
        bottomNaviTap: _bottomNaviTap,
        selectedTabIdx: _curHomeScreenIdx,
      ),
    );
  }
}
