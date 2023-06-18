import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/insertest_itmes.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/interest/widgets/interest_chip.dart';
import 'package:historycollection/screens/profile/widgets/profile_sliver_box.dart';
import 'package:historycollection/utils/app_theme.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen>
    with TickerProviderStateMixin {
  final GlobalKey<SliverAnimatedGridState> _gAnimatedtKey =
      GlobalKey<SliverAnimatedGridState>();

  final TextEditingController _textEditingController = TextEditingController();

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 1,
    ),
  );

  List<String> _selectedItmes = [];

  bool _showBarrier = false;

  // 임시
  InterestItems ii = InterestItems();

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (selectedItmes.isEmpty) {
    if (ii.selectedInterests.isNotEmpty) {
      _selectedItmes = ii.selectedInterests;
    } else {
      _selectedItmes = [];
    }
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _selectedItmes = [];
  }

  bool _chkInterItem(int idx) {
    // any 전체중하나
    // every 전체가 조건에 충족
    return _selectedItmes.any((selectedItem) {
      return selectedItem == ii.allInterests[idx];
    });
  }

  void updateItemFn(String item, bool isChk) {
    setState(() {
      // print('TEST11 => ${item}');
      // print('TEST11 => ${item.contains(widget.title)}');
      if (isChk) {
        if (!_selectedItmes.contains(item)) {
          _selectedItmes.add(item);
        }
      } else {
        if (_selectedItmes.contains(item)) {
          _selectedItmes.remove(item);
        }
      }
    });
  }

  void _onTapSave() {
    // 임시
    if (_showBarrier) {
      // 임시
      if (_textEditingController.value.text.isNotEmpty) {
        //검사
        List<String> findInterests = ii.allInterests.where(
          (interest) {
            return interest == _textEditingController.value.text;
          },
        ).toList();
        if (findInterests.isEmpty) {
          ii.allInterests.add(_textEditingController.value.text);
        }
      }
    } else {
      // selected item 저장
    }

    _showBarrier = false;
    setState(() {});
  }

  void _onTapResister() {
    _textEditingController.text = "";
    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMod(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            if (_showBarrier) ...[
              AnimatedModalBarrier(
                color: _barrierAnimation,
                dismissible: true,
                onDismiss: _onTapResister,
              ),
              Positioned(
                top: (size.height / 10),
                // left: Sizes.size20,
                width: size.width,
                child: CupertinoSearchTextField(
                  controller: _textEditingController,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white : Colors.black54,
                    borderRadius: BorderRadius.circular(
                      Sizes.size20,
                    ),
                  ),
                ),
              ),
            ],
            if (!_showBarrier) ...[
              Scrollbar(
                child: CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      centerTitle: true,
                      title: Text(
                        "관심사 선택",
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: [
                          StretchMode.blurBackground,
                          StretchMode.fadeTitle,
                        ],
                        // background: Image.asset(
                        //   "assets/images/waterfall.jpeg",
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gaps.v32,
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                              text: "당신의 관심사는 ????",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          Gaps.v20,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size48,
                            ),
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "찾거나 혹은 등록해주세요 당신의 관심사를~~~",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                          Gaps.v32,
                          getListtile(
                            context: context,
                            title: "관심사 없으면 등록해주세요~~~",
                            onTapFn: _onTapResister,
                            leadIcon: FontAwesomeIcons.circlePlus,
                          ),
                          Gaps.v40,
                        ],
                      ),
                    ),
                    SliverGrid.builder(
                      key: _gAnimatedtKey,
                      itemCount: ii.allInterests.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        // childAspectRatio: 0.5 / 0.5,
                        mainAxisSpacing: Sizes.size5,
                        crossAxisSpacing: Sizes.size5,
                        mainAxisExtent: Sizes.size44,
                      ),
                      itemBuilder: (context, index) {
                        return InterestChip(
                          // animation: animation,
                          idx: index,
                          title: ii.allInterests[index],
                          selected: _chkInterItem(index),
                          // selectedItems: _selectedItmes,
                          updateItemFn: updateItemFn,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        bottomNavigationBar: CupertinoButton.filled(
          onPressed: _onTapSave,
          child: Text(
            _showBarrier ? "관심사 추가" : "관심사 저장",
          ),
        ),
      ),
    );
  }
}
