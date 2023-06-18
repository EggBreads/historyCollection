import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/utils/app_theme.dart';

class SearchList extends StatelessWidget {
  const SearchList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size8,
        vertical: Sizes.size10,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size14,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(
            Sizes.size8,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: Sizes.size14,
                  foregroundImage: NetworkImage(
                    "https://lh3.googleusercontent.com/a/AGNmyxY2W1Lnq-TGTU--9Drz_cnU1ctdn3Ygi-G8Jwka=s96-c",
                    // scale: Sizes.size10,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    size: Sizes.size14,
                  ),
                ),
                Gaps.h10,
                Text(
                  "아름다운 우리강산",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            FaIcon(
              FontAwesomeIcons.arrowTrendUp,
              size: Sizes.size14,
              color: isDarkMod(context)
                  ? Colors.cyan.shade400
                  : Colors.orangeAccent.shade400,
            )
          ],
        ),
      ),
    );
  }
}
