import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/profile/models/profile_model.dart';
import 'package:historycollection/utils/app_theme.dart';

Widget getSliverHeaderBox(
  BuildContext context,
  Function onTapInterest,
  Function onTapWant,
  ProfileModel model,
) {
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            // minRadius: 50,
            // maxRadius: 75,
            radius: Sizes.size24 * 2,
            foregroundImage: const NetworkImage(
              "https://lh3.googleusercontent.com/a/AGNmyxY2W1Lnq-TGTU--9Drz_cnU1ctdn3Ygi-G8Jwka=s96-c",
              // scale: Sizes.size10,
            ),
            child: FaIcon(
              FontAwesomeIcons.user,
              size: Sizes.size20,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          Gaps.h5,
          Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyLarge!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      textWidthBasis: TextWidthBasis.parent,
                      text: TextSpan(
                        text: model.email,
                      ),
                    ),
                    Gaps.v5,
                    RichText(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      textWidthBasis: TextWidthBasis.parent,
                      text: TextSpan(
                        text: "${model.age}",
                      ),
                    ),
                    Chip(
                      label: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.bell,
                            color: Theme.of(context).iconTheme.color,
                            size: Sizes.size10,
                          ),
                          Gaps.h3,
                          Text(
                            model.nickName,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Gaps.v16,
      getListtile(
        context: context,
        title: "관심사을 선택해 보세요",
        onTapFn: onTapInterest,
        leadIcon: FontAwesomeIcons.play,
        tailIcon: FontAwesomeIcons.arrowRight,
      ),
      Gaps.v16,
      getListtile(
        context: context,
        title: "찜을 해놓은 목록 보기",
        onTapFn: onTapWant,
        leadIcon: FontAwesomeIcons.heartCircleCheck,
        tailIcon: FontAwesomeIcons.arrowRight,
      ),
      Gaps.v36,
    ],
  );
}

Widget getListtile({
  required BuildContext context,
  required String title,
  required Function onTapFn,
  IconData? leadIcon,
  IconData? tailIcon,
}
    // BuildContext context,
    // String title,
    // Function onTapFn,
    // IconData leadIcon,
    // IconData tailIcon,
    ) {
  final isDark = isDarkMod(context);
  return Container(
    decoration: BoxDecoration(
      // color: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(
          Sizes.size20,
        ),
      ),
      border: Border.all(
        color: isDark ? Colors.white : Colors.black,
      ),
    ),
    child: ListTile(
      iconColor: isDark ? Colors.white : Colors.red.shade500,
      // selectedTileColor: Theme.of(context).colorScheme.secondary,
      onTap: () {
        onTapFn();
      },
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
        // vertical: Sizes.size20,
      ),
      horizontalTitleGap: Sizes.size30,
      // minVerticalPadding: Sizes.size10,
      leading: leadIcon == null
          ? null
          : FaIcon(
              leadIcon,
              color: Theme.of(context).iconTheme.color,
              size: Sizes.size20,
            ),
      title: Text(title),
      //[
      trailing: tailIcon == null
          ? null
          : FaIcon(
              tailIcon,
              color: Theme.of(context).iconTheme.color,
              size: Sizes.size20,
            ),
      // ]
    ),
  );
}
