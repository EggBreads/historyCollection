import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/settings/view_models/settings_view_model.dart';
import 'package:historycollection/utils/app_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  // bool _notification = false;

  // void _onNotificationChanged(bool? newValue) {
  //   if (newValue == null) {
  //     return;
  //   }

  //   setState(() {
  //     _notification = newValue;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMod(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: ref.watch(settingsProvider).notification,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).setNotification(value);
            },
            title: const Text("알림끄기"),
            subtitle: const Text("서비스제공알림정보"),
          ),
          Gaps.v16,
          SwitchListTile(
            value: ref.watch(settingsProvider).notification,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).setNotification(value);
            },
            title: const Text("OnLine/OffLine"),
            subtitle: const Text("온/오프표시알림"),
          ),
          Gaps.v16,
          const AboutListTile(
            icon: Icon(Icons.info),
            applicationIcon: FaIcon(
              FontAwesomeIcons.thumbsUp,
            ),
            applicationName: 'Project',
            applicationVersion: 'v0.0.0.0.1',
            // aboutBoxChildren: aboutBoxChildren,
          ),
          Gaps.v16,
          const ListTile(
            minLeadingWidth: Sizes.size40,
            leading: Text(
              "Account",
            ),
            title: Text(
              "mds1262@naver.com",
              textAlign: TextAlign.right,
            ),
            trailing: FaIcon(
              FontAwesomeIcons.arrowRight,
            ),
          ),
          Gaps.v16,
          const ListTile(
            // minLeadingWidth: Sizes.size40,
            leading: FaIcon(
              FontAwesomeIcons.solidLightbulb,
            ),
            title: Text(
              "Contact Us",
              textAlign: TextAlign.start,
            ),
            // trailing: FaIcon(
            //   FontAwesomeIcons.,
            // ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: Sizes.size1,
        child: Padding(
          padding: EdgeInsets.zero,
          child: CupertinoButton.filled(
            onPressed: () {},
            child: Text(
              "로그아웃",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Sizes.size14,
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
