// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:proyectemos/commons/styles.dart';
//
// class CustomCarousel extends StatelessWidget {
//   final List<String> imgList;
//   final List<String> imgNameList;
//
//   const CustomCarousel({
//     Key? key,
//     required this.imgList,
//     required this.imgNameList,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final double shortestSide = MediaQuery.of(context).size.shortestSide;
//     final bool isMobile = shortestSide < 600;
//
//     final List<Widget> imageSliders = imgList
//         .map(
//           (item) => Container(
//             margin: isMobile ? EdgeInsets.all(5) : EdgeInsets.all(10),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               child: Stack(
//                 children: <Widget>[
//                   Image.network(
//                     fit: BoxFit.fitWidth,
//                     item,
//                     height: isMobile ? 600 : 1000,
//                     width: isMobile ? 400 : 600,
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [ThemeColors.red, Color.fromARGB(0, 0, 0, 0)],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                         ),
//                       ),
//                       padding: isMobile ? EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 20,
//                       ) : EdgeInsets.symmetric(
//                         vertical: 20,
//                         horizontal: 40,
//                       ),
//                       child: Text(
//                         imgNameList[imgList.indexOf(item)],
//                         style:  TextStyle(
//                           color: Colors.white,
//                           fontSize: isMobile ? 20 : 30,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//         .toList();
//
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 400,
//         aspectRatio: 3,
//         enlargeCenterPage: true,
//       ),
//       items: imageSliders,
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

class CustomCarousel extends StatelessWidget {
  final List<String> imgList;
  final List<String> imgNameList;

  const CustomCarousel({
    Key? key,
    required this.imgList,
    required this.imgNameList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;

    final List<Widget> imageSliders = imgList.map((item) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    children: [
                      Image.network(
                        item,
                        fit: BoxFit.fitWidth,
                        height: isMobile ? 600 : 1000,
                        width: isMobile ? 400 : 800,
                      ),
                      Text(
                        imgNameList[imgList.indexOf(item)],
                        style: TextStyle(
                          color: ThemeColors.gray,
                          fontSize: isMobile ? 20 : 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          margin: isMobile ? EdgeInsets.all(5) : EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Stack(
              children: <Widget>[
                Image.network(
                  fit: BoxFit.fitWidth,
                  item,
                  height: isMobile ? 600 : 1000,
                  width: isMobile ? 400 : 600,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ThemeColors.red, Color.fromARGB(0, 0, 0, 0)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: isMobile
                        ? EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    )
                        : EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: Text(
                      imgNameList[imgList.indexOf(item)],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 20 : 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    return CarouselSlider(
      options: CarouselOptions(
        height: 500,
        aspectRatio: 3,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }
}
