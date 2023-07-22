import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/api/area/area_api_service.dart';
import 'package:historycollection/screens/area/models/area_model.dart';
import 'package:historycollection/screens/area/models/area_position_model.dart';
import 'package:historycollection/screens/area/view_models/area_view_model.dart';
import 'package:historycollection/screens/area/widgets/area_persistent_tabar.dart';
import 'package:historycollection/utils/app_theme.dart';
import 'package:latlong2/latlong.dart';

class AreaScreen extends ConsumerStatefulWidget {
  const AreaScreen({super.key});

  @override
  ConsumerState<AreaScreen> createState() => AreaScreenState();
}

class AreaScreenState extends ConsumerState<AreaScreen> {
  late Future<List<AraeModel>> _areaItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _areaItems = AreaApiService.getAreaItems();
    // _areaItems = _initItems();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  double _getDistance(LatLng str, LatLng dst) {
    // 37.6128239 127.1535594
    return const Distance()
        .as(LengthUnit.Kilometer, LatLng(37.6128239, 127.1535594), dst);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMod(context);
    final aRef = ref.watch(areaProvider);
    return (aRef.isLoading)
        ? const Center(child: CircularProgressIndicator.adaptive())
        : aRef.hasError
            ? Center(
                child: Text("Could not load videos: ${aRef.error}"),
              )
            : DefaultTabController(
                initialIndex: 0,
                length: aRef.asData!.value.length,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      "Area",
                    ),
                  ),
                  body: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      // print("test1 => $innerBoxIsScrolled");
                      return [
                        SliverPersistentHeader(
                          delegate: AreaPersistentTabar(
                            tabSize: aRef.asData!.value.length,
                          ),
                          pinned: true,
                          floating: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        ...Iterable.generate(
                          aRef.asData!.value.length,
                        ).map(
                          (idx) {
                            return GridView.builder(
                              itemCount: aRef.asData!.value.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 9 / 14,
                                mainAxisSpacing: Sizes.size5,
                                crossAxisSpacing: Sizes.size5,
                              ),
                              itemBuilder: (context, index) {
                                final AraeModel item =
                                    aRef.asData!.value[index];
                                AreaPosition areaPosition = item.position;
                                final distance = _getDistance(
                                  LatLng(areaPosition.lat, areaPosition.lng),
                                  LatLng(areaPosition.lat, areaPosition.lng),
                                );
                                return Column(
                                  children: [
                                    Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 9 / 14,
                                          child: FadeInImage.assetNetwork(
                                            fit: BoxFit.cover,
                                            placeholder:
                                                "assets/images/waterfall.jpeg",
                                            image: item.shotImg,
                                            // "https://plus.unsplash.com/premium_photo-1668241683570-958ed3a9156e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  // mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    // const Text(
                                                    //   "호",
                                                    // ),
                                                    RichText(
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                        text: item.nickName,
                                                        children: [
                                                          const TextSpan(
                                                            text: "(",
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "${item.interest})",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Gaps.h5,
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .userCheck,
                                                      size: Sizes.size14,
                                                      color: isDark
                                                          ? Colors
                                                              .amber.shade200
                                                          : Colors
                                                              .blue.shade400,
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
                                                    text:
                                                        "${item.location}($distance)",
                                                  ),
                                                ),
                                                // Gaps.v3,
                                                // RichText(
                                                //   maxLines: 1,
                                                //   text: const TextSpan(
                                                //     text: "위치(행복동)",
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
