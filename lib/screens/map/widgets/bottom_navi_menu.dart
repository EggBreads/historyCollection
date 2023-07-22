// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';

class BottomNaviMenu extends StatelessWidget {
  const BottomNaviMenu({
    Key? key,
    required this.naviIcon,
    required this.naviText,
  }) : super(key: key);

  final IconData naviIcon;
  final String naviText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(
          naviIcon,
          color: Theme.of(context).colorScheme.primary,
          size: Sizes.size20,
        ),
        Gaps.v10,
        Text(
          naviText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
