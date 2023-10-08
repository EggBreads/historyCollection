import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeThemes extends StatelessWidget {
  const HomeThemes({
    super.key,
    required this.imgList,
    required this.maxHeight,
    required this.maxWidth,
  });

  final List<String> imgList;
  final double maxHeight;
  final double maxWidth;

  // late List<Widget> imageSliders;

  List<Widget> generateImgSlider(List<String> imgList) {
    return imgList
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: [
                    // Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: maxWidth,
                      height: maxHeight,
                    ),
                    // Positioned(
                    //   bottom: 0.0,
                    //   left: 0.0,
                    //   right: 0.0,
                    //   child: Container(
                    //     decoration: const BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           Color.fromARGB(200, 0, 0, 0),
                    //           Color.fromARGB(0, 0, 0, 0)
                    //         ],
                    //         begin: Alignment.bottomCenter,
                    //         end: Alignment.topCenter,
                    //       ),
                    //     ),
                    //     padding: const EdgeInsets.all(Sizes.size10),
                    //     child: Text(
                    //       'No. ${imgList.indexOf(item)} image',
                    //       style: const TextStyle(
                    //         color: Colors.white,
                    //         fontSize: Sizes.size20,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                )),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final double height = MediaQuery.of(context).size.height;
      return CarouselSlider(
        options: CarouselOptions(
          height: height / 2,
          viewportFraction: 1.0,
          autoPlay: true,
          enlargeCenterPage: false,
          autoPlayAnimationDuration: const Duration(
            seconds: 1,
          ),
        ),
        items: generateImgSlider(imgList),
        // items: imgList.map((i) {
        //   return Builder(
        //     builder: (BuildContext context) {
        //       return Container(
        //           width: MediaQuery.of(context).size.width,
        //           margin: const EdgeInsets.symmetric(horizontal: 5.0),
        //           decoration: const BoxDecoration(color: Colors.amber),
        //           child: Text(
        //             'text $i',
        //             style: const TextStyle(fontSize: 16.0),
        //           ));
        //     },
        //   );
        // }).toList(),
      );
    });
  }
}
