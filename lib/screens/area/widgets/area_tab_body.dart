// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';

import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/utils/app_theme.dart';

class AreaTabBody extends StatefulWidget {
  final AraeModel item;
  final double distance;

  const AreaTabBody({
    Key? key,
    required this.item,
    required this.distance,
  }) : super(key: key);

  @override
  AreaTabBodyState createState() => AreaTabBodyState();
}

class AreaTabBodyState extends State<AreaTabBody> {
  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMod(context);

    return Column(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 9 / 14,
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: "assets/images/waterfall.jpeg",
                image:
                    // widget.item.shotImg,
                    "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
              ),
            ),
            Positioned(
              bottom: Sizes.size5,
              // left: Sizes.size5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size5,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        // const Text(
                        //   "호",
                        // ),
                        RichText(
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          text: TextSpan(
                            text: widget.item.nickName,
                            children: [
                              const TextSpan(
                                text: "(",
                              ),
                              TextSpan(
                                text: "${widget.item.interest})",
                              ),
                            ],
                          ),
                        ),
                        Gaps.h5,
                        FaIcon(
                          FontAwesomeIcons.userCheck,
                          size: Sizes.size14,
                          color: isDark
                              ? Colors.amber.shade200
                              : Colors.blue.shade400,
                        ),
                      ],
                    ),
                    Gaps.v3,
                    // const Text(
                    //   "모집인원(4)",
                    // ),
                    RichText(
                      maxLines: 1,
                      text: TextSpan(
                        text: "${widget.item.location}($widget.distance)",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
