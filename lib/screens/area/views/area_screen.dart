import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/screens/area/view_models/area_view_model.dart';
import 'package:historycollection/screens/area/widgets/area_persistent_tabar.dart';
import 'package:historycollection/screens/area/widgets/area_register.dart';
import 'package:historycollection/screens/area/widgets/area_tab_body.dart';
import 'package:historycollection/screens/home/view_models/auth_view_model.dart';
import 'package:historycollection/screens/login/models/user_model.dart';
import 'package:historycollection/screens/map/models/map_position_model.dart';
import 'package:historycollection/screens/rooms/view_models/rooms_view_model.dart';
import 'package:historycollection/utils/util_widget.dart';
import 'package:historycollection/webrtc/providers/socket_client_provider.dart';
import 'package:latlong2/latlong.dart';

class AreaScreen extends ConsumerStatefulWidget {
  const AreaScreen({super.key});

  @override
  ConsumerState<AreaScreen> createState() => AreaScreenState();
}

class AreaScreenState extends ConsumerState<AreaScreen>
    with TickerProviderStateMixin {
  // late Future<List<AraeModel>> _areaItems;

  // final bool _showBarrier = false;

  // late final AnimationController _animationController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(
  //     milliseconds: 400,
  //   ),
  // );

  // late final Animation<Color?> _barrierAnimation = ColorTween(
  //   begin: Colors.transparent,
  //   end: Colors.black54,
  // ).animate(_animationController);

  @override
  void initState() {
    super.initState();
    // _areaItems = AreaApiService.getAreaItems();
    // _areaItems = _initItems();
  }

  double _getDistance(LatLng str, LatLng dst) {
    // 37.6128239 127.1535594
    return const Distance()
        .as(LengthUnit.Kilometer, LatLng(37.6128239, 127.1535594), dst);
  }

  Future<void> _onRefresh() async {
    final aRef = ref.read(areaProvider.notifier);
    return await aRef.onRefresh();
  }

  Future<void> _onReqJoin(AraeModel item) async {
    final aRef = ref.read(roomsProvider.notifier);

    final room = await aRef.getRoom(item.chatKey);

    if (room == null) {
      if (mounted) {
        showFirebaseErrorSnack(context, "정상적인 공간이 아니에요");
      }
      return;
    }

    final userInfo = ref.read(authProvider.notifier).userInfo;

    room.joiners = {
      ...room.joiners,
      '${userInfo.userEmail}': '${userInfo.userName}',
    };

    // ["${userInfo.userEmail}"] = "${userInfo.userName}";

    final webrtcRef = ref.read(webrtcServiceProvider);

    webrtcRef.joinRoom(room);
  }

  // Future<void> _toggleAnimations() async {
  //   if (_animationController.isCompleted) {
  //     await _animationController.reverse();
  //     if (!mounted) {
  //       return;
  //     }
  //     FocusScope.of(context).unfocus();
  //   } else {
  //     _animationController.forward();
  //   }

  //   setState(() {
  //     _showBarrier = !_showBarrier;
  //   });
  // }

  void _createRoom() {
    UserModel userInfo = ref.read(authProvider.notifier).getUserInfo!;
    if (!userInfo.isEmailVertified) {
      Scaffold.of(context).showBottomSheet((context) {
        return const SnackBar(
          // action: SnackBarAction(
          //   label: "Close",
          //   onPressed: () {},
          // ),
          showCloseIcon: true,
          content: Text("이메일 인증이 되지 않았습니다"),
        );
      });
      return;
    }
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder:
            // secondaryAnimation: 화면 전화시 사용되는 보조 애니메이션효과
            // child: 화면이 전환되는 동안 표시할 위젯을 의미(즉, 전환 이후 표시될 위젯 정보를 의미)
            (context, animation, secondaryAnimation, child) {
          // Offset에서 x값 1은 오른쪽 끝 y값 1은 아래쪽 끝을 의미한다.
          // 애니메이션이 시작할 포인트 위치를 의미한다.
          var begin = const Offset(1.0, 0);
          var end = Offset.zero;
          // Curves.ease: 애니메이션이 부드럽게 동작하도록 명령
          var curve = Curves.ease;
          // 애니메이션의 시작과 끝을 담당한다.
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(
            CurveTween(
              curve: curve,
            ),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        // 함수를 통해 Widget을 pageBuilder에 맞는 형태로 반환하게 해야한다.
        pageBuilder: (context, animation, secondaryAnimation) =>
            // (DetailScreen은 Stateless나 Stateful 위젯으로된 화면임)
            const AreaRegister(),
        // 이것을 true로 하면 dialog로 취급한다.
        // 기본값은 false
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aRef = ref.watch(areaProvider);
    final userInfo = ref.read(authProvider.notifier).getUserInfo;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Area",
        ),
        actions: [
          // if (!_showBarrier)
          IconButton(
            onPressed: _createRoom,
            icon: const FaIcon(
              FontAwesomeIcons.circlePlus,
            ),
          ),
        ],
      ),
      body: aRef.when(
        error: (error, stackTrace) => Center(
          child: Text("Could not load videos: ${aRef.error}"),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        data: (data) {
          var isEmpty = data.isEmpty;
          List<String> interests = [];
          if (!isEmpty) {
            data = data.where((item) {
              return item.hostEmail != userInfo!.userEmail;
            }).toList();
            if (data.isEmpty) {
              isEmpty = true;
            } else {
              Set<String> setInterests = data.map((e) => e.interest).toSet();
              interests = ['ALL', ...setInterests];
            }
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 40,
            edgeOffset: 20,
            child: isEmpty
                ? Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(FontAwesomeIcons.skull),
                          ),
                          TextSpan(
                            text: '근처에 등록된 참여 할곳이 없네요....',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : DefaultTabController(
                    initialIndex: 0,
                    length: interests.length,
                    child: Stack(
                      children: [
                        NestedScrollView(
                          headerSliverBuilder: (context, innerBoxIsScrolled) {
                            // print("test1 => $innerBoxIsScrolled");
                            return [
                              SliverPersistentHeader(
                                delegate:
                                    AreaPersistentTabar(areaItems: interests),
                                pinned: true,
                                floating: true,
                              ),
                            ];
                          },
                          body: TabBarView(
                            children: [
                              ...interests.map(
                                (interest) {
                                  if (interest == 'ALL') {
                                    return _areaTabViews(data);
                                  }
                                  final area = data
                                      .where(
                                          (area) => area.interest == interest)
                                      .toList();
                                  return _areaTabViews(area);
                                },
                              ),
                            ],
                          ),
                        ),
                        // if (_showBarrier)
                        //   AnimatedModalBarrier(
                        //     color: _barrierAnimation,
                        //     dismissible: true,
                        //     onDismiss: _toggleAnimations,
                        //   ),
                        // Positioned(
                        //   // top: 0,
                        //   bottom: 0,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: SlideTransition(
                        //     position: _panelAnimation,
                        //     child: const Padding(
                        //       padding: EdgeInsets.symmetric(
                        //         horizontal: Sizes.size10,
                        //       ),
                        //       child: AreaRegister(),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  GridView _areaTabViews(List<AraeModel> data) {
    return GridView.builder(
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 14,
        mainAxisSpacing: Sizes.size5,
        crossAxisSpacing: Sizes.size5,
      ),
      itemBuilder: (context, index) {
        final AraeModel item = data[index];
        MapPosition areaPosition = item.position;
        final distance = _getDistance(
          LatLng(areaPosition.lat, areaPosition.lng),
          LatLng(areaPosition.lat, areaPosition.lng),
        );
        return GestureDetector(
          onTap: () => _onReqJoin(item),
          child: AreaTabBody(
            item: item,
            distance: distance,
          ),
        );
      },
    );
  }
}
