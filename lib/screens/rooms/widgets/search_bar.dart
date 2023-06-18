import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/utils/app_theme.dart';

class SearchingBar extends StatelessWidget {
  const SearchingBar({
    super.key,
    required this.onChangeSearch,
    required this.onTapSearch,
  });

  final Function onChangeSearch;
  final Function onTapSearch;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMod(context);
    return Stack(
      // clipBehavior: Clip.hardEdge,
      alignment: Alignment.centerRight,
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
            child: TextFormField(
              onChanged: (value) => onChangeSearch(value),
              showCursor: false,
              style: TextStyle(
                fontSize: Sizes.size20,
                // backgroundColor: isDark ? Colors.black38 : Colors.white24,
                color: isDark ? Colors.black54 : Colors.white54,
              ),
            ),
          ),
        ),
        Positioned(
          right: Sizes.size20,
          child: GestureDetector(
            onTap: () => onTapSearch(),
            child: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: Sizes.size16,
            ),
          ),
        ),
      ],
    );
  }
}
