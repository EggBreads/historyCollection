import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:historycollection/Constants/router_constraint.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/profile/view_models/profile_view_model.dart';
import 'package:historycollection/screens/profile/widgets/profile_sliver_box.dart';
import 'package:historycollection/screens/profile/widgets/profile_tab_bar.dart';

Map<String, dynamic> profileLabels = {
  "nickName": "닉네임",
  "email": "이메일",
};

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  // final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  // final Map<String, dynamic> _mapController = <String, TextEditingController>{};

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _initController();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _onTapSettings() {
    context.push(
      RouterPathAndNameConstraint.settingsRoutePATH,
    );
  }

  void _onTapInterest() {
    print("sdfsdfsdf");
    context.push(
      RouterPathAndNameConstraint.interestRoutePATH,
    );
  }

  void _onTapWant() {
    context.push(
      RouterPathAndNameConstraint.networkRoutePATH,
    );
  }

  // void _initController() {
  //   for (var key in profileLabels.keys) {
  //     TextEditingController textEditController = TextEditingController();
  //     textEditController.text = 'test123123123';
  //     _mapController[key] = textEditController;
  //   }
  // }

  // String? _isEmailValid(email) {
  //   if (email.isEmpty) {
  //     return null;
  //   }

  //   final regExp = RegExp(
  //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //   if (!regExp.hasMatch(email)) {
  //     return "이메일 형식이 정확하지 않아요";
  //   }

  //   return null;
  // }

  // String? _isNickName(String nickName) {
  //   if (nickName.isEmpty) {
  //     return null;
  //   }

  //   if (nickName.length > 1) {
  //     return null;
  //   }

  //   return "2글자이상 닉네임을 읿력해주세요";
  // }

  // void _editComplete() {
  //   for (var key in profileLabels.keys) {
  //     TextEditingController textEditController = _mapController[key];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      //   // actions: [],
      //   title: Text(
      //     'Record Video',
      //     style: Theme.of(context).appBarTheme.titleTextStyle,
      //   ),
      // ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(
              Sizes.size14,
            ),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    centerTitle: true,
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: Sizes.size20,
                      ),
                    ),
                    title: const Text("프로필"),
                    actions: [
                      IconButton(
                        onPressed: _onTapSettings,
                        icon: const Icon(
                          FontAwesomeIcons.gear,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: getSliverHeaderBox(
                      context,
                      _onTapInterest,
                      _onTapWant,
                      ref.watch(profileProvider),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: ProfileTabBar(),
                    pinned: true,
                    floating: true,
                  ),
                ];
              },
              body: const TabBarView(
                children: [
                  Center(
                    child: Text("Test1"),
                  ),
                  Center(
                    child: Text("Test2"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: CupertinoButton.filled(
      //     borderRadius: BorderRadius.zero,
      //     onPressed: _editComplete,
      //     child: const Text("저장"),
      //   ),
      // ),
    );
  }
}
