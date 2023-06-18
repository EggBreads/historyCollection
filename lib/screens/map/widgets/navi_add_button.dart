import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/utils/app_theme.dart';

class NaviAddBtn extends StatelessWidget {
  const NaviAddBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMod(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _addBtnDecoArea(
          null,
          Sizes.size10,
          Theme.of(context).colorScheme.secondary,
        ),
        _addBtnDecoArea(
          Sizes.size10,
          null,
          Theme.of(context).colorScheme.tertiary,
        ),
        Container(
          padding: const EdgeInsets.all(
            Sizes.size5,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(
              Sizes.size10,
            ),
            // color: Colors.black54,
          ),
          child: FaIcon(
            FontAwesomeIcons.plus,
            size: Sizes.size28,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Positioned _addBtnDecoArea(
      double? leftDis, double? rightDis, Color areaColor) {
    return Positioned(
      left: leftDis,
      right: rightDis,
      // bottom: 3.0,
      child: Container(
        width: Sizes.size28,
        height: Sizes.size32 + Sizes.size6,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size5,
        ),
        decoration: BoxDecoration(
          color: areaColor,
          borderRadius: BorderRadius.circular(
            Sizes.size10,
          ),
        ),
      ),
    );
  }
}
