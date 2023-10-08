import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/router_constraint.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/screens/area/view_models/area_view_model.dart';
import 'package:historycollection/screens/home/view_models/auth_view_model.dart';
import 'package:historycollection/screens/interests/models/interests_model.dart';
import 'package:historycollection/screens/interests/view_models/interests_view_model.dart';
import 'package:historycollection/screens/map/models/map_position_model.dart';
import 'package:historycollection/screens/map/view_models/map_view_model.dart';

class AreaRegister extends ConsumerStatefulWidget {
  const AreaRegister({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AreaRegisterState();
}

class _AreaRegisterState extends ConsumerState<AreaRegister>
    with WidgetsBindingObserver {
  // AraeModel? _areaRegisterForm;

  InterestModel? _selectedItem;

  @override
  void initState() {
    super.initState();
    // _initAreaRegister();
  }

  void _backTap() {
    FocusScope.of(context).unfocus();
    context.pop();
  }

  void _keyboardHide() {
    FocusScope.of(context).unfocus();
  }

  Future<void> _cameraOnTap(Map<String, dynamic> areaRegisterForm) async {
    final result = await context.push(
      RouterPathAndNameConstraint.cameraRoutePATH,
      // extra: areaRegisterForm,
    );

    if (result == null) {
      return;
    }
    areaRegisterForm['shotImg'] = result;
  }

  // Future<void> _initAreaRegister() async {

  //   _areaRegisterForm = AraeModel(
  //     chatKey: '',
  //     title: '',
  //     subTitle: '',
  //     hostEmail: userInfo.userEmail ?? '',
  //     shotImg: '',
  //     nickName: userInfo.userName!,
  //     interest: _selectedItem == null ? '' : _selectedItem!.title,
  //     enterCnt: 1,
  //     location: address,
  //     position: AreaPosition(
  //       lat: mapPosition.lat,
  //       lng: mapPosition.lng,
  //     ),
  //     createdAt: 0,
  //   );
  // }

  // void _onChangedInterest(InterestModel value) {
  //   if (_selectedItem != null) {
  //     _selectedItem = value;
  //     _areaRegisterForm!.interest = value.title;
  //     setState(() {});
  //   }
  // }

  void _onTapDeleteImg(Map<String, dynamic> areaRegisterForm) {
    areaRegisterForm['shotImg'] = '';
    setState(() {});
  }

  void _onChangeEdit(
      Map<String, dynamic> areaRegisterForm, String type, dynamic val) {
    // final roomStateRef = ref.read(roomsFormProvider.notifier);

    areaRegisterForm[type] = val;
    setState(() {});
  }

  Future<void> _onTapCreateArea(Map<String, dynamic> areaFormProvider) async {
    final areaRef = ref.read(areaProvider.notifier);

    if (!mounted) {
      return;
    }
    final chatKey = await areaRef.createAreaRoom();

    final mapRef = ref.read(mapProvider.notifier);
    final userInfo = ref.read(authProvider.notifier).getUserInfo;
    MapPosition mapPosition = mapRef.getThisPosition;
    final address = await mapRef.getAddress(mapPosition.lat, mapPosition.lng);

    areaFormProvider['chatKey'] = chatKey;
    areaFormProvider['hostEmail'] = userInfo!.userEmail;
    areaFormProvider['nickName'] = userInfo.userName!;
    areaFormProvider['createdAt'] = DateTime.now().millisecondsSinceEpoch;
    areaFormProvider['location'] = address;
    areaFormProvider['position'] = mapPosition.toMap();

    await areaRef.createArea(AraeModel.fromMap(areaFormProvider));

    if (!mounted) {
      return;
    }

    areaFormProvider.clear();

    context.pop();
  }

  @override
  void dispose() {
    // _areaRegisterForm = null;
    _selectedItem = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iRef = ref.watch(interestsProvider);
    final sized = MediaQuery.of(context).size;
    // final interest = _selectedItem == null ? '' : _selectedItem!.title;
    final areaRegisterForm = ref.read(areaFormProvider);
    // final socket = ref.read(socketClientsProvider.notifier).socket;
    // socket!.emit('events', '123123123123123');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _backTap,
          icon: const FaIcon(
            FontAwesomeIcons.x,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: _keyboardHide,
          child: Container(
            padding: const EdgeInsets.only(
              top: Sizes.size16,
              left: Sizes.size10,
              right: Sizes.size10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Expanded(
                          child: TextField(
                            obscureText: true,
                            style: TextStyle(
                              fontSize: Sizes.size14,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                focusedBorder: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                labelText: "참여방 비밀번호",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizes.size10,
                                ),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start
                                // hintStyle: TextStyle(
                                //   fontSize: Sizes.size10,
                                //   color: Colors.black45,
                                // ),
                                // hintMaxLines: 30,
                                // hintText: "함께 즐길 제목을 입력해주세요",
                                ),
                          ),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: Sizes.size14,
                              color: Colors.black,
                            ),
                            onChanged: (value) => _onChangeEdit(
                                areaRegisterForm, 'enterCnt', int.parse(value)),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              focusedBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              labelText: "참여할최대인원수",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.size10,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              // hintStyle: TextStyle(
                              //   fontSize: Sizes.size10,
                              //   color: Colors.black45,
                              // ),
                              // hintMaxLines: 30,
                              // hintText: "함께 즐길 제목을 입력해주세요",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gaps.v20,
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      // height: 300,
                      padding: const EdgeInsets.all(
                        Sizes.size8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            // controller: textarea,
                            keyboardType: TextInputType.multiline,
                            maxLines: 1,
                            onChanged: (value) =>
                                _onChangeEdit(areaRegisterForm, 'title', value),
                            decoration: const InputDecoration(
                              // hintText: "Enter Remarks",
                              // hintStyle: TextStyle(
                              //   fontSize: Sizes.size10,
                              //   color: Colors.black45,
                              // ),
                              labelText: "참여채팅방 제목",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.size10,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          ),
                          Gaps.v20,
                          TextField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            // controller: textarea,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            onChanged: (value) => _onChangeEdit(
                                areaRegisterForm, 'subTitle', value),
                            decoration: const InputDecoration(
                              // hintText: "Enter Remarks",
                              // hintStyle: TextStyle(
                              //   fontSize: Sizes.size10,
                              //   color: Colors.black45,
                              // ),
                              labelText: "상세한 참여 내용",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.size10,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Gaps.v10,
                iRef.when(
                  error: (error, stackTrace) => Container(),
                  loading: () => Container(),
                  data: (data) {
                    _selectedItem ??= data[0];
                    if (areaRegisterForm['interest'] == null ||
                        areaRegisterForm['interest'].isEmpty) {
                      areaRegisterForm['interest'] = data[0].title;
                    }
                    return Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "관심사 선택",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        Gaps.h5,
                        Expanded(
                          child: Container(
                              // width: sized.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black38,
                                  width: Sizes.size2,
                                ),
                                borderRadius: BorderRadius.circular(
                                  Sizes.size10,
                                ),
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Colors.black26,
                                //   ),
                                //   BoxShadow(
                                //     color: Colors.black54,
                                //   )
                                // ],
                              ),
                              child: interestDropBox(data, areaRegisterForm)),
                        ),
                      ],
                    );
                  },
                ),
                Gaps.v10,
                Column(
                  children: [
                    Container(
                      // width: sized.width,
                      height: sized.height / 3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: Sizes.size2,
                        ),
                        borderRadius: BorderRadius.circular(
                          Sizes.size10,
                        ),
                      ),
                      child: (areaRegisterForm['shotImg'] == null ||
                              areaRegisterForm['shotImg'].isEmpty)
                          ? GestureDetector(
                              onTap: () => _cameraOnTap(areaRegisterForm),
                              child: const Center(
                                child: CircleAvatar(
                                  child: FaIcon(
                                    FontAwesomeIcons.camera,
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Container(
                                  // height: sized.height / 3,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                          File(
                                            areaRegisterForm['shotImg'],
                                          ),
                                        )
                                        // image: NetworkImage(
                                        //   _areaRegisterForm!.shotImg,
                                        // ),
                                        ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () =>
                                        _onTapDeleteImg(areaRegisterForm),
                                    child: const CircleAvatar(
                                        child: FaIcon(
                                      FontAwesomeIcons.x,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.transparent,
        child: CupertinoButton(
          color: Colors.transparent,
          onPressed: () => _onTapCreateArea(areaRegisterForm),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("생성하기"),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<InterestModel> interestDropBox(
      List<InterestModel> data, Map<String, dynamic> areaRegisterForm) {
    return DropdownButton(
      alignment: Alignment.center,
      onChanged: (value) {
        _selectedItem = value;
        _onChangeEdit(areaRegisterForm, 'interest', value!.title);
      },
      // (value) {
      //   areaRegisterForm['interest'] = value!.title;
      //   _selectedItem = value;
      // },
      value: _selectedItem,
      dropdownColor: Colors.orange,
      // alignment: Alignment.center,
      menuMaxHeight: 250,
      // dropdownColor: Colors.transparent,
      isExpanded: true,
      // focusColor: Colors.black54,
      underline: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            width: 0,
          ),
        ),
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(
          Sizes.size10,
        ),
      ),
      // padding: const EdgeInsets.symmetric(
      //   horizontal: Sizes.size30,
      // ),
      selectedItemBuilder: (context) {
        return data.map((item) {
          // 선택한 박스 나타내는 ui
          return Container(
            alignment: Alignment.center,
            // constraints: const BoxConstraints(minWidth: 100),
            // width: 375,
            // color: Colors.black38,
            decoration: BoxDecoration(
              // border: Border.all(
              //   color: Colors.black38,
              //   width: Sizes.size2,
              // ),
              borderRadius: BorderRadius.circular(
                Sizes.size10,
              ),
            ),
            child: Text(
              item.title,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList();
      },
      items: data.map<DropdownMenuItem<InterestModel>>((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item.title,
          ),
        );
      }).toList(),
    );
  }
}
